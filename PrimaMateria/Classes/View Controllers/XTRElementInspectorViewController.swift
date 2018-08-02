//
//  XTRElementInspectorViewController.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 4/15/16.
//  Copyright © 2018 xTrensa. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class XTRElementInspectorViewController: XTRSwapableViewController {
    
    @IBOutlet var segmentedControl: UISegmentedControl!
    @IBOutlet var barButtonItem: UIBarButtonItem!
    @IBOutlet var nextButton: UIButton!
    @IBOutlet var previousButton: UIButton!
    @IBOutlet var atomicNumberLabel: UILabel!
    @IBOutlet var atomicSymbolLabel: UILabel!
    @IBOutlet var casRegNoLabel: UILabel!
    @IBOutlet var groupLabel: UILabel!
    @IBOutlet var periodLabel: UILabel!
    @IBOutlet var seriesLabel: UILabel!
    @IBOutlet var titleItem: UINavigationItem!
    @IBOutlet var pageControl: XTRPageControl!
    @IBOutlet var swapView: UIView!
    var flag: Bool = true
    
    var disposeBag = DisposeBag()
    
    // MARK: - Initialization Methods
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
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
        var nextAtomicNumber = element!.atomicNumber + 1
        
        pageControl.updateCurrentLabel(atomicNumber: element!.atomicNumber)
        
        if nextAtomicNumber > XTRDataSource.sharedInstance.elementCount() {
            nextAtomicNumber = 1
        }
        
        if nextAtomicNumber - 1 < XTRDataSource.sharedInstance.elementCount() {
            pageControl.updateNextLabel(atomicNumber: nextAtomicNumber)
        }
        
        let nextElement = XTRDataSource.sharedInstance.element(index: nextAtomicNumber - 1)
        let nextTitle = "▶︎ \(nextElement.name!)"
        
        nextButton.setTitle(nextTitle, for: UIControlState())
        nextButton.setTitle(nextTitle, for: .highlighted)
        nextButton.setTitle(nextTitle, for: .selected)
        
        pageControl.populateRightLabel(name: nextElement.name!)
        
        var previousAtomicNumber = element!.atomicNumber - 1
        
        if previousAtomicNumber < 1 {
            previousAtomicNumber = XTRDataSource.sharedInstance.elementCount()
        }
        
        if previousAtomicNumber > 0 {
            pageControl.updatePreviousLabel(atomicNumber: previousAtomicNumber)
        }
        
        let previousElement = XTRDataSource.sharedInstance.element(index: previousAtomicNumber - 1)
        let previousTitle = "◀︎ \(previousElement.name!)"
        
        previousButton.setTitle(previousTitle, for: UIControlState())
        previousButton.setTitle(previousTitle, for: .highlighted)
        previousButton.setTitle(previousTitle, for: .selected)
        
        pageControl.populateLeftLabel(name: previousElement.name!)
    }
    
    override func addChildViewController(_ aViewController: UIViewController) {
        super.addChildViewController(aViewController)
        
        aViewController.view.frame = swapView.frame
        aViewController.view.bounds = swapView.bounds
        aViewController.view.isHidden = true
        
        view.addSubview(aViewController.view)
    }
    
    func addChildViewController(name: String, className: String) {
        let storyboard = UIStoryboard(name: name, bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: className)
        
        addChildViewController(viewController)
    }
    
    func animateForDirection(_ direction: String) {
        setupUI(element: element!)
        
        if XTRPropertiesStore.showTransitionsState {
            let currentView: UIView = view
            let tempView = currentView.superview!
            let animation = CATransition()
            
            currentView.removeFromSuperview()
            
            animation.duration = 1.0
            animation.type = kCATransitionReveal
            animation.subtype = (direction == "Next") ? kCATransitionFromLeft: kCATransitionFromRight
            animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
            
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
        
        for item in childViewControllers {
            let controller = item as! XTRSwapableViewController
            controller.setupUI(element: element)
        }
        
        Observable.of(
            mapToObserver(button: previousButton)
            ).merge().subscribe(onNext: { [weak self] sender in
                self?.previousElement(sender)
            }).disposed(by: disposeBag)
        
        Observable.of(
            mapToObserver(button: nextButton)
            ).merge().subscribe(onNext: { [weak self] sender in
                self?.nextElement(sender)
            }).disposed(by: disposeBag)
        
        self.barButtonItem!.rx.tap.subscribe { [weak self] _ in
                self?.dismiss(animated: XTRPropertiesStore.showTransitionsState, completion: nil)
                NotificationCenter.default.post(name: .inspectorDismissedNotification, object: nil)
            }.disposed(by: disposeBag)
    }
    
    func setupSegmentedControlUI() {
        let rect = segmentedControl.frame
        let newRect = CGRect(x: rect.origin.x, y: rect.origin.y, width: rect.size.width, height: 34.0)
        
        segmentedControl.frame = newRect
        segmentedControl.setTitle(NSLocalizedString("atomicStructure", comment: ""), forSegmentAt: 0)
        segmentedControl.setTitle(NSLocalizedString("elementProperties", comment: ""), forSegmentAt: 1)
        segmentedControl.setTitle(NSLocalizedString("nuclidesIsotopes", comment: ""), forSegmentAt: 2)
        segmentedControl.setTitle(NSLocalizedString("spectrum", comment: ""), forSegmentAt: 3)
        segmentedControl.setTitle(NSLocalizedString("generalInfo", comment: ""), forSegmentAt: 4)
        segmentedControl.rx.selectedSegmentIndex.subscribe(onNext: { [weak self] selectedSegmentIndex in
            let viewController = self?.childViewControllers[selectedSegmentIndex]
            
            for controller in (self?.childViewControllers)! {
                controller.view.isHidden = true
                viewController?.view.isHidden = false
            }
        }).disposed(by: disposeBag)
    }
    
    // MARK: - Action Methods
    
    @objc func nextElement(_ sender: UIButton) {
        var atomicNumber = element!.atomicNumber + 1
        
        if atomicNumber > XTRDataSource.sharedInstance.elementCount() {
            atomicNumber = 1
        }
        
        element = XTRDataSource.sharedInstance.element(index: atomicNumber - 1)
        animateForDirection("Next")
    }
    
    @objc func previousElement(_ sender: UIButton) {
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
        
        let swipeNextElement = UISwipeGestureRecognizer(target: self, action: #selector(nextElement(_:)))
        let swipePreviousElement = UISwipeGestureRecognizer(target: self, action: #selector(previousElement(_:)))

        nextButton.titleLabel!.textAlignment = .right
        previousButton.titleLabel!.textAlignment = .left
        swapView.removeFromSuperview()
        
        addChildViewController(name: StoryBoardName.AtomicStructure, className: XTRAtomicStructureViewController.nameOfClass)
        addChildViewController(name: StoryBoardName.ElementProperties, className: XTRElementPropertiesViewController.nameOfClass)
        addChildViewController(name: StoryBoardName.NuclidesIsotopes, className: XTRNuclidesIsotopesViewController.nameOfClass)
        addChildViewController(name: StoryBoardName.Spectrum, className: XTRSpectrumViewController.nameOfClass)
        addChildViewController(name: StoryBoardName.GeneralInfo, className: XTRGeneralInfoViewController.nameOfClass)
        
        childViewControllers[0].view.isHidden = false
        
        swipeNextElement.direction = UISwipeGestureRecognizerDirection.right
        view.addGestureRecognizer(swipeNextElement)
        
        swipePreviousElement.direction = UISwipeGestureRecognizerDirection.left
        view.addGestureRecognizer(swipePreviousElement)
        NotificationCenter.default.addObserver(self, selector: #selector(atomicStructureZoomed(_:)), name: .notificationAtomicStructureZoomed, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        barButtonItem.title = "◀︎ \(XTRPropertiesStore.viewTitle)"
        element = XTRDataSource.sharedInstance.element(index: XTRPropertiesStore.atomicNumber)
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
        nextButton.isUserInteractionEnabled = flag
        previousButton.isUserInteractionEnabled = flag
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
        swapView = nil
        nextButton = nil
        previousButton = nil
        titleItem = nil
        pageControl = nil
    }
    
}
