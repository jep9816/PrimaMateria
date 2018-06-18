//
//  XTRWikipediaViewController.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 4/14/16.
//  Copyright ©2018 xTrensa. All rights reserved.
//

import WebKit

class XTRWikipediaViewController : UIViewController, WKNavigationDelegate, MBProgressHUDDelegate {
    
    @IBOutlet var backButton : UIBarButtonItem!
    @IBOutlet var titleButtonItem: UIBarButtonItem!
    @IBOutlet var forwardButton : UIBarButtonItem!
    @IBOutlet var webView : WKWebView!
    
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
        webView.load(URLRequest(url: URL(string: "https://en.wikipedia.org/wiki/\(elementName!)")!))
    }
    
    // MARK: - Action Methods
    
    @IBAction func dismiss(_ sender: UIButton) {
        dismiss(animated: true, completion:  nil)
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        progressHUD?.show(animated: true)
        webView.goBack()
    }
    
    @IBAction func forwardButtonPressed(_ sender: UIButton) {
        progressHUD?.show(animated: true)
        webView.goForward()
    }
    
    // MARK: - WebView Delegate Methods
    
    //func webViewDidStartLoad(_ webView: UIWebView) {
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        progressHUD?.show(animated: true)
        backButton.isEnabled = false
        forwardButton.isEnabled = false
        backButton.tintColor = UIColor.black
        forwardButton.tintColor = UIColor.black
    }
    
    //func webViewDidFinishLoad(_ aWebView: UIWebView) {
    public func webView(_ aWebView: WKWebView, didFinish navigation: WKNavigation!) {
        MBProgressHUD.hide(for: view, animated: true)
        
        if aWebView.canGoBack {
            backButton.isEnabled = true
            backButton.tintColor = UIColor.white
        } else if !aWebView.canGoBack {
            backButton.isEnabled = false
            backButton.tintColor = UIColor.black
        }
        
        if aWebView.canGoForward {
            forwardButton.isEnabled = true
            forwardButton.tintColor = UIColor.white
        } else if !aWebView.canGoForward {
            forwardButton.isEnabled = false
            forwardButton.tintColor = UIColor.black
        }
    }
    
    //func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
    public func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        let path = Bundle.main.path(forResource: "LoadFailure", ofType: FileType.html)!

        MBProgressHUD.hide(for: view, animated: true)
        
        webView.load(URLRequest(url: URL(fileURLWithPath: path)))
    }
    
    // MARK: - MBProgressHUDDelegate methods
    
    func hudWasHidden(_ aProgressHUD: MBProgressHUD) {
        aProgressHUD.removeFromSuperview()
    }
    
    // MARK: - View Management Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let textAttributes: [NSAttributedStringKey: AnyObject]? = [
            NSAttributedStringKey.foregroundColor: UIColor.white,
            NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 20)
        ]
        
        titleButtonItem.setTitleTextAttributes(textAttributes, for: UIControlState())
        
        preferredContentSize = CGSize(width: 768, height: 620)
        
        progressHUD = MBProgressHUD(view: view)
        progressHUD!.label.font = UIFont.boldSystemFont(ofSize: 26)
        progressHUD!.detailsLabel.font = UIFont.boldSystemFont(ofSize: 15)
        progressHUD!.delegate = self
        progressHUD!.label.text = "Please Wait"
        progressHUD!.detailsLabel.text = "Loading Wikipedia Page for element: \(elementName!)."
        webView.navigationDelegate = self
   }
    
    override func viewWillAppear(_ animated: Bool)  {
        super.viewWillAppear(animated)
        
        titleButtonItem.title = "Wikipedia Entry for element: \(elementName!)"
        backButton.isEnabled = false
        backButton.tintColor = UIColor.black
        forwardButton.isEnabled = false
        forwardButton.tintColor = UIColor.black
        
        view.addSubview(progressHUD!)
        progressHUD?.show(animated: true)
        prepareRequest()
    }
    
    override var shouldAutorotate : Bool {
        return false
    }
    
    override var supportedInterfaceOrientations : UIInterfaceOrientationMask {
        return .landscape
    }
    
    // MARK: - Memory Management Methods
    
    deinit {
        backButton = nil
        forwardButton = nil
        titleButtonItem = nil
        webView.navigationDelegate = nil
        webView = nil
    }
    
}
