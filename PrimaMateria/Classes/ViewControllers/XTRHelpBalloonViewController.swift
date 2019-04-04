//
//  XTRHelpBalloonViewController.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 4/15/16.
//  Copyright © 2018 xTrensa. All rights reserved.
//

import WebKit
import RxSwift
import RxCocoa

class XTRHelpBalloonViewController: UIViewController {
    
    @IBOutlet var backButton: UIButton!
    @IBOutlet var forwardButton: UIButton!
    @IBOutlet var titleLabel: UILabel!
    
    var webView: WKWebView!
    var disposeBag: DisposeBag = DisposeBag()

    private var delegate: XTRHelpBalloonViewControllerDelegate? = XTRHelpBalloonViewControllerDelegate()

    // MARK: - Initialization Methods
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    // MARK: - Internal Methods
    
    func loadDocument(_ documentName: String) {
        guard let path = Bundle.main.path(forResource: documentName, ofType: FileType.html, inDirectory: "ElementTipHelp") else { return }
        
        if !path.isEmpty {
            let url = URL(fileURLWithPath: path)
            let request = URLRequest(url: url)
            
            webView.load(request)
        }
    }
    
    @objc func showElementHelp(_ aNotification: Notification) {
        guard let object = aNotification.object as? String else { return }
        loadDocument(object)
    }
    
    // MARK: - Action Methods
    
    // MARK: - View Management Methods
    
     func setupWebView() {
        // Scale the page to fill the web view
       let viewportScriptString = "var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); meta.setAttribute('initial-scale', '1.0'); meta.setAttribute('maximum-scale', '1.0'); meta.setAttribute('minimum-scale', '1.0'); meta.setAttribute('user-scalable', 'no'); document.getElementsByTagName('head')[0].appendChild(meta);"
        let viewportScript = WKUserScript(source: viewportScriptString, injectionTime: .atDocumentEnd, forMainFrameOnly: true)
        let controller = WKUserContentController()
        let config = WKWebViewConfiguration()
        
        controller.addUserScript(viewportScript)
        config.userContentController = controller
        
        webView = WKWebView(frame: CGRect(x: 2, y: 46, width: 406, height: 286), configuration: config)
        
        webView.layer.cornerRadius = VIEW_CORNER_RADIUS + 8
        webView.layer.masksToBounds = true
        webView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        webView.navigationDelegate = delegate
        webView.scrollView.isScrollEnabled = true             // Make sure our view is interactable
        webView.scrollView.bounces = false                    // Things like this should be handled in web code
        webView.allowsBackForwardNavigationGestures = false   // Disable swiping to navigate
        webView.contentMode = .scaleToFill

        view.addSubview(webView)
    }
    
    func setupRx() {
        backButton.rx.tap.subscribe { [weak self] _ in
            self?.webView.goBack()
            }.disposed(by: disposeBag)

        forwardButton.rx.tap.subscribe { [weak self] _ in
            self?.webView.goForward()
            }.disposed(by: disposeBag)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        delegate?.controller = self
        
        backButton.isEnabled = false
        backButton.tintColor = UIColor.black

        forwardButton.isEnabled = false
        forwardButton.tintColor = UIColor.black
        
        titleLabel.layer.cornerRadius = VIEW_CORNER_RADIUS + 2
        titleLabel.layer.masksToBounds = true
        titleLabel.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        setupWebView()
        setupRx()
        view.backgroundColor = XTRColorFactory.helpBackgroundColor

        NotificationCenter.default.addObserver(self, selector: #selector(showElementHelp(_:)), name: .elementHelpSelectedNotification, object: nil)
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscape
    }
    
    // MARK: - Memory Management Methods
    
    deinit {
        backButton = nil
        forwardButton = nil
        titleLabel = nil
        NotificationCenter.default.removeObserver(self, name: .elementHelpSelectedNotification, object: nil)
    }
    
}
