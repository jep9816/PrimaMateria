//
//  XTRMolecularCalculatorViewController.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 4/24/16.
//  Copyright © 2018 xTrensa. All rights reserved.
//

import UIKit

class XTRMolecularCalculatorViewController: UIViewController {
    
    @IBOutlet var errorLabel: UILabel!
    @IBOutlet var formulaLabel: UILabel!
    @IBOutlet var resultsLabel: UILabel!
    @IBOutlet var formulaTextField: UITextField!
    @IBOutlet var backgroundView: UIView!
    
    // MARK: - Initialization Methods
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    // MARK: - Internal Methods
    
    func clear() {
        errorLabel.text = STRING_EMPTY
        formulaTextField.text = STRING_EMPTY
        formulaLabel.text = STRING_EMPTY
        resultsLabel.text = STRING_EMPTY
    }
    
    func updateTextField(_ number: Int) {
        var origString = formulaTextField.text!
        origString += String(format: "%d", number)
        formulaTextField.text = origString
    }
    
    func updateLabel(_ number: Int) {
        let origString = formulaLabel.text!
        
        switch number {
        case 0:
            formulaLabel.text = origString + "\u{2080}"
        case 1:
            formulaLabel.text = origString + "\u{2081}"
        case 2:
            formulaLabel.text = origString + "\u{2082}"
        case 3:
            formulaLabel.text = origString + "\u{2083}"
        case 4:
            formulaLabel.text = origString + "\u{2084}"
        case 5:
            formulaLabel.text = origString + "\u{2085}"
        case 6:
            formulaLabel.text = origString + "\u{2086}"
        case 7:
            formulaLabel.text = origString + "\u{2087}"
        case 8:
            formulaLabel.text = origString + "\u{2088}"
        case 9:
            formulaLabel.text = origString + "\u{2089}"
        default:
            break
        }
    }
    
    func updateTextField(_ symbol: String) {
        var origString = formulaTextField.text!

        if origString.isEmpty {
            let lastChar = origString.suffix(1)
            
            var isAlpha = false
            
            for scalar in lastChar.unicodeScalars {
                let value = scalar.value
                if (value >= 65 && value <= 90) || (value >= 97 && value <= 122) {
                    isAlpha = true
                }
            }
            
            origString = isAlpha ? origString  + "0" + symbol: origString + symbol
            
        } else {
            origString += symbol
        }

        formulaTextField.text = origString
        errorLabel.text = STRING_EMPTY
    }
    
    func updateLabel(_ symbol: String) {
        var origString = formulaLabel.text!
        origString += symbol
        formulaLabel.text = origString
        errorLabel.text = STRING_EMPTY
    }
    
    func setElement(_ anElement: XTRElementModel) {
        updateTextField(anElement.symbol!)
        updateLabel(anElement.symbol!)
    }
    
    // MARK: - Action Methods
    
    @IBAction func calculate(_ sender: UIButton) {
        let result = XTRMolecularCalculator.calculateWithFormula(formulaTextField.text)
        
        if result == 0 {
            errorLabel.text = NSLocalizedString("errorMessage", comment: "")
        } else {
            resultsLabel.text = String(format: "%f", result)
            errorLabel.text =  STRING_EMPTY
        }
    }
    
    @IBAction func clear(_ sender: UIButton) {
        clear()
    }
    
    @IBAction func numberClicked(_ sender: UIButton) {
        let length = (formulaTextField.text?.count)!
        let tag = sender.tag
        
        if length > 0 {
            let formula = formulaTextField.text!
            let index = formula.index(formula.startIndex, offsetBy: length - 1)
            let indexAlpha = formula[index...]

            var isAlpha = false
            var isChar = false
            
            for scalar in indexAlpha.unicodeScalars {
                let value = scalar.value
                if (value >= 65 && value <= 90) || (value >= 97 && value <= 122) {
                    isAlpha = true
                }
                
                if value >= 48 && value <= 57 {
                    isChar = true
                }
            }
            
            if isAlpha || isChar {
                updateTextField(tag)
                updateLabel(tag)
            }
        }
    }
    
    // MARK: - View Management Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backgroundView.layer.borderColor = UIColor.black.cgColor
        backgroundView.layer.borderWidth = 2
        backgroundView.layer.cornerRadius = 8
        
        clear()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        clear()
        
        super.viewWillDisappear(animated)
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscape
    }
    
    // MARK: - Memory Management Methods
    
    deinit {
        errorLabel = nil
        formulaTextField = nil
        formulaLabel = nil
        resultsLabel = nil
    }
    
}
