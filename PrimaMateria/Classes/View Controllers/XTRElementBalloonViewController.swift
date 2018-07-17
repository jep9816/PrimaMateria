//
//  XTRElementBalloonViewController.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 4/15/16.
//  Copyright © 2018 xTrensa. All rights reserved.
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
    
    var disposeBag = DisposeBag()

    // MARK: - Initialization Methods
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    // MARK: - Internal Methods
    
    func setupUI() {
        let element = XTRDataSource.sharedInstance().elementAtIndex(XTRPropertiesStore.atomicNumber)
        
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
        wrapperView.layer.cornerRadius = 10.0
        wrapperView.clipsToBounds = true

        elementDetailsButton.rx.tap.subscribe(onNext: { [weak self] _ in
            let storyBoard = UIStoryboard.init(name: "ElementInspector", bundle: nil)
            let controller = storyBoard.instantiateViewController(withIdentifier: XTRElementInspectorViewController.nameOfClass) as! XTRElementInspectorViewController

            controller.modalPresentationStyle = .fullScreen
            controller.modalTransitionStyle = .crossDissolve
 
            XTRPropertiesStore.viewTitle = NSLocalizedString(PERIODIC_VIEW_TITLE, comment: "")
            XTRPropertiesStore.atomicNumber = XTRPropertiesStore.atomicNumber
            self?.present(controller, animated: XTRPropertiesStore.showTransitionsState, completion: nil)
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
