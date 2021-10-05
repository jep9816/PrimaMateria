//
//  SUIMolecularCalculatorView.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 6/29/21.
//  Copyright ©2021 Jerry Porter. All rights reserved.
//

import SwiftUI

struct SUIMolecularCalculatorViewConfig {
    static let preferredContentSize = CGSize(width: 420, height: 155)
    static let textFieldWidth: CGFloat = 270
    static let textFieldHeight: CGFloat = 24
}

struct SUIMolecularCalculatorView: View {
    
    @EnvironmentObject var environment: SUIMolecularCalculatorEnvironment
    
    @ObservedObject private var errorMessage: SUIMolecularCalculatorProperty = SUIMolecularCalculatorProperty()
    @ObservedObject private var formulaLabelText: SUIMolecularCalculatorProperty = SUIMolecularCalculatorProperty()
    @ObservedObject private var resultsLabelText: SUIMolecularCalculatorProperty = SUIMolecularCalculatorProperty()
    @ObservedObject private var formulaText: SUIMolecularCalculatorProperty = SUIMolecularCalculatorProperty()
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: nil) {
                VStack {
                    Text(NSLocalizedString("molecularCalculator", comment: "Molecular Calculator"))
                        .font(XTRFontFactory.system17)
                        .fontWeight(.bold)
                        .frame(width: SUIMolecularCalculatorViewConfig.textFieldWidth, height: SUIMolecularCalculatorViewConfig.textFieldHeight, alignment: .center)
                    
                    Text(formulaLabelText.propertyValue)
                        .frame(width: SUIMolecularCalculatorViewConfig.textFieldWidth, height: SUIMolecularCalculatorViewConfig.textFieldHeight, alignment: .leading)
                        .background(Color.white)
                        .font(XTRFontFactory.system18)
                        .border(Color.black, width: 1)
                }
                .padding(EdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 0))
                                
                Text(errorMessage.propertyValue)
                    .frame(width: SUIMolecularCalculatorViewConfig.textFieldWidth, height: SUIMolecularCalculatorViewConfig.textFieldHeight, alignment: .center)
                    .background(Color.clear)
                    .font(XTRFontFactory.system17)
                    .foregroundColor(.red)
                    .multilineTextAlignment(.center)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(EdgeInsets(top: -5, leading: 0, bottom: 0, trailing: 0))

                VStack {
                    Text(NSLocalizedString("atomicWeight", comment: "Atomic Weight"))
                        .font(XTRFontFactory.system17)
                        .fontWeight(.bold)
                        .frame(width: SUIMolecularCalculatorViewConfig.textFieldWidth, height: SUIMolecularCalculatorViewConfig.textFieldHeight, alignment: .center)
                    
                    Text(resultsLabelText.propertyValue)
                        .frame(width: SUIMolecularCalculatorViewConfig.textFieldWidth, height: SUIMolecularCalculatorViewConfig.textFieldHeight, alignment: .leading)
                        .background(Color.white)
                        .font(XTRFontFactory.system18)
                        .border(Color.black, width: 1)
                }
                .padding(EdgeInsets(top: -10, leading: 0, bottom: 10, trailing: 0))
            }
            .padding(/*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: nil) {
                HStack {
                    SUICalculatorButtonView(buttonText: "7️⃣", function: self.numberTapped(tag: 0))
                    SUICalculatorButtonView(buttonText: "8️⃣", function: self.numberTapped(tag: 8))
                    SUICalculatorButtonView(buttonText: "9️⃣", function: self.numberTapped(tag: 9))
                }
                
                HStack {
                    SUICalculatorButtonView(buttonText: "4️⃣", function: self.numberTapped(tag: 4))
                    SUICalculatorButtonView(buttonText: "5️⃣", function: self.numberTapped(tag: 5))
                    SUICalculatorButtonView(buttonText: "6️⃣", function: self.numberTapped(tag: 6))
                }
                
                HStack {
                    SUICalculatorButtonView(buttonText: "1️⃣", function: self.numberTapped(tag: 1))
                    SUICalculatorButtonView(buttonText: "2️⃣", function: self.numberTapped(tag: 2))
                    SUICalculatorButtonView(buttonText: "3️⃣", function: self.numberTapped(tag: 3))
                }
                
                HStack {
                    SUICalculatorButtonView(buttonText: "❎", function: self.clear)
                    SUICalculatorButtonView(buttonText: "0️⃣", function: self.numberTapped(tag: 0))
                    SUICalculatorButtonView(buttonText: "✅", function: self.calculate)
                }
            }
            .padding(EdgeInsets(top: 8, leading: 0, bottom: 10, trailing: 5)
            )
        }
        .frame(
            width: SUIMolecularCalculatorViewConfig.preferredContentSize.width,
            height: SUIMolecularCalculatorViewConfig.preferredContentSize.height,
            //swiftlint:disable colon
            alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
        .background(Color(XTRColorFactory.tableViewCellBorderColor))
        .border(Color.black, width: 2.0)
    }
    
    // swiftlint:disable void_return
    func numberTapped(tag: Int) -> () -> () {
        return {
            let length = formulaText.propertyValue.count
            
            if length > 0 {
                let formula: String = formulaText.propertyValue
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
    }
    
    func updateTextField(_ number: Int) {
        var origString: String = formulaText.propertyValue
        origString += String(format: "%d", number)
        formulaText.propertyValue = origString
    }
    
    func updateLabel(_ number: Int) {
        let origString: String = formulaLabelText.propertyValue
        
        switch number {
        case 0:
            formulaLabelText.propertyValue = origString + "\u{2080}"
        case 1:
            formulaLabelText.propertyValue = origString + "\u{2081}"
        case 2:
            formulaLabelText.propertyValue = origString + "\u{2082}"
        case 3:
            formulaLabelText.propertyValue = origString + "\u{2083}"
        case 4:
            formulaLabelText.propertyValue = origString + "\u{2084}"
        case 5:
            formulaLabelText.propertyValue = origString + "\u{2085}"
        case 6:
            formulaLabelText.propertyValue = origString + "\u{2086}"
        case 7:
            formulaLabelText.propertyValue = origString + "\u{2087}"
        case 8:
            formulaLabelText.propertyValue = origString + "\u{2088}"
        case 9:
            formulaLabelText.propertyValue = origString + "\u{2089}"
        default:
            break
        }
    }
    
    func updateTextField(_ symbol: String) {
        var origString: String = formulaText.propertyValue
        
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
        
        formulaText.propertyValue = origString
        //print("Symbol: \(String(describing: formulaText.propertyValue))")
        errorMessage.propertyValue = STRING_EMPTY
    }
    
    func updateLabel(_ symbol: String) {
        var origString = formulaLabelText.propertyValue
        origString += symbol
        formulaLabelText.propertyValue = origString
        //print("Symbol: \(String(describing: formulaLabelText.propertyValue))")
        errorMessage.propertyValue = STRING_EMPTY
    }
    
    mutating func updateElement(_ model: SUIMolecularCalculatorModel) {
        updateTextField(model.element.symbol!)
        updateLabel(model.element.symbol!)
    }
    
    func calculate() {
        let result = XTRMolecularCalculatorEngine.calculateWithFormula(formulaText.propertyValue)
        
        if result == 0 {
            errorMessage.propertyValue = NSLocalizedString("errorMessage", comment: "")
        } else {
            resultsLabelText.propertyValue = String(format: "%f", result)
            errorMessage.propertyValue =  STRING_EMPTY
        }
    }
    
    func clear() {
        errorMessage.propertyValue = STRING_EMPTY
        formulaText.propertyValue = STRING_EMPTY
        formulaLabelText.propertyValue = STRING_EMPTY
        resultsLabelText.propertyValue = STRING_EMPTY
    }
    
}

struct SUIMolecularCalculatorView_Previews: PreviewProvider {
    static var previews: some View {
        SUIMolecularCalculatorView().previewLayout(.fixed(width: SUIMolecularCalculatorViewConfig.preferredContentSize.width, height: SUIMolecularCalculatorViewConfig.preferredContentSize.height))
    }
    
}
