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
    private var responseData: NSMutableData?
    private var request: NSMutableURLRequest?
    
    var elementName: String?
    var disposeBag = DisposeBag()

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination: XTRWikipediaViewController = segue.destination as! XTRWikipediaViewController
        destination.elementName = element?.name
    }
    
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
    
    override func viewDidLoad() {
        showWikiButton.rx.tap.subscribe(onNext: { [weak self] _ in
            self?.performSegue(withIdentifier: SegueName.showWikipediaViewControllerFromGeneralViewController, sender: self)
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
    }
    
}
