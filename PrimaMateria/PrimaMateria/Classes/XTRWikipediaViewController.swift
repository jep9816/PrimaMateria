//
//  XTRWikipediaViewController.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 4/14/16.
//  Copyright © 2016 xTrensa. All rights reserved.
//

@objc class XTRWikipediaViewController : UIViewController, UIWebViewDelegate, MBProgressHUDDelegate {
    @IBOutlet var backButton : UIBarButtonItem!
    @IBOutlet var titleButtonItem: UIBarButtonItem!
    @IBOutlet var forwardButton : UIBarButtonItem!
    @IBOutlet var webView : UIWebView!
    
    private var progressHUD : MBProgressHUD?
    private var responseData : NSMutableData?
    private var request : NSMutableURLRequest?
    var elementName : String?
    
    // MARK: - Initialization Methods
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    // MARK: - Internal Methods
    
    func prepareRequest() {
        let path : String = String.init(format: "https://en.wikipedia.org/wiki/%@", arguments: [self.elementName!])
        let url : NSURL = NSURL(string: path)!
        let request : NSMutableURLRequest = NSMutableURLRequest.init(URL: url)
        
        self.webView.loadRequest(request)
    }
    
    // MARK: - Action Methods
    
    @IBAction func dismiss(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion:  nil)
    }
    
    @IBAction func backButtonPressed(sender: UIButton) {
        self.progressHUD?.showAnimated(true)
        self.webView.goBack()
    }
    
    @IBAction func forwardButtonPressed(sender: UIButton) {
        self.progressHUD?.showAnimated(true)
        self.webView.goForward()
    }
    
    // MARK: - WebView Delegate Methods
    
    func webViewDidStartLoad(webView: UIWebView) {
        self.progressHUD?.showAnimated(true)
        self.backButton.enabled = false
        self.forwardButton.enabled = false
        self.backButton.tintColor = UIColor.blackColor()
        self.forwardButton.tintColor = UIColor.blackColor()
    }
    
    func webViewDidFinishLoad(aWebView: UIWebView) {
        MBProgressHUD.hideHUDForView(self.view, animated: true)
        
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
    
    func webView(webView: UIWebView, didFailLoadWithError error: NSError?) {
        let path: String = NSBundle.mainBundle().pathForResource("LoadFailure", ofType: FILE_TYPE_HTML)!
        let url : NSURL = NSURL.init(fileURLWithPath: path)
        let request : NSMutableURLRequest = NSMutableURLRequest.init(URL: url)
        
        MBProgressHUD.hideHUDForView(self.view, animated: true)
        
        self.webView.loadRequest(request)
    }
    
    // MARK: - MBProgressHUDDelegate methods
    
    func hudWasHidden(aProgressHUD: MBProgressHUD) {
        aProgressHUD.removeFromSuperview()
    }
    
    // MARK: - View Management Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let textAttributes: [String: AnyObject]? = [
            NSForegroundColorAttributeName: UIColor.whiteColor(),
            NSFontAttributeName: UIFont.boldSystemFontOfSize(20)
        ]
        
        let detailsLabelText : String = String.init(format: "Loading Wikipedia Page for element: %@.", arguments: [self.elementName!])
        
        self.titleButtonItem.setTitleTextAttributes(textAttributes, forState: UIControlState.Normal)
        
        self.preferredContentSize = CGSizeMake(768, 620)
        
        self.progressHUD = MBProgressHUD.init(view: self.view)
        self.progressHUD!.label.font = UIFont.boldSystemFontOfSize(26)
        self.progressHUD!.detailsLabel.font = UIFont.boldSystemFontOfSize(15)
        self.progressHUD!.delegate = self
        self.progressHUD!.label.text = "Please Wait"
        self.progressHUD!.detailsLabel.text = detailsLabelText
        self.webView.delegate = self
    }
    
    override func viewWillAppear(animated: Bool)  {
        super.viewWillAppear(animated)
        let title : String = String.init(format: "Wikipedia Entry for element:  %@", arguments: [self.elementName!])
        
        self.titleButtonItem.title = title
        self.backButton.enabled = false
        self.backButton.tintColor = UIColor.blackColor()
        self.forwardButton.enabled = false
        self.forwardButton.tintColor = UIColor.blackColor()
        
        self.view.addSubview(self.progressHUD!)
        self.progressHUD?.showAnimated(true)
        self.prepareRequest()
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
        self.titleButtonItem = nil
        self.webView.delegate = nil
        self.webView = nil
    }
}
