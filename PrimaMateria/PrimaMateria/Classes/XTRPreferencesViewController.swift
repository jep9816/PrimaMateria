//
//  XTRPreferencesViewController.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 4/22/16.
//  Copyright © 2016 xTrensa. All rights reserved.
//

@objc class XTRPreferencesViewController : UIViewController, UIPopoverPresentationControllerDelegate {
    @IBOutlet weak var appNameLabel : UILabel!
    @IBOutlet weak var cpyRightLabel : UILabel!
    
    @IBOutlet weak var seriesActinideButton : UIButton!
    @IBOutlet weak var seriesAlkaliEarthMetalButton : UIButton!
    @IBOutlet weak var seriesAlkaliMetalButton : UIButton!
    @IBOutlet weak var seriesHalogenButton : UIButton!
    @IBOutlet weak var seriesLanthanideButton : UIButton!
    @IBOutlet weak var seriesMetalButton : UIButton!
    @IBOutlet weak var seriesNobleGasButton : UIButton!
    @IBOutlet weak var seriesNonMetalButton : UIButton!
    @IBOutlet weak var seriesTransactinidesButton : UIButton!
    @IBOutlet weak var seriesTransitionMetalButton : UIButton!
    
    @IBOutlet weak var versionLabel : UILabel!
    @IBOutlet weak var elementBubbleSwitch : UISwitch!
    @IBOutlet weak var showTransitionsBubbleSwitch : UISwitch!
    @IBOutlet weak var splashScreenSwitch : UISwitch!
    @IBOutlet weak var webView : UIWebView!
    
    // MARK: - Initialization Methods
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    // MARK: - Internal Methods
    
    func colorSelected(notification: NSNotification) {
        guard let onObject = notification.object else { return }
        
        let redComponent : NSNumber = onObject.objectForKey(RED_COLOR_COMPONENT) as! NSNumber
        let greenComponent : NSNumber = onObject.objectForKey(GREEN_COLOR_COMPONENT) as! NSNumber
        let blueComponent : NSNumber = onObject.objectForKey(BLUE_COLOR_COMPONENT) as! NSNumber
        let seriesColorKey : String = onObject.objectForKey(SERIES_COLOR_KEY) as! String
        let aColor : UIColor = UIColor.init(red: CGFloat(redComponent), green: CGFloat(greenComponent), blue: CGFloat(blueComponent), alpha: 1.0)
        let colorData : NSData = NSKeyedArchiver.archivedDataWithRootObject(aColor)
        
        XTRPropertiesStore.storeColorData(colorData, forColorKey: seriesColorKey)
        
        if (seriesColorKey == SERIES_ACTINIDE) {
            self.updateSeriesButtonProperties(self.seriesActinideButton, aColor: aColor)
        } else if (seriesColorKey == SERIES_ALKALI_EARTH_METAL) {
            self.updateSeriesButtonProperties(self.seriesAlkaliEarthMetalButton, aColor: aColor)
        } else if (seriesColorKey == SERIES_ALKALI_METAL) {
            self.updateSeriesButtonProperties(self.seriesAlkaliMetalButton, aColor: aColor)
        } else if (seriesColorKey == SERIES_HALOGEN) {
            self.updateSeriesButtonProperties(self.seriesHalogenButton, aColor: aColor)
        } else if (seriesColorKey == SERIES_LANTHANIDE) {
            self.updateSeriesButtonProperties(self.seriesLanthanideButton, aColor: aColor)
        } else if (seriesColorKey == SERIES_METAL) {
            self.updateSeriesButtonProperties(self.seriesMetalButton, aColor: aColor)
        } else if (seriesColorKey == SERIES_NOBLE_GAS) {
            self.updateSeriesButtonProperties(self.seriesNobleGasButton, aColor: aColor)
        } else if (seriesColorKey == SERIES_NON_METAL) {
            self.updateSeriesButtonProperties(self.seriesNonMetalButton, aColor: aColor)
        } else if (seriesColorKey == SERIES_TRANSACTINIDES) {
            self.updateSeriesButtonProperties(self.seriesTransactinidesButton, aColor: aColor)
        } else if (seriesColorKey == SERIES_TRANSITION_METAL) {
            self.updateSeriesButtonProperties(self.seriesTransitionMetalButton, aColor: aColor)
        }
        
        NSNotificationCenter.defaultCenter().postNotificationName(NOTIFICATION_SERIES_COLOR_CHANGED, object: nil)
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func loadDocument(documentName: String, inView: UIWebView) {
        let aPath : String? = NSBundle(forClass: XTRElement.classForCoder()).pathForResource(documentName, ofType: nil)
        let url : NSURL = NSURL(fileURLWithPath: aPath!)
        let request : NSURLRequest = NSURLRequest(URL: url)
        
        webView.loadRequest(request)
    }
    
    func loadUserDefaults() {
        self.self.elementBubbleSwitch.on = XTRPropertiesStore.retreiveElementBubblesState()
        self.showTransitionsBubbleSwitch.on = XTRPropertiesStore.retreiveShowTransitionsState()
        self.splashScreenSwitch.on = XTRPropertiesStore.retreiveSplashScreenState()
    }
    
    func updateSeriesButtonProperties(aButton: UIButton, aColor: UIColor) {
        aButton.backgroundColor = aColor
        aButton.setTitleColor(aColor.inverseColor(), forState: UIControlState.Normal)
    }
    
    func populateSeriesColors() {
        self.updateSeriesButtonProperties(self.seriesActinideButton, aColor: XTRColorFactory.actinideColor())
        self.updateSeriesButtonProperties(self.seriesAlkaliEarthMetalButton, aColor: XTRColorFactory.alkaliEarthMetalColor())
        self.updateSeriesButtonProperties(self.seriesAlkaliMetalButton, aColor: XTRColorFactory.alkaliMetalColor())
        self.updateSeriesButtonProperties(self.seriesHalogenButton, aColor: XTRColorFactory.halogenColor())
        self.updateSeriesButtonProperties(self.seriesLanthanideButton, aColor: XTRColorFactory.lanthanideColor())
        self.updateSeriesButtonProperties(self.seriesMetalButton, aColor: XTRColorFactory.metalColor())
        self.updateSeriesButtonProperties(self.seriesNobleGasButton, aColor: XTRColorFactory.nobleGasColor())
        self.updateSeriesButtonProperties(self.seriesNonMetalButton, aColor: XTRColorFactory.nonMetalColor())
        self.updateSeriesButtonProperties(self.seriesTransactinidesButton, aColor: XTRColorFactory.transactinideColor())
        self.updateSeriesButtonProperties(self.seriesTransitionMetalButton, aColor: XTRColorFactory.transitionMetalColor())
    }
    
    func populateElementBubbleState(aFlag: Bool)  {
        XTRPropertiesStore.storeElementBubblesState(aFlag)
    }
    
    func populateShowTransitionsState(aFlag: Bool) {
        XTRPropertiesStore.storeShowTranitionsState(aFlag)
    }
    
    func populateSplashScreenState(aFlag: Bool) {
        XTRPropertiesStore.storeSplashScreenState(aFlag)
    }
    
    // MARK: - Action Methods
    
    @IBAction func setElementBubbleState(sender: UISwitch) {
        self.populateElementBubbleState(self.elementBubbleSwitch.on)
    }
    
    @IBAction func setShowTransitionsState(sender: UISwitch) {
        self.populateShowTransitionsState(self.showTransitionsBubbleSwitch.on)
    }
    
    @IBAction func setSplashScreenState(sender: UISwitch) {
        self.populateSplashScreenState(self.splashScreenSwitch.on)
    }
    
    @IBAction func showColorPicker(sender: UIButton) {
        let title : String = sender.titleLabel!.text!
        let aColor : UIColor = XTRColorFactory.colorForString(title)
        let colorPicker : XTRColorPickerViewController = XTRAppDelegate.storyboard().instantiateViewControllerWithIdentifier("XTRColorPickerViewController") as! XTRColorPickerViewController
        let popover : UIPopoverPresentationController?
        
        colorPicker.modalPresentationStyle = UIModalPresentationStyle.Popover
        colorPicker.preferredContentSize = CGSizeMake(270, 175)
        
        popover = colorPicker.popoverPresentationController! as UIPopoverPresentationController
        popover!.permittedArrowDirections = UIPopoverArrowDirection.Left
        popover!.sourceView = sender
        popover!.sourceRect = CGRectMake(100, 17, 5, 5)
        
        self.presentViewController(colorPicker, animated: true, completion: nil)
        
        colorPicker.colorTitle.text = title
        colorPicker.previewView.backgroundColor = aColor
        colorPicker.presetSlidersWithColor(aColor)
    }
    
    @IBAction func resetPreferences(sender: UIButton) {
        XTRPropertiesStore.resetPreferences()
        
        self.populateSeriesColors()
        self.populateElementBubbleState(true)
        self.populateShowTransitionsState(true)
        self.populateSplashScreenState(true)
        
        self.elementBubbleSwitch.on = true
        self.showTransitionsBubbleSwitch.on = true
        self.splashScreenSwitch.on = true
        
        NSNotificationCenter.defaultCenter().postNotificationName(NOTIFICATION_SERIES_COLOR_CHANGED, object: nil)
    }
    
    // MARK: - View Management Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(XTRPreferencesViewController.colorSelected(_:)), name: NOTIFICATION_COLOR_SELECTED, object: nil)
        
        self.loadDocument("Credits.rtf", inView: self.webView)
        self.loadUserDefaults()
        self.populateSeriesColors()
        
        self.appNameLabel.text = XTRVersionChecker.appNameString()
        self.versionLabel.text = XTRVersionChecker.appVersionString()
        self.cpyRightLabel.text = XTRVersionChecker.copywriteString()
    }
    
    override func viewWillAppear(animated: Bool)  {
        super.viewWillAppear(animated)
    }
    
    override func shouldAutorotate() -> Bool {
        return true
    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return [UIInterfaceOrientationMask.LandscapeLeft, UIInterfaceOrientationMask.LandscapeRight]
    }
    
    // MARK: - Memory Management Methods
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: NOTIFICATION_COLOR_SELECTED, object: nil)
        
        self.appNameLabel = nil
        self.cpyRightLabel = nil
        self.elementBubbleSwitch = nil
        self.seriesActinideButton = nil
        self.seriesAlkaliEarthMetalButton = nil
        self.seriesAlkaliMetalButton = nil
        self.seriesHalogenButton = nil
        self.seriesLanthanideButton = nil
        self.seriesMetalButton = nil
        self.seriesNobleGasButton = nil
        self.seriesNonMetalButton = nil
        self.seriesTransactinidesButton = nil
        self.seriesTransitionMetalButton = nil
        self.showTransitionsBubbleSwitch = nil
        self.splashScreenSwitch = nil
        self.versionLabel = nil
        self.webView.delegate = nil
        self.webView = nil
    }
}
