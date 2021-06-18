//
//  XTRGeneralInfoViewController.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 4/15/16.
//  Copyright ©2021 xTrensa. All rights reserved.
//

import PDFKit
import WebKit
import RxSwift
import RxCocoa

class XTRGeneralInfoViewController: XTRSwapableViewController {

    @IBOutlet var discovererLabel: UILabel!
    @IBOutlet var discoveryLocationLabel: UILabel!
    @IBOutlet var discoveryYearLabel: UILabel!
    @IBOutlet var abundanceCrustLabel: UILabel!
    @IBOutlet var abundanceSeaLabel: UILabel!
    @IBOutlet var webView: WKWebView!
    @IBOutlet var showWikiButton: UIButton!

    // MARK: - Initialization Methods

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    // MARK: - Internal Methods

    // MARK: - Miscellaneous Methods

    override func setupUIForAnimation(element: XTRElementModel) {
        super.setupUIForAnimation(element: element)

        setupLabels(element: element)
        setupGeneralInfo(element: element)
    }

    override func setupUI(element: XTRElementModel) {
        super.setupUI(element: element)

        setupLabels(element: element)
        setupGeneralInfo(element: element)
    }

    func setupLabels(element: XTRElementModel) {
        discovererLabel.text = element.value(forKeyPath: ELEMENT_DISCOVERER) as? String
        discoveryLocationLabel.text = element.value(forKeyPath: ELEMENT_DISCOVERY_LOCATION) as? String
        discoveryYearLabel.text = element.value(forKeyPath: ELEMENT_DISCOVERY_YEAR) as? String
        abundanceCrustLabel.text = "\(element.value(forKeyPath: ELEMENT_ABUNDANCE_CRUST)!)"
        abundanceSeaLabel.text = "\(element.value(forKeyPath: ELEMENT_ABUNDANCE_SEA)!)"
    }

    func setupGeneralInfo(element: XTRElementModel) {
        let path = element.pathForGeneralInfoDoc()
        let theURL = URL(fileURLWithPath: path)
        
        if let data = try? Data(contentsOf: theURL) {
            webView.load(data, mimeType: "application/pdf", characterEncodingName: "", baseURL: theURL)
        }
    }

    func setupRx() {
        showWikiButton.rx.tap.subscribe(onNext: { [weak self] _ in
            self?.showWikiView()
        }).disposed(by: disposeBag)
    }

    // MARK: - Action Methods

    // MARK: - View Management Methods

    func showWikiView() {
        let wikipediaViewController: XTRWikipediaViewController = XTRWikipediaViewController.loadFromNib()

        wikipediaViewController.modalPresentationStyle = .formSheet
        wikipediaViewController.isModalInPresentation = true
        wikipediaViewController.modalTransitionStyle = .crossDissolve
        wikipediaViewController.elementName = element?.name

        present(wikipediaViewController, animated: XTRPropertiesStore.showTransitionsState, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupRx()
    }

    override var shouldAutorotate: Bool {
        return false
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscape
    }

    // MARK: - Memory Management Methods

    deinit {
        abundanceCrustLabel = nil
        abundanceSeaLabel = nil
        discovererLabel = nil
        discoveryLocationLabel = nil
        discoveryYearLabel = nil
        showWikiButton = nil
        if let webView = webView {
            webView.navigationDelegate = nil
        }
        webView = nil
    }

}
