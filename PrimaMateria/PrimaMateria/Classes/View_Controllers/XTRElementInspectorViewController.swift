//
//  XTRElementInspectorViewController.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 4/15/16.
//  Copyright © 2018 xTrensa. All rights reserved.
//

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
    @IBOutlet var pageItemView : UIView!
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
        let atomicNumber = element!.atomicNumber
        let currentLabel = pageItemView.subviews[atomicNumber + 1] as! UILabel
        var nextAtomicNumber = element!.atomicNumber + 1
        
        currentLabel.font = UIFont.systemFont(ofSize: 10.0)
        currentLabel.textColor = UIColor.white
        
        if nextAtomicNumber > XTRDataSource.sharedInstance().elementCount() {
            nextAtomicNumber = 1
        }
        
        if nextAtomicNumber - 1 < XTRDataSource.sharedInstance().elementCount()  {
            let localNextLabel = pageItemView.subviews[nextAtomicNumber + 1] as! UILabel
            localNextLabel.font = UIFont.systemFont(ofSize: 10.0)
            localNextLabel.textColor = UIColor.darkGray
        }
        
        let nextElement = XTRDataSource.sharedInstance().elementAtIndex(nextAtomicNumber - 1)
        let nextTitle = " ▶︎ \(nextElement.name!)"
        
        nextButton.setTitle(nextTitle, for: UIControlState())
        nextButton.setTitle(nextTitle, for: .highlighted)
        nextButton.setTitle(nextTitle, for: .selected)
        
        nextLabel.text = " Swipe Right for \(nextElement.name!)"
        
        var previousAtomicNumber = element!.atomicNumber - 1
        
        if previousAtomicNumber < 1 {
            previousAtomicNumber = XTRDataSource.sharedInstance().elementCount()
        }
        
        if previousAtomicNumber > 0 {
            let localPreviousLabel = pageItemView.subviews[previousAtomicNumber + 1] as! UILabel
            localPreviousLabel.font = UIFont.systemFont(ofSize: 10.0)
            localPreviousLabel.textColor = UIColor.darkGray
        }
        
        let previousElement = XTRDataSource.sharedInstance().elementAtIndex(previousAtomicNumber - 1)
        let previousTitle = " ◀︎ \(previousElement.name!)"
        
        previousButton.setTitle(previousTitle, for: UIControlState())
        previousButton.setTitle(previousTitle, for: .highlighted)
        previousButton.setTitle(previousTitle, for: .selected)
        previousLabel.text = " Swipe Left for \(previousElement.name!)"
    }
    
    func setupPageItemView() {
        var rect = CGRect(x: 4, y: 30, width: 8, height: 8)
        let count = XTRDataSource.sharedInstance().elementCount() - 1
        
        for _ in 0...count {
            let label = UILabel(frame: rect)
            label.text = "●"
            label.textAlignment = .center
            label.font = UIFont.systemFont(ofSize: 10.0)
            label.textColor = UIColor.darkGray
            label.backgroundColor = UIColor.clear
            pageItemView.addSubview(label)
            rect = CGRect(x: label.frame.origin.x + 8.6, y: 30, width: 8, height: 8)
        }
        view.bringSubview(toFront: pageItemView)
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
        let defaultState = XTRPropertiesStore.showTransitionsState
        
        if defaultState {
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
        view.bringSubview(toFront: pageItemView)
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
        setupPageItemView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let atomicNumber = XTRPropertiesStore.atomicNumber
        barButtonItem.title = "◀︎ \(XTRPropertiesStore.viewTitle)"
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
    }
    
}
