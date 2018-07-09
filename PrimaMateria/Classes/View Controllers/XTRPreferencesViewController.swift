//
//  XTRPreferencesViewController.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 4/22/16.
//  Copyright © 2018 xTrensa. All rights reserved.
//

import WebKit
import RxSwift
import RxCocoa

class XTRPreferencesViewController : UIViewController {
    
    @IBOutlet var appNameLabel : UILabel!
    @IBOutlet var cpyRightLabel : UILabel!
    
    @IBOutlet var seriesActinideButton : UIButton!
    @IBOutlet var seriesAlkaliEarthMetalButton : UIButton!
    @IBOutlet var seriesAlkaliMetalButton : UIButton!
    @IBOutlet var seriesHalogenButton : UIButton!
    @IBOutlet var seriesLanthanideButton : UIButton!
    @IBOutlet var seriesMetalButton : UIButton!
    @IBOutlet var seriesNobleGasButton : UIButton!
    @IBOutlet var seriesNonMetalButton : UIButton!
    @IBOutlet var seriesTransactinidesButton : UIButton!
    @IBOutlet var seriesTransitionMetalButton : UIButton!
    
    @IBOutlet var resetPreferencesButton : UIButton!
    @IBOutlet var versionLabel : UILabel!
    @IBOutlet var elementBubbleSwitch : UISwitch!
    @IBOutlet var showTransitionsBubbleSwitch : UISwitch!
    @IBOutlet var splashScreenSwitch : UISwitch!
    @IBOutlet var webView : WKWebView!
    @IBOutlet var styleControl : UISegmentedControl!
    @IBOutlet var navigationBar: UINavigationBar!
    
    var disposeBag = DisposeBag()

    // MARK: - Initialization Methods
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    // MARK: - Internal Methods
    
    @objc func colorSelected(notification: Notification) {
        guard let anObject : [String : AnyObject] = notification.object as! [String : AnyObject]? else { return }
        
        let redComponent = anObject[ColorComponent.red] as! NSNumber
        let greenComponent = anObject[ColorComponent.green] as! NSNumber
        let blueComponent = anObject[ColorComponent.blue] as! NSNumber
        let alphaComponent = anObject[ColorComponent.alpha] as! NSNumber
        
        let seriesIdentifier = anObject[SERIES_IDENTIFIER_KEY] as! String
        let aColor = UIColor(red: CGFloat(redComponent.floatValue), green: CGFloat(greenComponent.floatValue), blue: CGFloat(blueComponent.floatValue), alpha: CGFloat(alphaComponent.floatValue))
        let colorData = NSKeyedArchiver.archivedData(withRootObject: aColor)
        
        XTRPropertiesStore.setColorData(colorData, key: seriesIdentifier)
        
        switch (seriesIdentifier) {
        case ElementSeries.actinide :
            updateSeriesButtonProperties(seriesActinideButton, aColor: aColor)
        case ElementSeries.alkaliEarthMetal :
            updateSeriesButtonProperties(seriesAlkaliEarthMetalButton, aColor: aColor)
        case ElementSeries.alkaliMetal :
            updateSeriesButtonProperties(seriesAlkaliMetalButton, aColor: aColor)
        case ElementSeries.halogen :
            updateSeriesButtonProperties(seriesHalogenButton, aColor: aColor)
        case ElementSeries.lanthanide :
            updateSeriesButtonProperties(seriesLanthanideButton, aColor: aColor)
        case ElementSeries.metal :
            updateSeriesButtonProperties(seriesMetalButton, aColor: aColor)
        case ElementSeries.nobleGas :
            updateSeriesButtonProperties(seriesNobleGasButton, aColor: aColor)
        case ElementSeries.nonMetal :
            updateSeriesButtonProperties(seriesNonMetalButton, aColor: aColor)
        case ElementSeries.transactinides :
            updateSeriesButtonProperties(seriesTransactinidesButton, aColor: aColor)
        default :
            updateSeriesButtonProperties(seriesTransitionMetalButton, aColor: aColor)
        }
        
        NotificationCenter.default.post(name: .seriesColorChangedNotification, object: nil)
        
        dismiss(animated: true, completion: nil)
    }
    
    func loadDocument(_ documentName: String, inView: WKWebView) {
        guard let aPath = Bundle(for: XTRElementModel.classForCoder()).path(forResource: documentName, ofType: nil) else { return }
        
        webView.load(URLRequest(url: URL(fileURLWithPath: aPath)))
    }
    
    func loadUserDefaults() {
        elementBubbleSwitch.isOn = XTRPropertiesStore.elementBubblesState
        showTransitionsBubbleSwitch.isOn = XTRPropertiesStore.showTransitionsState
        splashScreenSwitch.isOn = XTRPropertiesStore.splashScreenState
    }
    
    func updateSeriesButtonProperties(_ aButton: UIButton, aColor: UIColor) {
        aButton.backgroundColor = aColor
        aButton.setTitleColor(aColor.inverseColor(), for: UIControlState())
    }
    
    func populateSeriesColors() {
        updateSeriesButtonProperties(seriesActinideButton, aColor: XTRColorFactory.actinideColor)
        updateSeriesButtonProperties(seriesAlkaliEarthMetalButton, aColor: XTRColorFactory.alkaliEarthMetalColor)
        updateSeriesButtonProperties(seriesAlkaliMetalButton, aColor: XTRColorFactory.alkaliMetalColor)
        updateSeriesButtonProperties(seriesHalogenButton, aColor: XTRColorFactory.halogenColor)
        updateSeriesButtonProperties(seriesLanthanideButton, aColor: XTRColorFactory.lanthanideColor)
        updateSeriesButtonProperties(seriesMetalButton, aColor: XTRColorFactory.metalColor)
        updateSeriesButtonProperties(seriesNobleGasButton, aColor: XTRColorFactory.nobleGasColor)
        updateSeriesButtonProperties(seriesNonMetalButton, aColor: XTRColorFactory.nonMetalColor)
        updateSeriesButtonProperties(seriesTransactinidesButton, aColor: XTRColorFactory.transactinideColor)
        updateSeriesButtonProperties(seriesTransitionMetalButton, aColor: XTRColorFactory.transitionMetalColor)
    }
    
    func populateElementBubbleState(_ aFlag: Bool)  {
        XTRPropertiesStore.elementBubblesState = aFlag
    }
    
    func populateShowTransitionsState(_ aFlag: Bool) {
        XTRPropertiesStore.showTransitionsState = aFlag
    }
    
    func populateSplashScreenState(_ aFlag: Bool) {
        XTRPropertiesStore.splashScreenState = aFlag
    }
    
    // MARK: - Action Methods
    
    func resetPreferences() {
        XTRPropertiesStore.resetPreferences()
        
        populateSeriesColors()
        populateElementBubbleState(true)
        populateShowTransitionsState(true)
        populateSplashScreenState(true)
        
        elementBubbleSwitch.isOn = true
        showTransitionsBubbleSwitch.isOn = true
        splashScreenSwitch.isOn = true
        
        NotificationCenter.default.post(name: .seriesColorChangedNotification, object: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destController = segue.destination as! XTRColorPickerViewController
        let seriesIdentifier = (sender as! UIButton).accessibilityIdentifier
        let seriesName = (sender as! UIButton).titleLabel?.text
        
        destController.seriesName = seriesName
        destController.seriesIdentifier = seriesIdentifier
        destController.preferredContentSize = CGSize(width: 270, height: 270)
        destController.popoverPresentationController?.permittedArrowDirections = .left
    }
    
    // MARK: - View Management Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = NSLocalizedString("preferences", comment: "")
        navigationBar.topItem?.title = NSLocalizedString("preferences", comment: "")
        
        NotificationCenter.default.addObserver(self, selector: #selector(XTRPreferencesViewController.colorSelected(notification:)), name: .colorSelectedNotification, object: nil)
        
        loadDocument("Credits.rtf", inView: webView)
        loadUserDefaults()
        populateSeriesColors()
        
        appNameLabel.text = Bundle.main.appNameString
        versionLabel.text = Bundle.main.appVersionString
        cpyRightLabel.text = Bundle.main.copywriteString
        
        styleControl.selectedSegmentIndex = XTRAppearanceManager.manager.isClassicAppearance() ? 0 : 1
        
        navigationController?.navigationBar.prefersLargeTitles = true
        setupRx()
    }
    
    func setupRx() {
        styleControl.rx.value
            .asObservable()
            .subscribe(onNext: { newValue in
                let appearanceName = (newValue == 0) ? XTRAppearanceType.classic : XTRAppearanceType.standard
                
                NotificationCenter.default.post(name: .notificationAppearanceChanged, object: appearanceName)
            }).disposed(by: disposeBag)

        elementBubbleSwitch.rx.isOn
            .asObservable()
            .subscribe(onNext: { newValue in
                self.populateElementBubbleState(newValue)
            }).disposed(by: disposeBag)
        
        showTransitionsBubbleSwitch.rx.isOn
            .asObservable()
            .subscribe(onNext: { newValue in
                self.populateShowTransitionsState(newValue)
            }).disposed(by: disposeBag)
        
        splashScreenSwitch.rx.isOn
            .asObservable()
            .subscribe(onNext: { newValue in
                self.populateSplashScreenState(newValue)
            }).disposed(by: disposeBag)

       resetPreferencesButton.rx.tap.subscribe(onNext: { newValue in
            self.resetPreferences()
        }).disposed(by: disposeBag)

//        let o = Observable.of(seriesActinideButton.rx.tap,
//                              seriesAlkaliEarthMetalButton.rx.tap,
//                              seriesAlkaliMetalButton.rx.tap,
//                              seriesHalogenButton.rx.tap,
//                              seriesLanthanideButton.rx.tap,
//                              seriesMetalButton.rx.tap,
//                              seriesNobleGasButton.rx.tap,
//                              seriesNonMetalButton.rx.tap,
//                              seriesTransactinidesButton.rx.tap,
//                              seriesTransitionMetalButton.rx.tap).merge()
//        
//        o.subscribe(onNext: { newValue in
//            //let seriesIdentifier = (sender as! UIButton).accessibilityIdentifier
//            //let seriesName = (sender as! UIButton).titleLabel?.text
//
//            self.performSegue(withIdentifier: "series", sender: <#T##Any?#>)
//        }).disposed(by: disposeBag)
        
    }
    
    override var shouldAutorotate : Bool {
        return false
    }
    
    override var supportedInterfaceOrientations : UIInterfaceOrientationMask {
        return .landscape
    }
    
    // MARK: - Memory Management Methods
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: .colorSelectedNotification, object: nil)
        
        appNameLabel = nil
        cpyRightLabel = nil
        elementBubbleSwitch = nil
        seriesActinideButton = nil
        seriesAlkaliEarthMetalButton = nil
        seriesAlkaliMetalButton = nil
        seriesHalogenButton = nil
        seriesLanthanideButton = nil
        seriesMetalButton = nil
        seriesNobleGasButton = nil
        seriesNonMetalButton = nil
        seriesTransactinidesButton = nil
        seriesTransitionMetalButton = nil
        showTransitionsBubbleSwitch = nil
        splashScreenSwitch = nil
        versionLabel = nil
        webView = nil
    }
    
}
