//
//  XTRPeriodicTableViewController.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 4/15/16.
//  Copyright ©2021 xTrensa. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SwiftUI

struct XTRPeriodicTableViewControllerConfig {
    static let buttonRect = CGRect(x: 0, y: 0, width: 52, height: 54)
    static let preferredContentSize = CGSize(width: 324.0, height: 210.0)
}

class XTRPeriodicTableViewController: UIViewController {

    @IBOutlet var navigationBar: UINavigationBar!
    @IBOutlet var molecularCalculatorSwitch: UISwitch!
    @IBOutlet var elementButtonView: UIView!
    @IBOutlet var molecularCalculatorWrapperView: UIView!

    var molecularCalculatorState: Bool = false
    var molecularCalculatorView: SUIMolecularCalculatorView!
    var molecularCalculatorViewController: UIViewController!
    var disposeBag: DisposeBag = DisposeBag()

    // MARK: - Initialization Methods

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    // MARK: - Internal Methods

    func setupRx() {
        molecularCalculatorSwitch.rx.isOn
            .asObservable()
            .subscribe(onNext: { [weak self] newValue in
                self?.toggleMolecularCalculatorState(newValue)
            }).disposed(by: disposeBag)

        var observableArray: [Observable<UIButton>] = []

        let subViews = elementButtonView.subviews

        for view in subViews where view is XTRElementButton {
            observableArray.append(mapToObserver(button: view as! UIButton))
        }
        Observable.merge(observableArray).subscribe(onNext: { [weak self] sender in
            self?.displayElementInspector(sender)
        }).disposed(by: disposeBag)
    }

    func toggleMolecularCalculatorState(_ aFlag: Bool) {
        molecularCalculatorState = aFlag

        if aFlag {
            molecularCalculatorWrapperView.addSubview(molecularCalculatorViewController.view)
            addChild(molecularCalculatorViewController)
        } else {
            molecularCalculatorViewController.view.removeFromSuperview()
            molecularCalculatorViewController.removeFromParent()
        }
    }

    // MARK: - Action Methods

    func showPopupForButton(_ sender: UIButton) {
        let element = XTRDataSource.sharedInstance.element(index: sender.tag)
        let elementBalloon = SUIElementBalloonView()
        let environment: SUIElementBallonEnvironment = SUIElementBallonEnvironment(element: element)

        let elementBalloonViewController = UIHostingController(rootView: elementBalloon.environmentObject(environment))
        elementBalloonViewController.preferredContentSize = elementBalloonViewController.sizeThatFits(in: XTRPeriodicTableViewControllerConfig.preferredContentSize)

        elementBalloonViewController.modalPresentationStyle = .popover

        guard let popoverController = elementBalloonViewController.popoverPresentationController else { return }

        popoverController.sourceRect = XTRPeriodicTableViewControllerConfig.buttonRect
        popoverController.sourceView = sender
        popoverController.backgroundColor = XTRColorFactory.popupArrowColor

        present(elementBalloonViewController, animated: XTRPropertiesStore.showTransitionsState, completion: nil)
    }

    func displayElementInspector(_ sender: UIButton) {
        if molecularCalculatorState {
            let molecularCalculatorModel = SUIMolecularCalculatorModel()
            molecularCalculatorModel.element = XTRDataSource.sharedInstance.element(index: sender.tag)
            molecularCalculatorView.updateElement(molecularCalculatorModel)
        } else {
            if XTRPropertiesStore.elementBubblesState {
                showPopupForButton(sender)
            } else {
                let element = XTRDataSource.sharedInstance.element(index: sender.tag)
                showElementPanel(element: element, controller: self)
            }
        }
    }

    // MARK: mark - Notification Methods

    @objc func closeBubble(_ aNotification: Notification) {
        dismiss(animated: XTRPropertiesStore.showTransitionsState, completion: nil)
    }

    // MARK: - View Management Methods

    override func viewDidLoad() {
        super.viewDidLoad()
            
        let title = NSLocalizedString("periodicTableElements", comment: "")
        navigationBar.topItem?.title = title

        molecularCalculatorView = SUIMolecularCalculatorView()
        molecularCalculatorViewController = UIHostingController(rootView: molecularCalculatorView.environmentObject(SUIMolecularCalculatorEnvironment()))
        molecularCalculatorViewController.view.translatesAutoresizingMaskIntoConstraints = false
        molecularCalculatorViewController.view.frame = molecularCalculatorWrapperView.bounds

        setupRx()
        toggleMolecularCalculatorState(false)

        NotificationCenter.default.addObserver(self, selector: #selector(closeBubble(_:)), name: .inspectorDismissedNotification, object: nil)
        navigationController?.navigationBar.prefersLargeTitles = true
        molecularCalculatorSwitch.backgroundColor = XTRColorFactory.switchBackgroundColor
        molecularCalculatorSwitch.cornerRadius = SWITCH_CORNER_RADIUS
    }

    override var shouldAutorotate: Bool {
        return false
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscape
    }

    // MARK: - Memory Management Methods

    deinit {
        NotificationCenter.default.removeObserver(self, name: .inspectorDismissedNotification, object: nil)
        
        navigationBar = nil
        molecularCalculatorSwitch = nil
        elementButtonView = nil
        molecularCalculatorWrapperView = nil
    }

}
