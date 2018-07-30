//
//  XTRColorPickerViewController.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 4/14/16.
//  Copyright © 2018 xTrensa. All rights reserved.
//

import RxSwift
import RxCocoa

class XTRColorPickerViewController: UIViewController {
    
    @IBOutlet var redSlider: UISlider!
    @IBOutlet var greenSlider: UISlider!
    @IBOutlet var blueSlider: UISlider!
    @IBOutlet var alphaSlider: UISlider!
    @IBOutlet var colorTitle: UILabel!
    @IBOutlet var previewView: UIView!
    @IBOutlet var selectColorButton: XTRLocalizedButton!
    
    var seriesIdentifier: String?
    var disposeBag = DisposeBag()
    
    // MARK: - Initialization Methods
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    // MARK: - Internal Methods
    
    func presetSlidersWithColor(_ aColor: UIColor) {
        redSlider.setValue(Float(aColor.red()), animated: XTRPropertiesStore.showTransitionsState)
        greenSlider.setValue(Float(aColor.green()), animated: XTRPropertiesStore.showTransitionsState)
        blueSlider.setValue(Float(aColor.blue()), animated: XTRPropertiesStore.showTransitionsState)
        alphaSlider.setValue(Float(aColor.alpha()), animated: XTRPropertiesStore.showTransitionsState)
        
        previewView.backgroundColor = UIColor(red: CGFloat(redSlider.value), green: CGFloat(greenSlider.value), blue: CGFloat(blueSlider.value), alpha: CGFloat(alphaSlider.value))
    }
    
    // MARK: - View Management Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let aColor = XTRColorFactory.colorForString(seriesIdentifier!)

        title = NSLocalizedString("colorPicker", comment: "")
        colorTitle.text =  NSLocalizedString(seriesIdentifier!, comment: "")
        
        previewView.backgroundColor = aColor
        previewView.layer.cornerRadius = VIEW_CORNER_RADIUS + 2.0
        
        selectColorButton.layer.cornerRadius = VIEW_CORNER_RADIUS
        selectColorButton.layer.borderColor = XTRColorFactory.buttonBorderColor.cgColor
        selectColorButton.layer.borderWidth = 1
        
        presetSlidersWithColor(aColor)

        setupRx()
    }
    
    func setupRx() {
        redSlider.rx.value
            .asObservable()
            .subscribe(onNext: { [weak self] newValue in
                let red = CGFloat(newValue)
                let green = CGFloat((self?.greenSlider.value)!)
                let blue = CGFloat((self?.blueSlider.value)!)
                let alpha = CGFloat((self?.alphaSlider.value)!)
                UIView.beginAnimations(nil, context: nil)
                self?.previewView.backgroundColor = UIColor(red: red, green: green, blue: blue, alpha: alpha)
            }).disposed(by: disposeBag)
        
        greenSlider.rx.value
            .asObservable()
            .subscribe(onNext: { [weak self] newValue in
                let red = CGFloat((self?.redSlider.value)!)
                let green = CGFloat(newValue)
                let blue = CGFloat((self?.blueSlider.value)!)
                let alpha = CGFloat((self?.alphaSlider.value)!)
                UIView.beginAnimations(nil, context: nil)
                self?.previewView.backgroundColor = UIColor(red: red, green: green, blue: blue, alpha: alpha)
            }).disposed(by: disposeBag)
        
        blueSlider.rx.value
            .asObservable()
            .subscribe(onNext: { [weak self] newValue in
                let red = CGFloat((self?.redSlider.value)!)
                let green = CGFloat((self?.greenSlider.value)!)
                let blue = CGFloat(newValue)
                let alpha = CGFloat((self?.alphaSlider.value)!)
                UIView.beginAnimations(nil, context: nil)
                self?.previewView.backgroundColor = UIColor(red: red, green: green, blue: blue, alpha: alpha)
            }).disposed(by: disposeBag)
        
        alphaSlider.rx.value
            .asObservable()
            .subscribe(onNext: { [weak self] newValue in
                let red = CGFloat((self?.redSlider.value)!)
                let green = CGFloat((self?.greenSlider.value)!)
                let blue = CGFloat((self?.blueSlider.value)!)
                let alpha = CGFloat(newValue)
                UIView.beginAnimations(nil, context: nil)
                self?.previewView.backgroundColor = UIColor(red: red, green: green, blue: blue, alpha: alpha)
            }).disposed(by: disposeBag)
        
        selectColorButton.rx.tap.subscribe(onNext: { [weak self] _ in
            let red = CGFloat((self?.redSlider.value)!)
            let green = CGFloat((self?.greenSlider.value)!)
            let blue = CGFloat((self?.blueSlider.value)!)
            let alpha = CGFloat((self?.alphaSlider.value)!)
            let identifier: String = self?.seriesIdentifier! ?? ""
            
            let dict = zip(
                [
                    ColorComponent.red,
                    ColorComponent.green,
                    ColorComponent.blue,
                    ColorComponent.alpha,
                    SERIES_IDENTIFIER_KEY
                ], [
                    red,
                    green,
                    blue,
                    alpha,
                    identifier
                ]).reduce([String: Any]()) {
                    var prop = $0
                    prop[$1.0] = $1.1
                    return prop
            }
            
            self?.dismiss(animated: XTRPropertiesStore.showTransitionsState, completion: nil)
            NotificationCenter.default.post(name: .colorSelectedNotification, object: dict)
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
        redSlider = nil
        greenSlider = nil
        blueSlider = nil
        alphaSlider = nil
        previewView = nil
        colorTitle = nil
    }
    
}
