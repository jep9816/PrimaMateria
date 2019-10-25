//
//  XTRPreferencesViewController.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 4/22/16.
//  Copyright © 2019 xTrensa. All rights reserved.
//

import WebKit
import RxSwift
import RxCocoa

struct XTRPreferencesViewControllerConfig {
    static let colorPickerContentSize = CGSize(width: 270, height: 270)
}

class XTRPreferencesViewController: UIViewController {
    
    @IBOutlet var appNameLabel: UILabel!
    @IBOutlet var cpyRightLabel: UILabel!
    @IBOutlet var seriesActinideButton: UIButton!
    @IBOutlet var seriesAlkaliEarthMetalButton: UIButton!
    @IBOutlet var seriesAlkaliMetalButton: UIButton!
    @IBOutlet var seriesHalogenButton: UIButton!
    @IBOutlet var seriesLanthanideButton: UIButton!
    @IBOutlet var seriesMetalButton: UIButton!
    @IBOutlet var seriesNobleGasButton: UIButton!
    @IBOutlet var seriesNonMetalButton: UIButton!
    @IBOutlet var seriesTransactinidesButton: UIButton!
    @IBOutlet var seriesTransitionMetalButton: UIButton!
    @IBOutlet var resetPreferencesButton: UIButton!
    @IBOutlet var versionLabel: UILabel!
    @IBOutlet var elementBubbleSwitch: UISwitch!
    @IBOutlet var showTransitionsBubbleSwitch: UISwitch!
    @IBOutlet var splashScreenSwitch: UISwitch!
    @IBOutlet var webView: WKWebView!
    @IBOutlet var segmentedControl: UISegmentedControl!
    @IBOutlet var navigationBar: UINavigationBar!
    @IBOutlet var globeImageView: UIImageView!
    
    var disposeBag: DisposeBag = DisposeBag()
    var animationImages: [UIImage] = []
    
    // MARK: - Initialization Methods
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    // MARK: - Internal Methods
    
    @objc func colorSelected(notification: Notification) {
        guard let anObject: [String: AnyObject] = notification.object as! [String: AnyObject]? else { return }
        
        let redComponent = anObject[ColorComponent.red] as! CGFloat
        let greenComponent = anObject[ColorComponent.green] as! CGFloat
        let blueComponent = anObject[ColorComponent.blue] as! CGFloat
        let alphaComponent = anObject[ColorComponent.alpha] as! CGFloat
        
        let seriesIdentifier = anObject[SERIES_IDENTIFIER_KEY] as! String
        let color = UIColor(red: redComponent, green: greenComponent, blue: blueComponent, alpha: alphaComponent)
        let colorData = try? NSKeyedArchiver.archivedData(withRootObject: color, requiringSecureCoding: false)
        
        XTRPropertiesStore.setColorData(colorData, key: seriesIdentifier)
        
        switch seriesIdentifier {
        case ElementSeries.actinide :
            updateSeriesProperties(seriesActinideButton, color: color)
        case ElementSeries.alkaliEarthMetal :
            updateSeriesProperties(seriesAlkaliEarthMetalButton, color: color)
        case ElementSeries.alkaliMetal :
            updateSeriesProperties(seriesAlkaliMetalButton, color: color)
        case ElementSeries.halogen :
            updateSeriesProperties(seriesHalogenButton, color: color)
        case ElementSeries.lanthanide :
            updateSeriesProperties(seriesLanthanideButton, color: color)
        case ElementSeries.metal :
            updateSeriesProperties(seriesMetalButton, color: color)
        case ElementSeries.nobleGas :
            updateSeriesProperties(seriesNobleGasButton, color: color)
        case ElementSeries.nonMetal :
            updateSeriesProperties(seriesNonMetalButton, color: color)
        case ElementSeries.transactinide :
            updateSeriesProperties(seriesTransactinidesButton, color: color)
        default :
            updateSeriesProperties(seriesTransitionMetalButton, color: color)
        }
        
        NotificationCenter.default.post(name: .seriesColorChangedNotification, object: nil)
        
        dismiss(animated: XTRPropertiesStore.showTransitionsState, completion: nil)
    }
    
    func setupGlobalImageView() {
        globeImageView.layer.cornerRadius = VIEW_CORNER_RADIUS + 10.0
        globeImageView.layer.backgroundColor = UIColor.clear.cgColor
        globeImageView.backgroundColor = UIColor.clear
        globeImageView.addInteraction(UIContextMenuInteraction(delegate: self))
        
        for index in 1...72 {
            let numValue =  String(format: "%02d", index)
            let imageName = "Globe\(numValue).png"
            animationImages.append(UIImage(named: imageName)!)
        }
    }
    
    func startAnimating() {
        globeImageView.animationImages = animationImages
        globeImageView.animationDuration = 5.0
        globeImageView.startAnimating()
    }
    
    func loadDocument(_ name: String, inView: WKWebView) {
        guard let aPath = Bundle(for: XTRElementModel.classForCoder()).path(forResource: name, ofType: nil) else { return }
        
        webView.load(URLRequest(url: URL(fileURLWithPath: aPath)))
    }
    
    func loadUserDefaults() {
        elementBubbleSwitch.isOn = XTRPropertiesStore.elementBubblesState
        showTransitionsBubbleSwitch.isOn = XTRPropertiesStore.showTransitionsState
        splashScreenSwitch.isOn = XTRPropertiesStore.splashScreenState
    }
    
    func updateSeriesProperties(_ button: UIButton, color: UIColor) {
        button.backgroundColor = color
        button.setTitleColor(color.inverseColor(), for: UIControl.State())
    }
    
    func populateSeriesColors() {
        updateSeriesProperties(seriesActinideButton, color: XTRColorFactory.actinideColor)
        updateSeriesProperties(seriesAlkaliEarthMetalButton, color: XTRColorFactory.alkaliEarthMetalColor)
        updateSeriesProperties(seriesAlkaliMetalButton, color: XTRColorFactory.alkaliMetalColor)
        updateSeriesProperties(seriesHalogenButton, color: XTRColorFactory.halogenColor)
        updateSeriesProperties(seriesLanthanideButton, color: XTRColorFactory.lanthanideColor)
        updateSeriesProperties(seriesMetalButton, color: XTRColorFactory.metalColor)
        updateSeriesProperties(seriesNobleGasButton, color: XTRColorFactory.nobleGasColor)
        updateSeriesProperties(seriesNonMetalButton, color: XTRColorFactory.nonMetalColor)
        updateSeriesProperties(seriesTransactinidesButton, color: XTRColorFactory.transactinideColor)
        updateSeriesProperties(seriesTransitionMetalButton, color: XTRColorFactory.transitionMetalColor)
    }
    
    func populateElementBubbleState(_ flag: Bool) {
        XTRPropertiesStore.elementBubblesState = flag
    }
    
    func populateShowTransitionsState(_ flag: Bool) {
        XTRPropertiesStore.showTransitionsState = flag
    }
    
    func populateSplashScreenState(_ flag: Bool) {
        XTRPropertiesStore.splashScreenState = flag
    }
    
    // MARK: - Action Methods
    
    func resetPreferences() {
        let alertController = UIAlertController(title: NSLocalizedString("resetPreferences", comment: ""), message: NSLocalizedString("resetPreferencesDefault", comment: ""), preferredStyle: .alert)
        let yesAction = UIAlertAction(title: NSLocalizedString("yes", comment: ""), style: .cancel) {[weak self] _ in
            XTRPropertiesStore.resetPreferences()
            
            self?.populateSeriesColors()
            self?.populateElementBubbleState(true)
            self?.populateShowTransitionsState(true)
            self?.populateSplashScreenState(true)
            
            self?.elementBubbleSwitch.isOn = true
            self?.showTransitionsBubbleSwitch.isOn = true
            self?.splashScreenSwitch.isOn = true
            self?.segmentedControl.selectedSegmentIndex = 0
            
            self?.applyLanguage(code: "en")
            
            NotificationCenter.default.post(name: .seriesColorChangedNotification, object: nil)
        }
        
        let noAction = UIAlertAction(title: NSLocalizedString("no", comment: ""), style: .destructive)
        alertController.addAction(noAction)
        alertController.addAction(yesAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func setupRx() {
        segmentedControl.rx.value
            .asObservable()
            .subscribe(onNext: { newValue in
                let appearanceName = (newValue == 0) ? XTRAppearanceType.classic: XTRAppearanceType.standard
                
                NotificationCenter.default.post(name: .notificationAppearanceChanged, object: appearanceName)
            }).disposed(by: disposeBag)
        
        elementBubbleSwitch.backgroundColor = XTRColorFactory.switchBackgroundColor
        elementBubbleSwitch.cornerRadius = SWITCH_CORNER_RADIUS
        elementBubbleSwitch.rx.isOn
            .asObservable()
            .subscribe(onNext: { [weak self] newValue in
                self?.populateElementBubbleState(newValue)
            }).disposed(by: disposeBag)
        
        showTransitionsBubbleSwitch.backgroundColor = XTRColorFactory.switchBackgroundColor
        showTransitionsBubbleSwitch.cornerRadius = SWITCH_CORNER_RADIUS
        showTransitionsBubbleSwitch.rx.isOn
            .asObservable()
            .subscribe(onNext: { [weak self] newValue in
                self?.populateShowTransitionsState(newValue)
            }).disposed(by: disposeBag)
        
        splashScreenSwitch.backgroundColor = XTRColorFactory.switchBackgroundColor
        splashScreenSwitch.cornerRadius = SWITCH_CORNER_RADIUS
        splashScreenSwitch.rx.isOn
            .asObservable()
            .subscribe(onNext: { [weak self] newValue in
                self?.populateSplashScreenState(newValue)
            }).disposed(by: disposeBag)
        
        resetPreferencesButton.rx.tap.subscribe(onNext: { [weak self] _ in
            self?.resetPreferences()
        }).disposed(by: disposeBag)
        
        let array = [
            mapToObserver(button: seriesActinideButton),
            mapToObserver(button: seriesAlkaliEarthMetalButton),
            mapToObserver(button: seriesAlkaliMetalButton),
            mapToObserver(button: seriesHalogenButton),
            mapToObserver(button: seriesLanthanideButton),
            mapToObserver(button: seriesMetalButton),
            mapToObserver(button: seriesNobleGasButton),
            mapToObserver(button: seriesNonMetalButton),
            mapToObserver(button: seriesTransactinidesButton),
            mapToObserver(button: seriesTransitionMetalButton)
        ]
        Observable.merge(array).subscribe(onNext: { [weak self] sender in
            self?.presentColorPicker(sender)
        }).disposed(by: disposeBag)
    }
    
    func presentColorPicker(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: StoryBoardName.ColorPicker, bundle: nil)
        let colorPicker: XTRColorPickerViewController = storyboard.instantiateViewController(withIdentifier: XTRColorPickerViewController.nameOfClass) as! XTRColorPickerViewController
        
        colorPicker.seriesIdentifier = sender.accessibilityIdentifier
        colorPicker.preferredContentSize = XTRPreferencesViewControllerConfig.colorPickerContentSize
        colorPicker.modalPresentationStyle = .popover
        
        self.present(colorPicker, animated: XTRPropertiesStore.showTransitionsState, completion: nil)
        
        let presentationController = colorPicker.popoverPresentationController
        presentationController?.permittedArrowDirections = .left
        presentationController?.sourceView = sender.superview
        presentationController?.sourceRect = sender.frame
    }
    
    private func applyLanguage(code: String) {
        XTRPropertiesStore.currentLanguageCode = code
        LocaleManager.apply(locale: Locale(identifier: code))
    }
    
    private func createAction(code: String, titleKey: String, flagImage: UIImage) -> UIAction {
        let currentLanguageCode = XTRPropertiesStore.currentLanguageCode
        
        let action = UIAction(title: NSLocalizedString(titleKey, comment: ""), image: flagImage, state: currentLanguageCode == code ? .on : .off) { _ in
            self.applyLanguage(code: code)
        }
        if currentLanguageCode == code {
            action.attributes = [.disabled]
        }
        
        return action
    }
    
    func makeContextMenu() -> UIMenu {
        return UIMenu(title: NSLocalizedString("chooseLanguage", comment: ""), children: [
            createAction(code: "en", titleKey: "english", flagImage: "🇺🇸".image()!),
            createAction(code: "es", titleKey: "spanish", flagImage: "🇪🇸".image()!),
            createAction(code: "ru", titleKey: "russian", flagImage: "🇷🇺".image()!),
            createAction(code: "fr", titleKey: "french", flagImage: "🇫🇷".image()!)
        ])
    }
    
    // MARK: - View Management Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = NSLocalizedString("preferences", comment: "")
        navigationBar.topItem?.title = title
        
        NotificationCenter.default.addObserver(self, selector: #selector(colorSelected(notification:)), name: .colorSelectedNotification, object: nil)
        
        loadDocument("Credits.rtf", inView: webView)
        loadUserDefaults()
        populateSeriesColors()
        
        appNameLabel.text = Bundle.main.appNameString
        versionLabel.text = Bundle.main.appVersionString
        cpyRightLabel.text = Bundle.main.copywriteString
        
        segmentedControl.cornerRadius = VIEW_CORNER_RADIUS - 4.0
        segmentedControl.masksToBounds = true
        segmentedControl.selectedSegmentIndex = XTRAppearanceManager.manager.isClassicAppearance() ? 0: 1
        segmentedControl.setTitle(NSLocalizedString("classic", comment: ""), forSegmentAt: 0)
        segmentedControl.setTitle(NSLocalizedString("standard", comment: ""), forSegmentAt: 1)
        
        navigationController?.navigationBar.prefersLargeTitles = true
        setupRx()
        setupGlobalImageView()
        startAnimating()
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscape
    }
    
    // MARK: - Memory Management Methods
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: .colorSelectedNotification, object: nil)
        
        appNameLabel = nil
        cpyRightLabel = nil
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
        resetPreferencesButton = nil
        versionLabel = nil
        elementBubbleSwitch = nil
        showTransitionsBubbleSwitch = nil
        splashScreenSwitch = nil
        webView = nil
        segmentedControl = nil
        navigationBar = nil
    }
    
}

extension XTRPreferencesViewController: UIContextMenuInteractionDelegate {
    
    func contextMenuInteraction(_ interaction: UIContextMenuInteraction, configurationForMenuAtLocation location: CGPoint) -> UIContextMenuConfiguration? {
        return UIContextMenuConfiguration(identifier: nil, previewProvider: nil, actionProvider: { _ in
            return self.makeContextMenu()
        })
    }
    
}
