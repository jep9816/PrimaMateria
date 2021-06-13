//
//  XTRElementPropertiesViewController.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 4/17/16.
//  Copyright ©2021 xTrensa. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

struct XTRElementPropertiesViewControllerConfig {
    static let popupContentSize = CGSize(width: 1024.0, height: 768.0)

    enum PropertiesViewTypes {
        static let kPhysicalPropertiesView = 0
        static let kChemicalPropertiesView = 1
    }
}

class XTRElementPropertiesViewController: XTRSwapableViewController {

    @IBOutlet var segmentedControl: UISegmentedControl!
    @IBOutlet var swapView: UIView!

    var physicalView: UIView!
    var chemicalView: UIView!
        
    // MARK: - Initialization Methods

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    // MARK: - Internal Methods

    // MARK: - Miscellaneous Methods

    override func setupUIForAnimation(element: XTRElementModel) {
        super.setupUIForAnimation(element: element)

        for item in children {
            let controller = item as! XTRSwapableViewController
            controller.setupUIForAnimation(element: element)
        }
    }

    override func setupUI(element: XTRElementModel) {
        super.setupUI(element: element)

        setupSegmentedControlUI()
        
        for item in children {
            let controller = item as! XTRSwapableViewController
            controller.setupUI(element: element)
        }
    }

    func setupSegmentedControlUI() {
        let rect = segmentedControl.frame
        let newRect = CGRect(x: rect.origin.x, y: rect.origin.y, width: rect.size.width, height: 34)
        
        segmentedControl.frame = newRect
        segmentedControl.cornerRadius = VIEW_CORNER_RADIUS
        segmentedControl.masksToBounds = true
        segmentedControl.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        segmentedControl.setTitle(NSLocalizedString("physicalProperties", comment: ""), forSegmentAt: XTRElementPropertiesViewControllerConfig.PropertiesViewTypes.kPhysicalPropertiesView)
        segmentedControl.setTitle(NSLocalizedString("chemicalProperties", comment: ""), forSegmentAt: XTRElementPropertiesViewControllerConfig.PropertiesViewTypes.kChemicalPropertiesView)
        segmentedControl.selectedSegmentIndex = XTRElementPropertiesViewControllerConfig.PropertiesViewTypes.kPhysicalPropertiesView
    }

    func setupRx() {
        segmentedControl.rx.selectedSegmentIndex.subscribe(onNext: { [weak self] selectedSegmentIndex in
            guard let `self` = self else { return }
            switch selectedSegmentIndex {
            case XTRElementPropertiesViewControllerConfig.PropertiesViewTypes.kPhysicalPropertiesView:
                self.physicalView.isHidden = false
                self.chemicalView.isHidden = true

            case XTRElementPropertiesViewControllerConfig.PropertiesViewTypes.kChemicalPropertiesView:
                self.physicalView.isHidden = true
                self.chemicalView.isHidden = false

            default:
                break
            }
            self.segmentedControl.selectedSegmentIndex = selectedSegmentIndex
        }).disposed(by: disposeBag)
    }

    // MARK: - Action Methods

    // MARK: - View Management Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addChild(XTRElementPropertiesPhysicalViewController.loadFromNib())
        addChild(XTRElementPropertiesChemicalViewController.loadFromNib())
        
        children[XTRElementPropertiesViewControllerConfig.PropertiesViewTypes.kPhysicalPropertiesView].didMove(toParent: self)
        children[XTRElementPropertiesViewControllerConfig.PropertiesViewTypes.kChemicalPropertiesView].didMove(toParent: self)
        
        physicalView = children[XTRElementPropertiesViewControllerConfig.PropertiesViewTypes.kPhysicalPropertiesView].view
        chemicalView = children[XTRElementPropertiesViewControllerConfig.PropertiesViewTypes.kChemicalPropertiesView].view

        physicalView.frame = swapView.frame
        chemicalView.frame = swapView.frame
        
        view.addSubview(physicalView)
        view.addSubview(chemicalView)
        
        swapView.removeFromSuperview()

        setupRx()
    }

    override var shouldAutorotate: Bool {
        return false
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscape
    }

    // MARK: - Memory Management Methods

    deinit {
        segmentedControl = nil
        swapView = nil
    }
    
}
