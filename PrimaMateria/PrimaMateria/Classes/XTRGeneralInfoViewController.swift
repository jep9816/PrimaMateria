//
//  XTRGeneralInfoViewController.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 4/15/16.
//  Copyright © 2016 xTrensa. All rights reserved.
//

@objc class XTRGeneralInfoViewController : XTRSwapableViewController, UIWebViewDelegate {
    @IBOutlet weak var discovererLabel : UILabel!
    @IBOutlet weak var discoveryLocationLabel : UILabel!
    @IBOutlet weak var discoveryYearLabel : UILabel!
    @IBOutlet weak var abundanceCrustLabel : UILabel!
    @IBOutlet weak var abundanceSeaLabel : UILabel!
    @IBOutlet weak var webView : UIWebView!
    
    private var progressHUD : MBProgressHUD?
    private var responseData : NSMutableData?
    private var request : NSMutableURLRequest?
    var elementName : String?
    
    // MARK: - Initialization Methods
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    // MARK: - Internal Methods
    
    func assignGeneralInfo() {
        let path : String = self.element!.pathForGeneralInfoDoc()
        let url : NSURL = NSURL(string: path)!
        let request : NSURLRequest = NSURLRequest.init(URL: url)
        self.webView.loadRequest(request)
    }
    
    // MARK: - Miscellaneous Methods
    
    override func setupUI() {
        if (self.element != nil) {
            self.discovererLabel.text = self.element!.valueForKey(ELEMENT_DISCOVERER) as? String
            self.discoveryLocationLabel.text = self.element!.valueForKey(ELEMENT_DISCOVERY_LOCATION) as? String
            self.discoveryYearLabel.text = self.element!.valueForKey(ELEMENT_DISCOVERY_YEAR) as? String
            self.abundanceCrustLabel.text = String.init(format: "%@", arguments: [self.element!.valueForKey(ELEMENT_ABUNDANCE_CRUST) as! String])
            self.abundanceSeaLabel.text = String.init(format: "%@", arguments: [self.element!.valueForKey(ELEMENT_ABUNDANCE_SEA) as! String])
            self.assignGeneralInfo()
        }
    }
    
    // MARK: - Action Methods
    
    @IBAction func showWikipediaEntry(sender: UIButton) {
        self.performSegueWithIdentifier(SHOW_WIKIPEDIA_VIEW_CONTROLLER_FROM_GENERAL_VIEW_CONTROLLER, sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let destController : XTRWikipediaViewController = segue.destinationViewController as! XTRWikipediaViewController
        destController.elementName = self.element!.name()
    }
    
    // MARK: - View Management Methods
    
    override func shouldAutorotate() -> Bool {
        return true
    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return [UIInterfaceOrientationMask.LandscapeLeft, UIInterfaceOrientationMask.LandscapeRight]
    }
    
    // MARK: - Memory Management Methods
    
    deinit {
        self.abundanceCrustLabel = nil
        self.abundanceSeaLabel = nil
        self.discovererLabel = nil
        self.discoveryLocationLabel = nil
        self.discoveryYearLabel = nil
        self.webView.delegate = nil
        self.webView = nil
    }
}
