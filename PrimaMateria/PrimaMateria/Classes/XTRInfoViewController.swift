//
//  XTRInfoViewController.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 4/14/16.
//  Copyright ©2018 xTrensa. All rights reserved.
//

class XTRInfoViewController : UIViewController {
    
    @IBOutlet var webView: UIWebView!
    
    private var delegate : XTRInfoViewControllerDelegate = XTRInfoViewControllerDelegate()

    // MARK: - Initialization Methods
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    // MARK: - Internal Methods
    
    func loadDocument(_ documentName: String) {
        let path = Bundle.main.path(forResource: documentName, ofType: FileType.html, inDirectory: "PrimaMateriaHelp")!
        webView.loadRequest(URLRequest(url: URL(fileURLWithPath: path)))
    }
    
    // MARK: - View Management Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.delegate = delegate
        loadDocument("index")
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override var shouldAutorotate : Bool {
        return false
    }
    
    override var supportedInterfaceOrientations : UIInterfaceOrientationMask {
        return .landscape
    }
    
    // MARK: - Memory Management Methods
    
    deinit {
        webView.delegate = nil
        webView = nil
    }
    
}
