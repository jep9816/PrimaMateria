//
//  XTRColorPickerViewController.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 4/14/16.
//  Copyright © 2018 xTrensa. All rights reserved.
//

class XTRColorPickerViewController : UIViewController {
    
    @IBOutlet var redSlider : UISlider!
    @IBOutlet var greenSlider : UISlider!
    @IBOutlet var blueSlider : UISlider!
    @IBOutlet var alphaSlider : UISlider!
    @IBOutlet var colorTitle : UILabel!
    @IBOutlet var previewView: UIView!
    @IBOutlet var selectColorButton: XTRLocalizedButton!

    var seriesName : String?
    
    // MARK: - Initialization Methods
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    // MARK: - Internal Methods
    
    // MARK: - Action Methods
    
    @IBAction func selectColor(_ sender: UIButton) {
        let values = [redSlider.value, greenSlider.value, blueSlider.value, alphaSlider.value, colorTitle.text!] as [Any]
        let keys = [ColorComponent.red, ColorComponent.green, ColorComponent.blue, ColorComponent.alpha, SERIES_COLOR_KEY]
        let dict = zip(keys, values).reduce([String : Any]()){ var d = $0; d[$1.0] = $1.1; return d }
        
        dismiss(animated: true, completion:  nil)
        NotificationCenter.default.post(name: .colorSelectedNotification, object: dict)
    }
    
    func presetSlidersWithColor(_ aColor: UIColor) {
        redSlider.setValue(Float(aColor.red()), animated:  true)
        greenSlider.setValue(Float(aColor.green()), animated: true)
        blueSlider.setValue(Float(aColor.blue()), animated: true)
        alphaSlider.setValue(Float(aColor.alpha()), animated: true)
        
        previewView.backgroundColor = UIColor(red: CGFloat(redSlider.value), green: CGFloat(greenSlider.value), blue: CGFloat(blueSlider.value), alpha: CGFloat(alphaSlider.value))
    }
    
    @IBAction func redSliderValueChanged(_ sender: UISlider) {
        UIView.beginAnimations(nil, context: nil)
        previewView.backgroundColor = UIColor(red: CGFloat(sender.value), green: CGFloat(greenSlider.value), blue: CGFloat(blueSlider.value), alpha: CGFloat(alphaSlider.value))
    }
    
    @IBAction func greenSliderValueChanged(_ sender: UISlider) {
        UIView.beginAnimations(nil, context: nil)
        previewView.backgroundColor = UIColor(red: CGFloat(redSlider.value), green: CGFloat(sender.value), blue: CGFloat(blueSlider.value), alpha: CGFloat(alphaSlider.value))
    }
    
    @IBAction func blueSliderValueChanged(_ sender: UISlider) {
        UIView.beginAnimations(nil, context: nil)
        previewView.backgroundColor = UIColor(red: CGFloat(redSlider.value), green: CGFloat(greenSlider.value), blue: CGFloat(sender.value), alpha: CGFloat(alphaSlider.value))
    }
    
    @IBAction func alphaSliderValueChanged(_ sender: UISlider) {
        UIView.beginAnimations(nil, context: nil)
        previewView.backgroundColor = UIColor(red: CGFloat(redSlider.value), green: CGFloat(greenSlider.value), blue: CGFloat(blueSlider.value), alpha: CGFloat(sender.value))
    }
    
    // MARK: - View Management Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = NSLocalizedString("colorPicker", comment: "")
        
        let aColor = XTRColorFactory.colorForString(seriesName!)
        colorTitle.text = seriesName!
        // TODO:
        // Localize this after localizing Series names
        // maybe put this in Element presentation
        previewView.backgroundColor = aColor
        presetSlidersWithColor(aColor)
        selectColorButton.layer.cornerRadius = 4
        selectColorButton.layer.borderColor = XTRColorFactory.buttonBorderColor.cgColor
        selectColorButton.layer.borderWidth = 1
    }
    
    override var shouldAutorotate : Bool {
        return false
    }
    
    override var supportedInterfaceOrientations : UIInterfaceOrientationMask {
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
