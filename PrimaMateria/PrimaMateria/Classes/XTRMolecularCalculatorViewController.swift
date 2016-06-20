//
//  XTRMolecularCalculatorViewController.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 4/24/16.
//  Copyright © 2016 xTrensa. All rights reserved.
//

@objc class XTRMolecularCalculatorViewController : UIViewController {
    @IBOutlet var errorLabel : UILabel!
    @IBOutlet var formulaLabel : UILabel!
    @IBOutlet var resultsLabel : UILabel!
    @IBOutlet var formulaTextField : UITextField!
    @IBOutlet var backgroundView : UIView!
    
    // MARK: - Initialization Methods
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    // MARK: - Internal Methods
    
    func clear() {
        self.errorLabel.text = STRING_EMPTY
        self.formulaTextField.text = STRING_EMPTY
        self.formulaLabel.text = STRING_EMPTY
        self.resultsLabel.text = STRING_EMPTY
    }
    
    func setTextFieldForNumber(aNumber: Int) {
        var origString : String = self.formulaTextField.text!
        origString = origString + String(format: "%d", aNumber)
        self.formulaTextField.text = origString
    }
    
    func setLabelForNumber(aNumber: Int) {
        let origString : String = self.formulaLabel.text!
        
        switch (aNumber) {
        case 0:
            self.formulaLabel.text = origString + "\u{2080}"
        case 1:
            self.formulaLabel.text = origString + "\u{2081}"
        case 2:
            self.formulaLabel.text = origString + "\u{2082}"
        case 3:
            self.formulaLabel.text = origString + "\u{2083}"
        case 4:
            self.formulaLabel.text = origString + "\u{2084}"
        case 5:
            self.formulaLabel.text = origString + "\u{2085}"
        case 6:
            self.formulaLabel.text = origString + "\u{2086}"
        case 7:
            self.formulaLabel.text = origString + "\u{2087}"
        case 8:
            self.formulaLabel.text = origString + "\u{2088}"
        case 9:
            self.formulaLabel.text = origString + "\u{2089}"
        default:
            break
        }
    }
    
    func setTextFieldForSymbol(aSymbol: String) {
        var origString : String = self.formulaTextField.text!
        origString = origString + aSymbol
        self.formulaTextField.text = origString
        self.errorLabel.text = STRING_EMPTY
    }
    
    func setLabelForSymbol(aSymbol: String) {
        var origString : String = self.formulaLabel.text!
        origString = origString + aSymbol
        self.formulaLabel.text = origString
        self.errorLabel.text = STRING_EMPTY
    }
    
    func setElement(anElement: XTRElement) {
        self.setTextFieldForSymbol(anElement.symbol()!)
        self.setLabelForSymbol(anElement.symbol()!)
    }
    
    // MARK: - Action Methods
    
    @IBAction func calculate(sender: UIButton) {
        let result : CGFloat = MolecularCalculator.calculateWithFormula(self.formulaTextField.text)
        
        if (result == 0){
            self.errorLabel.text =  "Unknown symbol or syntax error."
        } else {
            self.resultsLabel.text = String(format: "%f", result)
            self.errorLabel.text =  STRING_EMPTY
        }
    }
    
    @IBAction func clear(sender: UIButton) {
        self.clear()
    }
    
    @IBAction func numberClicked(sender: UIButton) {
        let length : Int = (self.formulaTextField.text?.characters.count)!
        let tag : Int = sender.tag
        
        if (length > 0) {
            let formula : NSString = self.formulaTextField.text! as NSString
            let indexAlpha : String = formula.substringFromIndex(length - 1) as String
            
            var is_alpha : Bool = false
            var is_char : Bool = false
            
            for scalar in indexAlpha.unicodeScalars {
                let value = scalar.value
                if (value >= 65 && value <= 90) || (value >= 97 && value <= 122) {
                    is_alpha = true
                }
                
                if (value >= 48 && value <= 57) {
                    is_char = true
                }
            }
            
            if (is_alpha || is_char){
                self.setTextFieldForNumber(tag)
                self.setLabelForNumber(tag)
            }
        }
    }
    
    // MARK: - View Management Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.backgroundView.layer.borderColor = UIColor.blackColor().CGColor
        self.backgroundView.layer.borderWidth = 2
        self.backgroundView.layer.cornerRadius = 8
        
        self.clear()
    }
    
    override func viewWillDisappear(animated: Bool)  {
        self.clear()
        
        super.viewWillDisappear(animated)
    }
    
    override func shouldAutorotate() -> Bool {
        return true
    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return [UIInterfaceOrientationMask.LandscapeLeft, UIInterfaceOrientationMask.LandscapeRight]
    }
    
    // MARK: - Memory Management Methods
    
    deinit {
        self.errorLabel = nil
        self.formulaTextField = nil
        self.formulaLabel = nil
        self.resultsLabel = nil
    }
}
