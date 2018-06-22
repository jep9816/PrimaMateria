//
//  XTRGeneralInfoViewController.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 4/15/16.
//  Copyright ©2018 xTrensa. All rights reserved.
//

import PDFKit

class XTRGeneralInfoViewController : XTRSwapableViewController {
    
    @IBOutlet var discovererLabel : UILabel!
    @IBOutlet var discoveryLocationLabel : UILabel!
    @IBOutlet var discoveryYearLabel : UILabel!
    @IBOutlet var abundanceCrustLabel : UILabel!
    @IBOutlet var abundanceSeaLabel : UILabel!
    @IBOutlet var webView : UIWebView!
    
    private var progressHUD : MBProgressHUD?
    private var responseData : NSMutableData?
    private var request : NSMutableURLRequest?
    
    var elementName : String?
    
    // MARK: - Initialization Methods
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    // MARK: - Internal Methods
    
    func assignGeneralInfo() {
        let aPath = element!.pathForGeneralInfoDoc()
        
        if !aPath.isEmpty {
            webView.loadRequest(URLRequest(url: URL(string: aPath)!))
        }
    }
    
    // MARK: - Miscellaneous Methods
    
    override func setupUI() {
        guard let localElement = element else { return }
        discovererLabel.text = localElement.value(forKeyPath: ELEMENT_DISCOVERER) as? String
        discoveryLocationLabel.text = localElement.value(forKeyPath: ELEMENT_DISCOVERY_LOCATION) as? String
        discoveryYearLabel.text = localElement.value(forKeyPath: ELEMENT_DISCOVERY_YEAR) as? String
        abundanceCrustLabel.text = "\(localElement.value(forKeyPath: ELEMENT_ABUNDANCE_CRUST)!)"
        abundanceSeaLabel.text = "\(localElement.value(forKeyPath: ELEMENT_ABUNDANCE_SEA)!)"
        assignGeneralInfo()
    }
    
    // MARK: - Action Methods
    
    @IBAction func showWikipediaEntry(_ sender: UIButton) {
        performSegue(withIdentifier: SegueName.showWikipediaViewControllerFromGeneralViewController, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destController = segue.destination as! XTRWikipediaViewController
        destController.elementName = element!.name
    }
    
    // MARK: - View Management Methods
    
    override var shouldAutorotate : Bool {
        return false
    }
    
    override var supportedInterfaceOrientations : UIInterfaceOrientationMask {
        return .landscape
    }
    
    // MARK: - Memory Management Methods
    
    deinit {
        abundanceCrustLabel = nil
        abundanceSeaLabel = nil
        discovererLabel = nil
        discoveryLocationLabel = nil
        discoveryYearLabel = nil
        webView.delegate = nil
        webView = nil
    }
    
}
