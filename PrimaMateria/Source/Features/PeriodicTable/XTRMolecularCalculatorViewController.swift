//
//  XTRMolecularCalculatorViewController.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 4/24/16.
//  Copyright ©2021 xTrensa. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class XTRMolecularCalculatorViewController: UIViewController {

    @IBOutlet var errorLabel: UILabel!
    @IBOutlet var formulaLabel: UILabel!
    @IBOutlet var resultsLabel: UILabel!
    @IBOutlet var formulaTextField: UITextField!
    @IBOutlet var backgroundView: UIView!
    @IBOutlet var calculateButton: UIButton!
    @IBOutlet var clearButton: UIButton!
    @IBOutlet var oneButton: UIButton!
    @IBOutlet var twoButton: UIButton!
    @IBOutlet var threeButton: UIButton!
    @IBOutlet var fourButton: UIButton!
    @IBOutlet var fiveButton: UIButton!
    @IBOutlet var sixButton: UIButton!
    @IBOutlet var sevenButton: UIButton!
    @IBOutlet var eightButton: UIButton!
    @IBOutlet var nineButton: UIButton!
    @IBOutlet var zeroButton: UIButton!

    var disposeBag: DisposeBag = DisposeBag()

    // MARK: - Initialization Methods

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
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

    func calculate() {
        let result = XTRMolecularCalculatorEngine.calculateWithFormula(formulaTextField.text)

        if result == 0 {
            errorLabel.text = NSLocalizedString("errorMessage", comment: "")
        } else {
            resultsLabel.text = String(format: "%f", result)
            errorLabel.text =  STRING_EMPTY
        }
    }

    // MARK: - Action Methods

    func numberTapped(_ sender: UIButton) {
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

    func setupRx() {
        Observable.of(
            mapToObserver(button: oneButton),
            mapToObserver(button: twoButton),
            mapToObserver(button: threeButton),
            mapToObserver(button: fourButton),
            mapToObserver(button: fiveButton),
            mapToObserver(button: sixButton),
            mapToObserver(button: sevenButton),
            mapToObserver(button: eightButton),
            mapToObserver(button: nineButton),
            mapToObserver(button: zeroButton)
            ).merge().subscribe(onNext: { [weak self] sender in
                self?.numberTapped(sender)
            }).disposed(by: disposeBag)

        calculateButton.rx.tap.subscribe(onNext: { [weak self] _ in
            self?.calculate()
        }).disposed(by: disposeBag)

        clearButton.rx.tap.subscribe(onNext: { [weak self] _ in
            self?.clear()
        }).disposed(by: disposeBag)
    }

    // MARK: - View Management Methods

    override func viewDidLoad() {
        super.viewDidLoad()

        backgroundView.borderColor = UIColor.black
        backgroundView.borderWidth = 2
        backgroundView.cornerRadius = VIEW_CORNER_RADIUS

        setupRx()
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
        calculateButton = nil
        clearButton = nil
        oneButton = nil
        twoButton = nil
        threeButton = nil
        fourButton = nil
        fiveButton = nil
        sixButton = nil
        sevenButton = nil
        eightButton = nil
        nineButton = nil
        zeroButton = nil
    }

}
