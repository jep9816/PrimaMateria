//
//  XTRGeneralInfoViewController.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 4/15/16.
//  Copyright © 2018 xTrensa. All rights reserved.
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

    private var progressHUD: MBProgressHUD?
    
    var elementName: String?
    var disposeBag = DisposeBag()

    // MARK: - Initialization Methods
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    // MARK: - Internal Methods
    
    func assignGeneralInfo() {
        let path = element!.pathForGeneralInfoDoc()
        
        if !path.isEmpty {
            let url = URL(fileURLWithPath: path)
            let request = URLRequest(url: url)

            webView.load(request)
        }
    }
    
    // MARK: - Miscellaneous Methods
    
    override func setupUI(element: XTRElementModel) {
        super.setupUI(element: element)
        
        discovererLabel.text = element.value(forKeyPath: ELEMENT_DISCOVERER) as? String
        discoveryLocationLabel.text = element.value(forKeyPath: ELEMENT_DISCOVERY_LOCATION) as? String
        discoveryYearLabel.text = element.value(forKeyPath: ELEMENT_DISCOVERY_YEAR) as? String
        abundanceCrustLabel.text = "\(element.value(forKeyPath: ELEMENT_ABUNDANCE_CRUST)!)"
        abundanceSeaLabel.text = "\(element.value(forKeyPath: ELEMENT_ABUNDANCE_SEA)!)"
        assignGeneralInfo()
    }
    
    // MARK: - Action Methods
        
    // MARK: - View Management Methods
    
    func showWikiView() {
        let storyboard = UIStoryboard(name: StoryBoardName.Wikipedia, bundle: nil)
        let wikipediaViewController: XTRWikipediaViewController = storyboard.instantiateViewController(withIdentifier: XTRWikipediaViewController.nameOfClass) as! XTRWikipediaViewController
        
        wikipediaViewController.preferredContentSize = XTRPreferencesViewControllerConfig.colorPickerContentSize
        wikipediaViewController.modalPresentationStyle = .formSheet
        wikipediaViewController.modalTransitionStyle = .crossDissolve
        wikipediaViewController.elementName = element?.name
        
        present(wikipediaViewController, animated: XTRPropertiesStore.showTransitionsState, completion: nil)
    }
    
    override func viewDidLoad() {
        showWikiButton.rx.tap.subscribe(onNext: { [weak self] _ in
            self?.showWikiView()
        }).disposed(by: disposeBag)
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
        webView = nil
        showWikiButton = nil
    }
    
}
