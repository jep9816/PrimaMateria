//
//  XTRInfoViewController.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 4/14/16.
//  Copyright ©2021 xTrensa. All rights reserved.
//

import WebKit

class XTRInfoViewController: UIViewController {

    @IBOutlet var webView: WKWebView!
    @IBOutlet var navigationBar: UINavigationBar!

    private var delegate: XTRInfoViewControllerDelegate? = XTRInfoViewControllerDelegate()

    // MARK: - Initialization Methods

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    // MARK: - Internal Methods

    func loadDocument(_ documentName: String) {
        guard let path = Bundle.main.path(forResource: documentName, ofType: FileType.html, inDirectory: "PrimaMateriaHelp/\(XTRPropertiesStore.currentLanguageCode)") else { return }

        if !path.isEmpty {
            let url = URL(fileURLWithPath: path)
            let request = URLRequest(url: url)

            webView.load(request)
        }
    }

    // MARK: - View Management Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        title = NSLocalizedString("info", comment: "")
        navigationBar.topItem?.title = title

        loadDocument("index")
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    override var shouldAutorotate: Bool {
        return false
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscape
    }

    // MARK: - Memory Management Methods

    deinit {
        if let webView = webView {
            webView.navigationDelegate = nil
        }
        webView = nil
    }

}
