//
//  XTRHelpBalloonViewController.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 4/15/16.
//  Copyright ©2018 xTrensa. All rights reserved.
//

import WebKit

class XTRHelpBalloonViewController : UIViewController {
    
    @IBOutlet var backButton : UIBarButtonItem!
    @IBOutlet var forwardButton : UIBarButtonItem!
    @IBOutlet var titleLabel: UILabel!
    
    var webView : WKWebView!
    
    private var delegate : XTRHelpBalloonViewControllerDelegate = XTRHelpBalloonViewControllerDelegate()

    // MARK: - Initialization Methods
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    // MARK: - Internal Methods
    
    func loadDocument(_ documentName: String) {
        guard let path = Bundle.main.path(forResource: documentName, ofType: FileType.html, inDirectory: "ElementTipHelp") else { return }
        
        webView.load(URLRequest(url: URL(fileURLWithPath: path)))
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

        delegate.controller = self

//        let subLayer = CALayer()
//
//        subLayer.backgroundColor = UIColor.color(hexString: "dddd00").cgColor
//        subLayer.shadowRadius = 5
//        subLayer.shadowOpacity = 0.75
//        subLayer.shadowOffset = CGSize(width: 5, height: 5)
//        subLayer.cornerRadius = 8
//        subLayer.borderWidth = 1
        
        backButton.isEnabled = false
        forwardButton.isEnabled = false
        backButton.tintColor = UIColor.black
        forwardButton.tintColor = UIColor.black
        
        view.backgroundColor = XTRColorFactory.helpBackgroundColor
        
        titleLabel.layer.cornerRadius = 8
        titleLabel.layer.masksToBounds = true
        
        let viewportScriptString = "var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); meta.setAttribute('initial-scale', '1.0'); meta.setAttribute('maximum-scale', '1.0'); meta.setAttribute('minimum-scale', '1.0'); meta.setAttribute('user-scalable', 'no'); document.getElementsByTagName('head')[0].appendChild(meta);"
        let viewportScript = WKUserScript(source: viewportScriptString, injectionTime: .atDocumentEnd, forMainFrameOnly: true)
        let controller = WKUserContentController()
        let config = WKWebViewConfiguration()

        controller.addUserScript(viewportScript)
        config.userContentController = controller
        
        webView = WKWebView(frame: CGRect(x:5, y: 43, width: 400, height: 288), configuration: config)
        view.addSubview(webView)
        
        //subLayer.bounds = webView.bounds
        //subLayer.position = webView.center
        //view.layer.insertSublayer(subLayer, below: webView.layer)
        webView.layer.cornerRadius = 8
        webView.layer.masksToBounds = true
        webView.navigationDelegate = delegate
        webView.scrollView.isScrollEnabled = true             // Make sure our view is interactable
        webView.scrollView.bounces = false                    // Things like this should be handled in web code
        webView.allowsBackForwardNavigationGestures = false   // Disable swiping to navigate
        webView.contentMode = .scaleToFill                    // Scale the page to fill the web view
       // webView.backgroundColor = XTRColorFactory.helpBackgroundColor
        
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
        //webView.navigationDelegate = nil
        //webView = nil
        NotificationCenter.default.removeObserver(self, name: .elementHelpSelectedNotification, object: nil)
    }
    
}
