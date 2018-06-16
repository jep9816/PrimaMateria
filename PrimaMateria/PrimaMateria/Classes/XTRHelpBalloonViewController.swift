//
//  XTRHelpBalloonViewController.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 4/15/16.
//  Copyright ©2018 xTrensa. All rights reserved.
//

class XTRHelpBalloonViewController : UIViewController, UIWebViewDelegate {
    
    @IBOutlet var backButton : UIBarButtonItem!
    @IBOutlet var forwardButton : UIBarButtonItem!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var webView : UIWebView!
    
    // MARK: - Initialization Methods
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    // MARK: - Internal Methods
    
    func loadDocument(_ documentName: String) {
        guard let path = Bundle.main.path(forResource: documentName, ofType: FileType.html, inDirectory: "ElementTipHelp") else { return }
        
        webView.loadRequest(URLRequest(url: URL(fileURLWithPath: path)))
    }
    
    @objc func showElementHelp(_ aNotification: Notification) {
        guard let object = aNotification.object as? String else { return }
        loadDocument(object)
    }
    
    // MARK: - Action Methods
    
    @IBAction func dismiss(_ sender: UIButton) {
        dismiss(animated: true, completion:  nil)
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        webView.goBack()
    }
    
    @IBAction func forwardButtonPressed(_ sender: UIButton) {
        webView.goForward()
    }
    
    // MARK: - View Management Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let layer = CALayer()
        
        layer.bounds = webView.bounds
        layer.position = webView.center
        layer.backgroundColor = UIColor.color(hexString: "dddd00").cgColor
        layer.shadowRadius = 5
        layer.shadowOpacity = 0.75
        layer.shadowOffset = CGSize(width: 5, height: 5)
        layer.cornerRadius = 8
        layer.borderWidth = 1
        
        backButton.isEnabled = false
        forwardButton.isEnabled = false
        backButton.tintColor = UIColor.black
        forwardButton.tintColor = UIColor.black
        
        view.backgroundColor = UIColor.color(hexString: "dddd00")
        view.layer.insertSublayer(layer, below: webView.layer)
        
        titleLabel.layer.cornerRadius = 8
        titleLabel.layer.masksToBounds = true
        
        webView.layer.cornerRadius = 8
        webView.layer.masksToBounds = true
        webView.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(XTRHelpBalloonViewController.showElementHelp(_:)), name: .elementHelpSelectedNotification, object: nil)
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
        titleLabel = nil
        webView.delegate = nil
        webView = nil
        NotificationCenter.default.removeObserver(self, name: .elementHelpSelectedNotification, object: nil)
    }
    
}

extension XTRHelpBalloonViewController { // WebView Delegate Methods

    func webViewDidStartLoad(_ webView: UIWebView) {
        backButton.isEnabled = false
        forwardButton.isEnabled = false
        backButton.tintColor = UIColor.black
        forwardButton.tintColor = UIColor.black
    }
    
    func webViewDidFinishLoad(_ aWebView: UIWebView) {
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

}
