//
//  XTRElementInspectorViewController.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 4/15/16.
//  Copyright © 2016 xTrensa. All rights reserved.
//

@objc class XTRElementInspectorViewController : XTRSwapableViewController {
    @IBOutlet weak var barButtonItem : UIBarButtonItem!
    @IBOutlet weak var nextButton : UIButton!
    @IBOutlet weak var previousButton : UIButton!
    @IBOutlet weak var atomicNumberLabel : UILabel!
    @IBOutlet weak var atomicSymbolLabel : UILabel!
    @IBOutlet weak var casRegNoLabel : UILabel!
    @IBOutlet weak var groupLabel : UILabel!
    @IBOutlet weak var nextLabel : UILabel!
    @IBOutlet weak var periodLabel : UILabel!
    @IBOutlet weak var previousLabel : UILabel!
    @IBOutlet weak var seriesLabel : UILabel!
    @IBOutlet weak var titleItem : UINavigationItem!
    @IBOutlet weak var pageItemView : UIView!
    @IBOutlet var swapView : UIView!
    
    // MARK: - Initialization Methods
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    // MARK: - Internal Methods
    
    func assignAtomicSymbolTextFieldProperties() {
        self.atomicSymbolLabel.text = self.element!.symbol()
        self.atomicSymbolLabel.textColor = self.element!.standardConditionColor()
        self.atomicSymbolLabel.backgroundColor = self.element!.seriesColor()
    }
    
    func assignOtherLabels() {
        self.atomicNumberLabel.text = self.element!.atomicNumber().stringValue
        self.titleItem.title = self.element!.nameString()
        self.periodLabel.text = self.element!.periodString()
        self.groupLabel.text = self.element!.groupString()
        self.seriesLabel.text = self.element!.seriesString()
        self.casRegNoLabel.text = self.element!.casRegNoString()
    }
    
    func assignNavigationHints() {
        let atomicNumber : Int = self.element!.atomicNumber().integerValue
        let currentLabel : UILabel = self.pageItemView.subviews[atomicNumber + 1] as! UILabel
        var nextAtomicNumber : Int = self.element!.atomicNumber().integerValue + 1
        
        currentLabel.font = UIFont.systemFontOfSize(12.0)
        currentLabel.textColor = UIColor.whiteColor()
        
        if (nextAtomicNumber > Int(XTRDataSource.sharedInstance().elementCount())) {
            nextAtomicNumber = 1
        }
        
        if(nextAtomicNumber - 1 < Int(XTRDataSource.sharedInstance().elementCount())) {
            let localNextLabel : UILabel = self.pageItemView.subviews[nextAtomicNumber + 1] as! UILabel
            localNextLabel.font = UIFont.systemFontOfSize(10.0)
            localNextLabel.textColor = UIColor.darkGrayColor()
        }
        
        let nextElement : XTRElement = XTRDataSource.sharedInstance().elementAtIndex(UInt(nextAtomicNumber) - 1)
        let nextTitle : String = String.init(format: "%@ ▶︎ ", nextElement.name()!)
        self.nextButton.setTitle(nextTitle, forState: UIControlState.Normal)
        self.nextButton.setTitle(nextTitle, forState: UIControlState.Highlighted)
        self.nextButton.setTitle(nextTitle, forState: UIControlState.Selected)
        
        self.nextLabel.text = String.init(format: "Swipe Right for %@ ", nextElement.name()!)
        
        var previousAtomicNumber : Int = self.element!.atomicNumber().integerValue - 1
        if (previousAtomicNumber < 1) {
            previousAtomicNumber = Int(XTRDataSource.sharedInstance().elementCount())
        }
        if(previousAtomicNumber > 0) {
            let localPreviousLabel : UILabel = self.pageItemView.subviews[previousAtomicNumber + 1] as! UILabel
            localPreviousLabel.font = UIFont.systemFontOfSize(10.0)
            localPreviousLabel.textColor = UIColor.darkGrayColor()
        }
        
        let previousElement : XTRElement = XTRDataSource.sharedInstance().elementAtIndex(UInt(previousAtomicNumber) - 1)
        let previousTitle : String = String.init(format: " ◀︎ %@", previousElement.name()!)
        self.previousButton.setTitle(previousTitle, forState: UIControlState.Normal)
        self.previousButton.setTitle(previousTitle, forState: UIControlState.Highlighted)
        self.previousButton.setTitle(previousTitle, forState: UIControlState.Selected)
        self.previousLabel.text = String.init(format: " Swipe Left for %@", previousElement.name()!)
    }
    
    func setupPageItemView() {
        var rect : CGRect = CGRectMake(4, 30, 8, 8)
        let count : Int = Int(XTRDataSource.sharedInstance().elementCount() - 1)
        
        for _ in 0...count {
            let label : UILabel = UILabel(frame: rect)
            label.text = "●"
            label.textAlignment = NSTextAlignment.Center
            label.font = UIFont.systemFontOfSize(10.0)
            label.textColor = UIColor.darkGrayColor()
            label.backgroundColor = UIColor.clearColor()
            self.pageItemView.addSubview(label)
            rect = CGRectMake(label.frame.origin.x + 8.6, 30, 8, 8)
        }
        self.view.bringSubviewToFront(self.pageItemView)
    }
    
    override func addChildViewController(aViewController: UIViewController) {
        super.addChildViewController(aViewController)
        aViewController.view.frame = self.swapView.frame
        aViewController.view.bounds = self.swapView.bounds
        aViewController.view.hidden = true
        self.view.addSubview(aViewController.view)
    }
    
    func animateForDirection(direction: String) {
        self.setupUI()
        let defaultState : Bool = XTRPropertiesStore.retreiveShowTransitionsState()
        
        if (defaultState.boolValue) {
            let currentView : UIView = self.view
            let theWindow : UIView = currentView.superview!
            
            currentView.removeFromSuperview()
            
            let animation : CATransition = CATransition.init()
            animation.duration = 1.0
            animation.type = kCATransitionReveal
            animation.subtype = (direction == "Next") ? kCATransitionFromLeft : kCATransitionFromRight
            animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
            theWindow.layer.addAnimation(animation, forKey: "SwitchInspectorView")
            theWindow.addSubview(currentView)
            theWindow.layer.removeAnimationForKey("SwitchInspectorView")
        }
    }
    
    // MARK: - Misellaneous Methods
    
    override func setupUI() {
        if (self.element != nil) {
            self.assignAtomicSymbolTextFieldProperties()
            self.assignOtherLabels()
            self.assignNavigationHints()
            
            for index in 0...self.childViewControllers.count - 1 {
                let controller : XTRSwapableViewController = self.childViewControllers[Int(index)] as! XTRSwapableViewController
                controller.element = self.element
                controller.setupUI()
            }
        }
        self.view.bringSubviewToFront(self.pageItemView)
    }
    
    // MARK: - Action Methods
    
    @IBAction func dismiss(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
        NSNotificationCenter.defaultCenter().postNotificationName(NOTIFICATION_INSPECTOR_DISMISSED, object: nil)
    }
    
    @IBAction func swapViews(sender: UISegmentedControl) {
        let viewController : UIViewController = self.childViewControllers[sender.selectedSegmentIndex]
        for index in 0...self.childViewControllers.count - 1 {
            let controller : XTRSwapableViewController = self.childViewControllers[Int(index)] as! XTRSwapableViewController
            controller.view.hidden = true
            viewController.view.hidden = false
        }
    }
    
    @IBAction func nextElement(sender: UIButton) {
        var atomicNumber : Int = self.element!.atomicNumber().integerValue + 1
        if (atomicNumber > Int(XTRDataSource.sharedInstance().elementCount())) {
            atomicNumber = 1
        }
        self.element = XTRDataSource.sharedInstance().elementAtIndex(UInt(atomicNumber) - 1)
        self.animateForDirection("Next")
    }
    
    @IBAction func previousElement(sender: UIButton) {
        var atomicNumber : Int = self.element!.atomicNumber().integerValue - 1
        if (atomicNumber < 1) {
            atomicNumber = Int(XTRDataSource.sharedInstance().elementCount())
        }
        self.element = XTRDataSource.sharedInstance().elementAtIndex(UInt(atomicNumber) - 1)
        self.animateForDirection("Previous")
    }
    
    // MARK: - View Management Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.nextButton.titleLabel!.textAlignment = NSTextAlignment.Right
        self.previousButton.titleLabel!.textAlignment = NSTextAlignment.Left
        self.swapView.removeFromSuperview()
        
        let storyboard : UIStoryboard = XTRAppDelegate.storyboard()
        self.addChildViewController(storyboard.instantiateViewControllerWithIdentifier("XTRAtomicStructureViewController"))
        self.addChildViewController(storyboard.instantiateViewControllerWithIdentifier("XTRElementPropertiesViewController"))
        self.addChildViewController(storyboard.instantiateViewControllerWithIdentifier("XTRNuclidesIsotopesViewController"))
        self.addChildViewController(storyboard.instantiateViewControllerWithIdentifier("XTRSpectrumViewController"))
        self.addChildViewController(storyboard.instantiateViewControllerWithIdentifier("XTRGeneralInfoViewController"))
        self.childViewControllers[0].view.hidden = false
        
        let swipeNextElement : UISwipeGestureRecognizer = UISwipeGestureRecognizer.init(target: self, action: #selector(XTRElementInspectorViewController.nextElement(_:)))
        swipeNextElement.direction = UISwipeGestureRecognizerDirection.Right
        self.view.addGestureRecognizer(swipeNextElement)
        
        let swipePreviousElement : UISwipeGestureRecognizer = UISwipeGestureRecognizer.init(target:self, action: #selector(XTRElementInspectorViewController.previousElement(_:)))
        swipePreviousElement.direction = UISwipeGestureRecognizerDirection.Left
        self.view.addGestureRecognizer(swipePreviousElement)
        self.setupPageItemView()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let atomicNumber : NSNumber = XTRPropertiesStore.retreiveAtomicNumber()
        self.barButtonItem.title = String.init(format: " ◀︎ %@", arguments: [XTRPropertiesStore.retreiveViewTitle()])
        self.element = XTRDataSource.sharedInstance().elementAtIndex(UInt(atomicNumber))
        self.setupUI()
    }
    
    override func viewWillDisappear(animated: Bool) {
        self.dismissViewControllerAnimated(true, completion: nil)
        super.viewWillDisappear(animated)
    }
    
    override func shouldAutorotate() -> Bool {
        return true
    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return [UIInterfaceOrientationMask.LandscapeLeft, UIInterfaceOrientationMask.LandscapeRight]
    }
    
    // MARK: - Memory Management Methods
    
    deinit {
        self.atomicNumberLabel = nil
        self.atomicSymbolLabel = nil
        self.barButtonItem = nil
        self.periodLabel = nil
        self.groupLabel = nil
        self.seriesLabel = nil
        self.casRegNoLabel = nil
        self.swapView = nil
        self.nextButton = nil
        self.previousButton = nil
        self.nextLabel = nil
        self.previousLabel = nil
        self.titleItem = nil
    }
}
