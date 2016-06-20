//
//  XTRHelpBalloonViewController.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 4/15/16.
//  Copyright © 2016 xTrensa. All rights reserved.
//

@objc class XTRHelpBalloonViewController : UIViewController, UIWebViewDelegate {
    @IBOutlet var backButton : UIBarButtonItem!
    @IBOutlet var forwardButton : UIBarButtonItem!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var webView : UIWebView!
    
    // MARK: - Initialization Methods
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    // MARK: - Internal Methods
    
    func loadDocument(documentName: String) {
        let path : String? = NSBundle.mainBundle().pathForResource(documentName, ofType: FILE_TYPE_HTML, inDirectory: "ElementTipHelp")
        
        if (path != nil) {
            let url : NSURL = NSURL.fileURLWithPath(path!)
            let request : NSURLRequest = NSURLRequest.init(URL: url)
            self.webView.loadRequest(request)
        }
    }
    
    func showElementHelp(aNotification: NSNotification) {
        let object : String? = aNotification.object as? String
        self.loadDocument(object!)
    }
    
    // MARK: - Action Methods
    
    @IBAction func dismiss(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion:  nil)
    }
    
    @IBAction func backButtonPressed(sender: UIButton) {
        self.webView.goBack()
    }
    
    @IBAction func forwardButtonPressed(sender: UIButton) {
        self.webView.goForward()
    }
    
    // MARK: - WebView Delegate Methods
    
    func webViewDidStartLoad(webView: UIWebView) {
        self.backButton.enabled = false
        self.forwardButton.enabled = false
        self.backButton.tintColor = UIColor.blackColor()
        self.forwardButton.tintColor = UIColor.blackColor()
    }
    
    func webViewDidFinishLoad(aWebView: UIWebView) {
        if (aWebView.canGoBack) {
            self.backButton.enabled = true
            self.backButton.tintColor = UIColor.whiteColor()
        } else if (!aWebView.canGoBack) {
            self.backButton.enabled = false
            self.backButton.tintColor = UIColor.blackColor()
        }
        
        if (aWebView.canGoForward) {
            self.forwardButton.enabled = true
            self.forwardButton.tintColor = UIColor.whiteColor()
        } else if (!aWebView.canGoForward) {
            self.forwardButton.enabled = false
            self.forwardButton.tintColor = UIColor.blackColor()
        }
    }
    
    // MARK: - View Management Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let layer : CALayer = CALayer.init()
        
        layer.bounds = self.webView.bounds
        layer.position = self.webView.center
        layer.backgroundColor = UIColor(hexString: "dddd00").CGColor
        layer.shadowRadius = 5
        layer.shadowOpacity = 0.75
        layer.shadowOffset = CGSizeMake(5, 5)
        layer.cornerRadius = 8
        layer.borderWidth = 1

        self.backButton.enabled = false
        self.forwardButton.enabled = false
        self.backButton.tintColor = UIColor.blackColor()
        self.forwardButton.tintColor = UIColor.blackColor()
        
        self.view.backgroundColor = UIColor(hexString: "dddd00")
        self.view.layer.insertSublayer(layer, below: self.webView.layer)
        
        self.titleLabel.layer.cornerRadius = 8
        self.titleLabel.layer.masksToBounds = true
        
        self.webView.layer.cornerRadius = 8
        self.webView.layer.masksToBounds = true
        self.webView.delegate = self
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(XTRHelpBalloonViewController.showElementHelp(_:)), name: NOTIFICATION_ELEMENT_HELP_SELECTED, object: nil)
    }
    
    override func shouldAutorotate() -> Bool {
        return true
    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return [UIInterfaceOrientationMask.LandscapeLeft, UIInterfaceOrientationMask.LandscapeRight]
    }
    
    // MARK: - Memory Management Methods
    
    deinit {
        self.backButton = nil
        self.forwardButton = nil
        self.titleLabel = nil
        self.webView.delegate = nil
        self.webView = nil
        NSNotificationCenter.defaultCenter().removeObserver(self, name: NOTIFICATION_ELEMENT_HELP_SELECTED, object: nil)
    }
}
