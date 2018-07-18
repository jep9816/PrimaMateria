//
//  XTRWikipediaViewController.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 4/14/16.
//  Copyright © 2018 xTrensa. All rights reserved.
//

import WebKit

class XTRWikipediaViewController: UIViewController {
    
    @IBOutlet var backButton: UIBarButtonItem!
    @IBOutlet var titleButtonItem: UIBarButtonItem!
    @IBOutlet var forwardButton: UIBarButtonItem!
    @IBOutlet var webView: WKWebView!
    
    public var progressHUD: MBProgressHUD?
    
    private var responseData: NSMutableData?
    private var request: NSMutableURLRequest?
    private var delegate: XTRWikipediaViewControllerDelegate? = XTRWikipediaViewControllerDelegate()
    
    var elementName: String?
    
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
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        progressHUD?.show(animated: true)
        webView.goBack()
    }
    
    @IBAction func forwardButtonPressed(_ sender: UIButton) {
        progressHUD?.show(animated: true)
        webView.goForward()
    }
    
    // MARK: - View Management Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegate?.controller = self
        
        let textAttributes: [NSAttributedStringKey: AnyObject]? = [
            NSAttributedStringKey.foregroundColor: UIColor.white,
            NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 20)
        ]
        
        titleButtonItem.setTitleTextAttributes(textAttributes, for: UIControlState())
        
        preferredContentSize = CGSize(width: 768, height: 620)
        
        progressHUD = MBProgressHUD(view: view)
        progressHUD!.label.font = UIFont.boldSystemFont(ofSize: 26)
        progressHUD!.detailsLabel.font = UIFont.boldSystemFont(ofSize: 15)
        progressHUD!.delegate = delegate
        progressHUD!.label.text = NSLocalizedString("pleaseWait", comment: "")
        progressHUD!.detailsLabel.text = "\(NSLocalizedString("loadingWikipedia", comment: "")) \(elementName!)."
        webView.navigationDelegate = delegate
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        titleButtonItem.title = "\(NSLocalizedString("wikipediaEntry", comment: "")) \(elementName!)"
        backButton.isEnabled = false
        backButton.tintColor = UIColor.black
        forwardButton.isEnabled = false
        forwardButton.tintColor = UIColor.black
        
        view.addSubview(progressHUD!)
        progressHUD?.show(animated: true)
        prepareRequest()
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
        titleButtonItem = nil
        webView.navigationDelegate = nil
        webView = nil
    }
    
}
