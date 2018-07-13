//
//  XTRElementInspectorViewController.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 4/15/16.
//  Copyright © 2018 xTrensa. All rights reserved.
//

import UIKit

class XTRElementInspectorViewController : XTRSwapableViewController {
    
    @IBOutlet var segmentedControl: UISegmentedControl!
    @IBOutlet var barButtonItem : UIBarButtonItem!
    @IBOutlet var nextButton : UIButton!
    @IBOutlet var previousButton : UIButton!
    @IBOutlet var atomicNumberLabel : UILabel!
    @IBOutlet var atomicSymbolLabel : UILabel!
    @IBOutlet var casRegNoLabel : UILabel!
    @IBOutlet var groupLabel : UILabel!
    @IBOutlet var nextLabel : UILabel!
    @IBOutlet var periodLabel : UILabel!
    @IBOutlet var previousLabel : UILabel!
    @IBOutlet var seriesLabel : UILabel!
    @IBOutlet var titleItem : UINavigationItem!
    @IBOutlet var pageControl : XTRPageControl!
    @IBOutlet var swapView : UIView!
    
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
        
        if nextAtomicNumber > XTRDataSource.sharedInstance().elementCount() {
            nextAtomicNumber = 1
        }
        
        if nextAtomicNumber - 1 < XTRDataSource.sharedInstance().elementCount()  {
            pageControl.updateNextLabel(atomicNumber: nextAtomicNumber)
        }
        
        let nextElement = XTRDataSource.sharedInstance().elementAtIndex(nextAtomicNumber - 1)
        let nextTitle = "▶︎ \(nextElement.name!)"
        
        nextButton.setTitle(nextTitle, for: UIControlState())
        nextButton.setTitle(nextTitle, for: .highlighted)
        nextButton.setTitle(nextTitle, for: .selected)
        
        pageControl.populateRightLabel(name: nextElement.name!)
        
        var previousAtomicNumber = element!.atomicNumber - 1
        
        if previousAtomicNumber < 1 {
            previousAtomicNumber = XTRDataSource.sharedInstance().elementCount()
        }
        
        if previousAtomicNumber > 0 {
            pageControl.updatePreviousLabel(atomicNumber: previousAtomicNumber)
        }
        
        let previousElement = XTRDataSource.sharedInstance().elementAtIndex(previousAtomicNumber - 1)
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
    
    func animateForDirection(_ direction: String) {
        setupUI()
        
        if XTRPropertiesStore.showTransitionsState {
            let currentView : UIView = view
            let theWindow = currentView.superview!
            let animation = CATransition()

            currentView.removeFromSuperview()
            
            animation.duration = 1.0
            animation.type = kCATransitionReveal
            animation.subtype = (direction == "Next") ? kCATransitionFromLeft : kCATransitionFromRight
            animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
            theWindow.layer.add(animation, forKey: "SwitchInspectorView")
            theWindow.addSubview(currentView)
            theWindow.layer.removeAnimation(forKey: "SwitchInspectorView")
        }
    }
    
    // MARK: - Misellaneous Methods
    
    override func setupUI() {
        let rect = segmentedControl.frame
        let newRect = CGRect(x: rect.origin.x, y: rect.origin.y, width: rect.size.width, height: 34.0)
        
        segmentedControl.frame = newRect
        segmentedControl.setTitle(NSLocalizedString("atomicStructure", comment: ""), forSegmentAt: 0)
        segmentedControl.setTitle(NSLocalizedString("elementProperties", comment: ""), forSegmentAt: 1)
        segmentedControl.setTitle(NSLocalizedString("nuclidesIsotopes", comment: ""), forSegmentAt: 2)
        segmentedControl.setTitle(NSLocalizedString("spectrum", comment: ""), forSegmentAt: 3)
        segmentedControl.setTitle(NSLocalizedString("generalInfo", comment: ""), forSegmentAt: 4)

        if element != nil {
            assignAtomicSymbolTextFieldProperties()
            assignOtherLabels()
            assignNavigationHints()
            
            for index in 0..<childViewControllers.count {
                let controller = childViewControllers[Int(index)] as! XTRSwapableViewController
                controller.element = element
                controller.setupUI()
            }
        }
    }
    
    // MARK: - Action Methods
    
    @IBAction func dismiss(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
        NotificationCenter.default.post(name: .inspectorDismissedNotification, object: nil)
    }
    
    @IBAction func swapViews(_ sender: UISegmentedControl) {
        let viewController = childViewControllers[sender.selectedSegmentIndex]
        
        for index in 0..<childViewControllers.count {
            let controller = childViewControllers[Int(index)] as! XTRSwapableViewController
            controller.view.isHidden = true
            viewController.view.isHidden = false
        }
    }
    
    @IBAction func nextElement(_ sender: UIButton) {
        var atomicNumber = element!.atomicNumber + 1
        
        if atomicNumber > XTRDataSource.sharedInstance().elementCount() {
            atomicNumber = 1
        }
        
        element = XTRDataSource.sharedInstance().elementAtIndex(atomicNumber - 1)
        animateForDirection("Next")
    }
    
    @IBAction func previousElement(_ sender: UIButton) {
        var atomicNumber = element!.atomicNumber - 1
        
        if atomicNumber < 1 {
            atomicNumber = XTRDataSource.sharedInstance().elementCount()
        }
        
        element = XTRDataSource.sharedInstance().elementAtIndex(atomicNumber - 1)
        animateForDirection("Previous")
    }
    
    // MARK: - View Management Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let storyboard = XTRAppDelegate.storyboard()

        nextButton.titleLabel!.textAlignment = .right
        previousButton.titleLabel!.textAlignment = .left
        swapView.removeFromSuperview()
        
        addChildViewController(storyboard.instantiateViewController(withIdentifier: XTRAtomicStructureViewController.nameOfClass))
        addChildViewController(storyboard.instantiateViewController(withIdentifier: XTRElementPropertiesViewController.nameOfClass))
        addChildViewController(storyboard.instantiateViewController(withIdentifier: XTRNuclidesIsotopesViewController.nameOfClass))
        addChildViewController(storyboard.instantiateViewController(withIdentifier: XTRSpectrumViewController.nameOfClass))
        addChildViewController(storyboard.instantiateViewController(withIdentifier: XTRGeneralInfoViewController.nameOfClass))
        childViewControllers[0].view.isHidden = false
        
        let swipeNextElement = UISwipeGestureRecognizer(target: self, action: #selector(XTRElementInspectorViewController.nextElement(_:)))
        swipeNextElement.direction = UISwipeGestureRecognizerDirection.right
        view.addGestureRecognizer(swipeNextElement)
        
        let swipePreviousElement = UISwipeGestureRecognizer(target:self, action: #selector(XTRElementInspectorViewController.previousElement(_:)))
        swipePreviousElement.direction = UISwipeGestureRecognizerDirection.left
        view.addGestureRecognizer(swipePreviousElement)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let atomicNumber = XTRPropertiesStore.atomicNumber
        
        barButtonItem.title = "◀︎ \(NSLocalizedString(XTRPropertiesStore.viewTitle, comment: ""))"
        element = XTRDataSource.sharedInstance().elementAtIndex(atomicNumber)
        setupUI()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        dismiss(animated: true, completion: nil)
        super.viewWillDisappear(animated)
    }
    
    override var shouldAutorotate : Bool {
        return false
    }
    
    override var supportedInterfaceOrientations : UIInterfaceOrientationMask {
        return .landscape
    }
    
    // MARK: - Memory Management Methods
    
    deinit {
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
        nextLabel = nil
        previousLabel = nil
        titleItem = nil
        pageControl = nil
    }
    
}
