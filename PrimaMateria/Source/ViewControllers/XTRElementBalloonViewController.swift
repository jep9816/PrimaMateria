//
//  XTRElementBalloonViewController.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 4/15/16.
//  Copyright ©2021 xTrensa. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class XTRElementBalloonViewController: UIViewController {

    @IBOutlet var elementNameLabel: UILabel!
    @IBOutlet var atomicNumberLabel: UILabel!
    @IBOutlet var atomicMassLabel: UILabel!
    @IBOutlet var boilingPointLabel: UILabel!
    @IBOutlet var meltingPointLabel: UILabel!
    @IBOutlet var wrapperView: UIView!
    @IBOutlet var elementDetailsButton: XTRGeneralButton!

    var disposeBag: DisposeBag = DisposeBag()

    // MARK: - Initialization Methods

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }

    // MARK: - Internal Methods

    func setupUI() {
        let element = XTRDataSource.sharedInstance.element(index: XTRPropertiesStore.atomicNumber)

        title = NSLocalizedString("elementBalloon", comment: "")

        elementNameLabel.textColor = element.standardConditionColor
        elementNameLabel.backgroundColor = element.seriesColor
        elementNameLabel.text = " \(element.name!)"

        atomicNumberLabel.text = " \(String(element.atomicNumber))"
        atomicMassLabel.text = " \(element.atomicMassAggregate)"
        boilingPointLabel.text = " \(element.value(forKeyPath: ELEMENT_BOILING_POINT)!)"
        meltingPointLabel.text = " \(element.value(forKeyPath: ELEMENT_MELTING_POINT)!)"
    }

    // MARK: - View Management Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        wrapperView.cornerRadius = VIEW_CORNER_RADIUS
        wrapperView.clipsToBounds = true

        elementDetailsButton.rx.tap.subscribe(onNext: { [weak self] _ in
            self?.showElementPanelForElement(index: XTRPropertiesStore.atomicNumber, controller: self!)
        }).disposed(by: disposeBag)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupUI()
    }

    override var shouldAutorotate: Bool {
        return false
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscape
    }

    // MARK: - Memory Management Methods

    deinit {
        elementNameLabel = nil
        atomicNumberLabel = nil
        atomicMassLabel = nil
        boilingPointLabel = nil
        meltingPointLabel = nil
        wrapperView = nil
        elementDetailsButton = nil
    }

}
