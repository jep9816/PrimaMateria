//
//  XTRPeriodicTableViewController.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 4/15/16.
//  Copyright © 2016 xTrensa. All rights reserved.
//

@objc class XTRPeriodicTableViewController : UIViewController  {
    @IBOutlet var swapView : UIView!
    
    var molecularCalculatorState : Bool?
    var elementBalloonViewController : XTRElementBalloonViewController?
    var molecularCalculatorViewController : XTRMolecularCalculatorViewController?
    
    // MARK: - Initialization Methods
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    // MARK: - Internal Methods
    
    func showElementPanelForElementAtIndex(anIndex: UInt) {
        XTRPropertiesStore.storeViewTitle(self.title)
        XTRPropertiesStore.storeAtomicNumber(anIndex)
        self.performSegueWithIdentifier(SHOW_INSPECTOR_FROM_PERIODIC_TABLE, sender: self)
    }
    
    func setupPopUp() {
        self.elementBalloonViewController = XTRAppDelegate.storyboard().instantiateViewControllerWithIdentifier("XTRElementBalloonViewController") as? XTRElementBalloonViewController
        let contentSize : CGSize = CGSizeMake(324.0, 210.0)
        self.elementBalloonViewController!.preferredContentSize = contentSize
        self.elementBalloonViewController!.modalPresentationStyle = UIModalPresentationStyle.Popover
    }
    
    func toggleMolecularCalculatorState(aFlag: Bool) {
        if (!aFlag) {
            self.molecularCalculatorState = false
            self.molecularCalculatorViewController!.view.removeFromSuperview()
            self.molecularCalculatorViewController!.viewWillDisappear(true)
        } else {
            self.molecularCalculatorState = true
            self.view.addSubview(self.molecularCalculatorViewController!.view)
        }
    }
    
    // MARK: - Action Methods
    
    @IBAction func showPopupForButton(sender: UIButton) {
        XTRPropertiesStore.storeViewTitle(self.title)
        XTRPropertiesStore.storeAtomicNumber(sender.tag)
        
        let aRect: CGRect = CGRectMake(10, 10, 15, 15)
        self.elementBalloonViewController!.popoverPresentationController!.sourceRect = aRect
        self.elementBalloonViewController!.popoverPresentationController!.sourceView = sender
        self.presentViewController(self.elementBalloonViewController!, animated:true, completion:nil)
    }
    
    @IBAction func showMolecularCalculator(sender: UISwitch) {
        self.toggleMolecularCalculatorState(sender.on)
    }
    
    @IBAction func showElementInspector(sender: UIButton) {
        if (self.molecularCalculatorState!.boolValue) {
            let element : XTRElement = XTRDataSource.sharedInstance().elementAtIndex(UInt(sender.tag))
            self.molecularCalculatorViewController!.setElement(element)
        } else {
            let defaultState : Bool? = XTRPropertiesStore.retreiveElementBubblesState()
            
            if (defaultState!.boolValue) {
                self.showPopupForButton(sender)
            } else {
                self.showElementPanelForElementAtIndex(UInt(sender.tag))
            }
        }
    }
    
    // MARK: mark - Notification Methods
    
    func closeBubble(aNotification: NSNotification) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: - View Management Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.molecularCalculatorViewController = XTRAppDelegate.storyboard().instantiateViewControllerWithIdentifier("XTRMolecularCalculatorViewController") as? XTRMolecularCalculatorViewController
        self.molecularCalculatorViewController!.view.frame = self.swapView.frame
        self.swapView.removeFromSuperview()
        self.setupPopUp()
        self.toggleMolecularCalculatorState(false)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(XTRPeriodicTableViewController.closeBubble(_:)), name: NOTIFICATION_INSPECTOR_DISMISSED, object: nil)
    }
    
    override func shouldAutorotate() -> Bool {
        return true
    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return [UIInterfaceOrientationMask.LandscapeLeft, UIInterfaceOrientationMask.LandscapeRight]
    }
    
    // MARK: - Memory Management Methods
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: NOTIFICATION_INSPECTOR_DISMISSED, object: nil)
        self.swapView = nil
    }
}
