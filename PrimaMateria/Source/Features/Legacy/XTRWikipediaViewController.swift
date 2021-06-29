//
//  XTRWikipediaViewController.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 4/14/16.
//  Copyright ©2021 xTrensa. All rights reserved.
//

import WebKit
import RxSwift
import RxCocoa
import MBProgressHUD

class XTRWikipediaViewController: UIViewController {

    @IBOutlet var backButton: UIBarButtonItem!
    @IBOutlet var forwardButton: UIBarButtonItem!
    @IBOutlet var titleButtonItem: UIBarButtonItem!
    @IBOutlet var dismissButton: UIButton!
    @IBOutlet var webView: WKWebView!

    public var progressHUD: MBProgressHUD!

    private var delegate: XTRWikipediaViewControllerDelegate? = XTRWikipediaViewControllerDelegate()

    var elementName: String?
    var disposeBag: DisposeBag = DisposeBag()

    // MARK: - Initialization Methods

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    // MARK: - Internal Methods

    func prepareRequest() {
        let url = URL(string: "https://\(XTRPropertiesStore.currentLanguageCode).wikipedia.org/wiki/\(elementName!)")!
        let request = URLRequest(url: url)

        webView.load(request)
    }

    // MARK: - Action Methods

    // MARK: - View Management Methods

    override func viewDidLoad() {
        super.viewDidLoad()

        delegate?.controller = self

        let textAttributes: [NSAttributedString.Key: AnyObject]? = [
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20)
        ]

        titleButtonItem.setTitleTextAttributes(textAttributes, for: UIControl.State())

        preferredContentSize = CGSize(width: 768, height: 620)

        progressHUD = MBProgressHUD(view: view)
        progressHUD.label.font = UIFont.boldSystemFont(ofSize: 26)
        progressHUD.detailsLabel.font = UIFont.boldSystemFont(ofSize: 15)
        progressHUD.label.text = NSLocalizedString("pleaseWait", comment: "")
        progressHUD.detailsLabel.text = "\(NSLocalizedString("loadingWikipedia", comment: "")) //\(elementName!)."
        progressHUD.backgroundView.backgroundColor = UIColor.clear
        webView.navigationDelegate = delegate
        view.addSubview(progressHUD)

        setupRx()
    }

    func setupRx() {
        backButton.rx.tap.subscribe(onNext: { [weak self] _ in
            self?.progressHUD.show(animated: XTRPropertiesStore.showTransitionsState)
            self?.webView.goBack()
        }).disposed(by: disposeBag)

        forwardButton.rx.tap.subscribe(onNext: { [weak self] _ in
            self?.progressHUD.show(animated: XTRPropertiesStore.showTransitionsState)
            self?.webView.goForward()
        }).disposed(by: disposeBag)

        dismissButton.rx.tap.subscribe(onNext: { [weak self] _ in
            self?.dismiss(animated: XTRPropertiesStore.showTransitionsState, completion: nil)
        }).disposed(by: disposeBag)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        titleButtonItem.title = "\(NSLocalizedString("wikipediaEntry", comment: "")) \(elementName!)"
        backButton.isEnabled = false
        backButton.tintColor = UIColor.black
        forwardButton.isEnabled = false
        forwardButton.tintColor = UIColor.black

        progressHUD.show(animated: XTRPropertiesStore.showTransitionsState)

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
        dismissButton = nil
        if let webView = webView {
            webView.navigationDelegate = nil
        }
        webView = nil
    }

}
