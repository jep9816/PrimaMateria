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

struct XTRPeriodicTableViewControllerConfig {
    static let buttonRect = CGRect(x: 0, y: 0, width: 52, height: 54)
    static let popupContentSize = CGSize(width: 324.0, height: 210.0)
}

class XTRPeriodicTableViewController: UIViewController {
    
    @IBOutlet var navigationBar: UINavigationBar!
    @IBOutlet var molecularCalculatorSwitch: UISwitch!
    @IBOutlet var elementButtonView: UIView!

    var molecularCalculatorState: Bool = false
    var elementBalloonViewController: XTRElementBalloonViewController!
    var molecularCalculatorViewController: XTRMolecularCalculatorViewController!
    var disposeBag: DisposeBag = DisposeBag()
    
    // MARK: - Initialization Methods
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    // MARK: - Internal Methods
    
    func setupPopUp() {
        elementBalloonViewController = XTRAppDelegate.storyboard().instantiateViewController(withIdentifier: XTRElementBalloonViewController.nameOfClass) as? XTRElementBalloonViewController
        elementBalloonViewController.preferredContentSize = XTRPeriodicTableViewControllerConfig.popupContentSize
        elementBalloonViewController.modalPresentationStyle = .popover
    }
    
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
            view.addSubview(molecularCalculatorViewController.view)
        } else {
            molecularCalculatorViewController.view.removeFromSuperview()
            molecularCalculatorViewController.viewWillDisappear(true)
        }
    }
    
    // MARK: - Action Methods
    
    func showPopupForButton(_ sender: UIButton) {
        guard let popoverController = elementBalloonViewController.popoverPresentationController else { return }
        
        XTRPropertiesStore.viewTitle = title!
        XTRPropertiesStore.atomicNumber = sender.tag
        
        popoverController.sourceRect = XTRPeriodicTableViewControllerConfig.buttonRect
        popoverController.sourceView = sender
        popoverController.backgroundColor = XTRColorFactory.popupArrowColor
        
        present(elementBalloonViewController, animated: XTRPropertiesStore.showTransitionsState, completion: nil)
    }
    
    func displayElementInspector(_ sender: UIButton) {
        if molecularCalculatorState {
            molecularCalculatorViewController.setElement(XTRDataSource.sharedInstance.element(index: sender.tag))
        } else {
            if XTRPropertiesStore.elementBubblesState {
                showPopupForButton(sender)
            } else {
                showElementPanelForElement(index: sender.tag, controller: self)
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
                
        title = NSLocalizedString(PERIODIC_VIEW_TITLE, comment: "")
        navigationBar.topItem?.title = title
        
        molecularCalculatorViewController = XTRAppDelegate.storyboard().instantiateViewController(withIdentifier: XTRMolecularCalculatorViewController.nameOfClass) as? XTRMolecularCalculatorViewController
        molecularCalculatorViewController.view.frame = CGRect(x: 235, y: 160, width: 380, height: 155)
        
        setupPopUp()
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
        molecularCalculatorSwitch = nil
        navigationBar = nil
    }
    
}
