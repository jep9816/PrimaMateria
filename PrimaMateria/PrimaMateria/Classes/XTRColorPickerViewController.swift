//
//  XTRColorPickerViewController.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 4/14/16.
//  Copyright © 2016 xTrensa. All rights reserved.
//

@objc class XTRColorPickerViewController : UIViewController {
    @IBOutlet weak var redSlider : UISlider!
    @IBOutlet weak var greenSlider : UISlider!
    @IBOutlet weak var blueSlider : UISlider!
    @IBOutlet weak var colorTitle : UILabel!
    @IBOutlet weak var previewView: UIView!
    
    // MARK: - Initialization Methods
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    // MARK: - Internal Methods
    
    // MARK: - Action Methods
    
    @IBAction func selectColor(sender: UIButton) {
        let values : NSArray = [self.redSlider.value, self.greenSlider.value, self.blueSlider.value, self.colorTitle.text!]
        let keys: NSArray = [RED_COLOR_COMPONENT, GREEN_COLOR_COMPONENT, BLUE_COLOR_COMPONENT, SERIES_COLOR_KEY]
        let dict: NSDictionary = NSDictionary.init(objects: values as [AnyObject], forKeys: keys as! [NSCopying])
        self.dismissViewControllerAnimated(true, completion:  nil)
        NSNotificationCenter.defaultCenter().postNotificationName(NOTIFICATION_COLOR_SELECTED, object: dict)
    }
    
    func presetSlidersWithColor(aColor: UIColor) {
        self.redSlider.setValue(Float(aColor.red), animated:  true)
        self.greenSlider.setValue(Float(aColor.green), animated: true)
        self.blueSlider.setValue(Float(aColor.blue), animated: true)
        self.previewView.backgroundColor = UIColor.init(red: CGFloat(self.redSlider.value), green: CGFloat(self.greenSlider.value), blue: CGFloat(self.blueSlider.value), alpha: 1.0)
    }
    
    @IBAction func redSliderValueChanged(sender: UISlider) {
        UIView.beginAnimations(nil, context: nil)
        self.previewView.backgroundColor = UIColor.init(red: CGFloat(sender.value), green: CGFloat(self.greenSlider.value), blue: CGFloat(self.blueSlider.value), alpha: 1.0)
    }
    
    @IBAction func greenSliderValueChanged(sender: UISlider) {
        UIView.beginAnimations(nil, context: nil)
        self.previewView.backgroundColor = UIColor.init(red: CGFloat(self.redSlider.value), green: CGFloat(sender.value), blue: CGFloat(self.blueSlider.value), alpha: 1.0)
    }
    
    @IBAction func blueSliderValueChanged(sender: UISlider) {
        UIView.beginAnimations(nil, context: nil)
        self.previewView.backgroundColor = UIColor.init(red: CGFloat(self.redSlider.value), green: CGFloat(self.greenSlider.value), blue: CGFloat(sender.value), alpha: 1.0)
    }
    
    // MARK: - View Management Methods
    
    override func shouldAutorotate() -> Bool {
        return true
    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return [UIInterfaceOrientationMask.LandscapeLeft, UIInterfaceOrientationMask.LandscapeRight]
    }
    
    // MARK: - Memory Management Methods
    
    deinit {
        self.redSlider = nil
        self.greenSlider = nil
        self.blueSlider = nil
        self.previewView = nil
        self.colorTitle = nil
    }
}
