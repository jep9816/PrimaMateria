//
//  XTRInfoViewController.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 4/14/16.
//  Copyright © 2016 xTrensa. All rights reserved.
//

@objc class XTRInfoViewController : UIViewController, UIWebViewDelegate {
    @IBOutlet weak var webView: UIWebView!
    
    // MARK: - Initialization Methods
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    // MARK: - Internal Methods
    
    func loadDocument(documentName: String) {
        let path : String = NSBundle.mainBundle().pathForResource(documentName, ofType: FILE_TYPE_HTML, inDirectory: "PrimaMateriaHelp")!
        let url : NSURL = NSURL.fileURLWithPath(path)
        let request : NSURLRequest = NSURLRequest.init(URL: url)
        self.webView.loadRequest(request)
    }
    
    // MARK: - View Management Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.webView.delegate = self
        self.loadDocument("index");
    }
    
    override func shouldAutorotate() -> Bool {
        return true
    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return [UIInterfaceOrientationMask.LandscapeLeft, UIInterfaceOrientationMask.LandscapeRight]
    }
    
    // MARK: - Memory Management Methods
    
    deinit {
        self.webView.delegate = nil;
        self.webView = nil;
    }
}
