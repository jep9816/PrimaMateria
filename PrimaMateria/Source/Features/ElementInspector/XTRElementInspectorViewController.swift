//
//  XTRElementInspectorViewController.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 4/15/16.
//  Copyright ©2023 xTrensa. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

struct XTRElementInspectorControllerConfig {
    static let popupContentSize = CGSize(width: 1024.0, height: 768.0)
    static let controllerFrameRect = CGRect(x: 0, y: 149, width: 1024, height: 574)
    static let controllerBoundsRect = CGRect(x: 0, y: 0, width: 1024, height: 574)

    enum ElementViewTypes {
        static let kAtomicStructure = 0
        static let kElementProperties = 1
        static let kNuclidesIsotopes = 2
        static let kSpectrum = 3
        static let kGeneralInfo = 4
    }
}

class XTRElementInspectorViewController: XTRSwapableViewController {

    @IBOutlet var segmentedControl: UISegmentedControl!
    @IBOutlet var barButtonItem: UIBarButtonItem!
    @IBOutlet var atomicNumberLabel: UILabel!
    @IBOutlet var atomicSymbolLabel: UILabel!
    @IBOutlet var casRegNoLabel: UILabel!
    @IBOutlet var groupLabel: UILabel!
    @IBOutlet var periodLabel: UILabel!
    @IBOutlet var seriesLabel: UILabel!
    @IBOutlet var titleItem: UINavigationItem!
    @IBOutlet var pageControl: XTRPageControl!

    var flag: Bool = true

    // MARK: - Initialization Methods

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    // MARK: - Action Methods

    // MARK: - Internal Methods

    func assignAtomicSymbolTextFieldProperties() {
        atomicSymbolLabel.text = element!.symbol
        atomicSymbolLabel.textColor = element!.standardConditionColor
        atomicSymbolLabel.backgroundColor = element!.seriesColor
    }

    func assignOtherLabels() {
        atomicNumberLabel.text = String(element!.atomicNumber)
        titleItem.title = element!.nameString()
        periodLabel.text = element!.period
        groupLabel.text = element!.groupString
        seriesLabel.text = element!.series
        casRegNoLabel.text = element!.casRegNoString
    }

    func assignNavigationHints() {
        let nextGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(nextElement(_:)))
        let previousGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(previousElement(_:)))
        let swipeNextElement = UISwipeGestureRecognizer(target: self, action: #selector(nextElement(_:)))
        let swipePreviousElement = UISwipeGestureRecognizer(target: self, action: #selector(previousElement(_:)))
        swipeNextElement.direction = UISwipeGestureRecognizer.Direction.right

        swipePreviousElement.direction = UISwipeGestureRecognizer.Direction.left

        pageControl.addGestureRecognizer(swipeNextElement)
        pageControl.addGestureRecognizer(swipePreviousElement)
        pageControl.nextLabel.addGestureRecognizer(nextGestureRecognizer)
        pageControl.previousLabel.addGestureRecognizer(previousGestureRecognizer)

        var nextAtomicNumber = element!.atomicNumber + 1

        pageControl.updateCurrentLabel(atomicNumber: element!.atomicNumber)

        if nextAtomicNumber > XTRDataSource.sharedInstance.elementCount() {
            nextAtomicNumber = 1
        }

        if nextAtomicNumber - 1 < XTRDataSource.sharedInstance.elementCount() {
            pageControl.updateNextLabel(atomicNumber: nextAtomicNumber)
        }

        let nextElement = XTRDataSource.sharedInstance.element(index: nextAtomicNumber - 1)

        pageControl.populateRightLabel(name: nextElement.name!)

        var previousAtomicNumber = element!.atomicNumber - 1

        if previousAtomicNumber < 1 {
            previousAtomicNumber = XTRDataSource.sharedInstance.elementCount()
        }

        if previousAtomicNumber > 0 {
            pageControl.updatePreviousLabel(atomicNumber: previousAtomicNumber)
        }

        let previousElement = XTRDataSource.sharedInstance.element(index: previousAtomicNumber - 1)

        pageControl.populateLeftLabel(name: previousElement.name!)
    }

    override func addChild(_ aViewController: UIViewController) {
        super.addChild(aViewController)

        aViewController.view.frame = XTRElementInspectorControllerConfig.controllerFrameRect
        aViewController.view.bounds = XTRElementInspectorControllerConfig.controllerBoundsRect
        aViewController.view.isHidden = true

        view.addSubview(aViewController.view)
    }

    func addChildViewController(viewController: UIViewController) {
        addChild(viewController)
    }

    func animateForDirection(_ direction: String) {
        assignAtomicSymbolTextFieldProperties()
        assignOtherLabels()
        assignNavigationHints()

        for item in children {
            let controller = item as! XTRSwapableViewController
            controller.setupUIForAnimation(element: element!)
        }

        if XTRPropertiesStore.showTransitionsState {
            let currentView: UIView = view
            let tempView = currentView.superview!
            let animation = CATransition()

            currentView.removeFromSuperview()

            animation.duration = 1.0
            animation.type = CATransitionType.reveal
            animation.subtype = (direction == "Next") ? CATransitionSubtype.fromLeft: CATransitionSubtype.fromRight
            animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)

            tempView.layer.add(animation, forKey: "SwitchInspectorView")
            tempView.addSubview(currentView)
            tempView.layer.removeAnimation(forKey: "SwitchInspectorView")
        }
    }

    // MARK: - Misellaneous Methods

    override func setupUI(element: XTRElementModel) {
        super.setupUI(element: element)

        setupSegmentedControlUI()

        assignAtomicSymbolTextFieldProperties()
        assignOtherLabels()
        assignNavigationHints()

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
        segmentedControl.setTitle(NSLocalizedString("atomicStructure", comment: ""), forSegmentAt: XTRElementInspectorControllerConfig.ElementViewTypes.kAtomicStructure)
        segmentedControl.setTitle(NSLocalizedString("elementProperties", comment: ""), forSegmentAt: XTRElementInspectorControllerConfig.ElementViewTypes.kElementProperties)
        segmentedControl.setTitle(NSLocalizedString("nuclidesIsotopes", comment: ""), forSegmentAt: XTRElementInspectorControllerConfig.ElementViewTypes.kNuclidesIsotopes)
        segmentedControl.setTitle(NSLocalizedString("spectrum", comment: ""), forSegmentAt: XTRElementInspectorControllerConfig.ElementViewTypes.kSpectrum)
        segmentedControl.setTitle(NSLocalizedString("generalInfo", comment: ""), forSegmentAt: XTRElementInspectorControllerConfig.ElementViewTypes.kGeneralInfo)
        segmentedControl.rx.selectedSegmentIndex.subscribe(onNext: { [weak self] selectedSegmentIndex in
            let viewController = self?.children[selectedSegmentIndex]

            for controller in (self?.children)! {
                controller.view.isHidden = true
                viewController?.view.isHidden = false
            }
            self?.view.bringSubviewToFront((self?.pageControl)!)
        }).disposed(by: disposeBag)
    }

    func setupRx() {
        barButtonItem!.rx.tap.subscribe { [weak self] _ in
            self?.dismiss(animated: XTRPropertiesStore.showTransitionsState, completion: nil)
            NotificationCenter.default.post(name: .inspectorDismissedNotification, object: nil)
            }.disposed(by: disposeBag)
    }

    // MARK: - Action Methods

    @objc func nextElement(_ sender: Any) {
        var atomicNumber = element!.atomicNumber + 1

        if atomicNumber > XTRDataSource.sharedInstance.elementCount() {
            atomicNumber = 1
        }

        element = XTRDataSource.sharedInstance.element(index: atomicNumber - 1)
        animateForDirection("Next")
    }

    @objc func previousElement(_ sender: Any) {
        var atomicNumber = element!.atomicNumber - 1

        if atomicNumber < 1 {
            atomicNumber = XTRDataSource.sharedInstance.elementCount()
        }

        element = XTRDataSource.sharedInstance.element(index: atomicNumber - 1)
        animateForDirection("Previous")
    }

    // MARK: - View Management Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupRx()

        addChildViewController(viewController: XTRAtomicStructureViewController.loadFromNib())
        addChildViewController(viewController: XTRElementPropertiesViewController.loadFromNib())
        addChildViewController(viewController: XTRNuclidesIsotopesViewController.loadFromNib())
        addChildViewController(viewController: XTRSpectrumViewController.loadFromNib())
        addChildViewController(viewController: XTRGeneralInfoViewController.loadFromNib())

        children[0].view.isHidden = false

        NotificationCenter.default.addObserver(self, selector: #selector(atomicStructureZoomed(_:)), name: .notificationAtomicStructureZoomed, object: nil)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        barButtonItem.title = NSLocalizedString("Close", comment: "")
        setupUI(element: element!)
    }

    override func viewWillDisappear(_ animated: Bool) {
        dismiss(animated: XTRPropertiesStore.showTransitionsState, completion: nil)

        super.viewWillDisappear(animated)
    }

    // MARK: - Notification Methods

    @objc func atomicStructureZoomed(_ aNotification: Notification) {
        flag = aNotification.object as! Bool

        segmentedControl.isUserInteractionEnabled = flag
        barButtonItem.isEnabled = flag
    }

    override var shouldAutorotate: Bool {
        return false
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscape
    }

    // MARK: - Memory Management Methods

    deinit {
        NotificationCenter.default.removeObserver(self, name: .notificationAtomicStructureZoomed, object: nil)
        atomicNumberLabel = nil
        atomicSymbolLabel = nil
        barButtonItem = nil
        periodLabel = nil
        groupLabel = nil
        seriesLabel = nil
        casRegNoLabel = nil
        titleItem = nil
        pageControl = nil
    }

}
