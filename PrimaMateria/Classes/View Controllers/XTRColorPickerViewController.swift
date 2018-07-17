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
    
    //var seriesName: String?
    var seriesIdentifier: String?
    var disposeBag = DisposeBag()
    
    // MARK: - Initialization Methods
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    // MARK: - Internal Methods
    
    func presetSlidersWithColor(_ aColor: UIColor) {
        redSlider.setValue(Float(aColor.red()), animated: true)
        greenSlider.setValue(Float(aColor.green()), animated: true)
        blueSlider.setValue(Float(aColor.blue()), animated: true)
        alphaSlider.setValue(Float(aColor.alpha()), animated: true)
        
        previewView.backgroundColor = UIColor(red: CGFloat(redSlider.value), green: CGFloat(greenSlider.value), blue: CGFloat(blueSlider.value), alpha: CGFloat(alphaSlider.value))
    }
    
    // MARK: - View Management Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let aColor = XTRColorFactory.colorForString(seriesIdentifier!)

        title = NSLocalizedString("colorPicker", comment: "")
        colorTitle.text =  NSLocalizedString(seriesIdentifier!, comment: "")
        
        previewView.backgroundColor = aColor
        previewView.layer.cornerRadius = 9
        
        selectColorButton.layer.cornerRadius = 4
        selectColorButton.layer.borderColor = XTRColorFactory.buttonBorderColor.cgColor
        selectColorButton.layer.borderWidth = 1
        
        presetSlidersWithColor(aColor)

        setupRx()
    }
    
    func setupRx() {
        redSlider.rx.value
            .asObservable()
            .subscribe(onNext: { newValue in
                UIView.beginAnimations(nil, context: nil)
                self.previewView.backgroundColor = UIColor(red: CGFloat(newValue), green: CGFloat(self.greenSlider.value), blue: CGFloat(self.blueSlider.value), alpha: CGFloat(self.alphaSlider.value))
            }).disposed(by: disposeBag)
        
        greenSlider.rx.value
            .asObservable()
            .subscribe(onNext: { newValue in
                UIView.beginAnimations(nil, context: nil)
                self.previewView.backgroundColor = UIColor(red: CGFloat(self.redSlider.value), green: CGFloat(newValue), blue: CGFloat(self.blueSlider.value), alpha: CGFloat(self.alphaSlider.value))
            }).disposed(by: disposeBag)
        
        blueSlider.rx.value
            .asObservable()
            .subscribe(onNext: { newValue in
                UIView.beginAnimations(nil, context: nil)
                self.previewView.backgroundColor = UIColor(red: CGFloat(self.redSlider.value), green: CGFloat(self.greenSlider.value), blue: CGFloat(newValue), alpha: CGFloat(self.alphaSlider.value))
            }).disposed(by: disposeBag)
        
        alphaSlider.rx.value
            .asObservable()
            .subscribe(onNext: { newValue in
                UIView.beginAnimations(nil, context: nil)
                self.previewView.backgroundColor = UIColor(red: CGFloat(self.redSlider.value), green: CGFloat(self.greenSlider.value), blue: CGFloat(self.blueSlider.value), alpha: CGFloat(newValue))
            }).disposed(by: disposeBag)
        
        selectColorButton.rx.tap.subscribe(onNext: { _ in
            let dict = zip(
                [
                    ColorComponent.red,
                    ColorComponent.green,
                    ColorComponent.blue,
                    ColorComponent.alpha,
                    SERIES_IDENTIFIER_KEY
                ], [
                    self.redSlider.value,
                    self.greenSlider.value,
                    self.blueSlider.value,
                    self.alphaSlider.value,
                    self.seriesIdentifier!
                ]).reduce([String: Any]()) {
                    var prop = $0
                    prop[$1.0] = $1.1
                    return prop
            }
            
            self.dismiss(animated: true, completion: nil)
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
