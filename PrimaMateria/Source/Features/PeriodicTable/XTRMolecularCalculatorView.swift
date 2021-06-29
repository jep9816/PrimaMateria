//
//  XTRMolecularCalculatorView.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 6/29/21.
//  Copyright © 2021 Jerry Porter. All rights reserved.
//

import SwiftUI

struct XTRMolecularCalculatorViewConfig {
    static let preferredContentSize = CGSize(width: 380, height: 155)
}

class MolecularCalculatorEnvironment: ObservableObject {
    @Published var element: XTRElementModel!
}

class MolecularCalculatorModel: ObservableObject {
    @Published var element: XTRElementModel!
}

class MolecularCalculatorProperty: ObservableObject {
    @Published var propertyValue: String = ""
}

struct XTRMolecularCalculatorView: View {
    
    @EnvironmentObject var environment: MolecularCalculatorEnvironment
    
    @ObservedObject private var errorMessage: MolecularCalculatorProperty = MolecularCalculatorProperty()
    @ObservedObject private var formulaLabelText: MolecularCalculatorProperty = MolecularCalculatorProperty()
    @ObservedObject private var resultsLabelText: MolecularCalculatorProperty = MolecularCalculatorProperty()
    @ObservedObject private var formulaText: MolecularCalculatorProperty = MolecularCalculatorProperty()
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: nil) {
                VStack {
                    Text(NSLocalizedString("molecularCalculator", comment: "Molecular Calculator"))
                        .font(.system(size: 17.0))
                        .fontWeight(.bold)
                        .frame(width: 213, height: 24, alignment: .center)
                    
                    Text(formulaLabelText.propertyValue)
                        .frame(width: 213, height: 27, alignment: .leading)
                        .background(Color.white)
                        .font(.system(size: 18.0))
                        .border(Color.black, width: 1)
                }
                .padding(.top)
                
                //Spacer()
                
                Text(errorMessage.propertyValue)
                    .frame(width: 213, height: 42, alignment: .center)
                    .background(Color.clear)
                    .font(.system(size: 17.0))
                    .foregroundColor(.red)
                    .multilineTextAlignment(.center)
                    .fixedSize(horizontal: false, vertical: true)

                //Spacer()
                
                VStack {
                    Text(NSLocalizedString("atomicWeight", comment: "Atomic Weight"))
                        .font(.system(size: 17.0))
                        .fontWeight(.bold)
                        .frame(width: 213, height: 26, alignment: .center)
                    
                    Text(resultsLabelText.propertyValue)
                        .frame(width: 213, height: 27, alignment: .leading)
                        .background(Color.white)
                        .font(.system(size: 18.0))
                        .border(Color.black, width: 1)
                }
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0))
            }
            .padding(/*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: nil) {
                HStack {
                    XTRCalculatorButtonView(buttonText: "7️⃣", function: self.numberTapped(tag: 0))
                    XTRCalculatorButtonView(buttonText: "8️⃣", function: self.numberTapped(tag: 8))
                    XTRCalculatorButtonView(buttonText: "9️⃣", function: self.numberTapped(tag: 9))
                }
                
                HStack {
                    XTRCalculatorButtonView(buttonText: "4️⃣", function: self.numberTapped(tag: 4))
                    XTRCalculatorButtonView(buttonText: "5️⃣", function: self.numberTapped(tag: 5))
                    XTRCalculatorButtonView(buttonText: "6️⃣", function: self.numberTapped(tag: 6))
                }
                
                HStack {
                    XTRCalculatorButtonView(buttonText: "1️⃣", function: self.numberTapped(tag: 1))
                    XTRCalculatorButtonView(buttonText: "2️⃣", function: self.numberTapped(tag: 2))
                    XTRCalculatorButtonView(buttonText: "3️⃣", function: self.numberTapped(tag: 3))
                }
                
                HStack {
                    XTRCalculatorButtonView(buttonText: "❎", function: self.clear)
                    XTRCalculatorButtonView(buttonText: "0️⃣", function: self.numberTapped(tag: 0))
                    XTRCalculatorButtonView(buttonText: "✅", function: self.calculate)
                }
            }
            .padding(EdgeInsets(top: 8, leading: 0, bottom: 10, trailing: 5)
            )
        }
        .frame(
            width: XTRMolecularCalculatorViewConfig.preferredContentSize.width,
            height: XTRMolecularCalculatorViewConfig.preferredContentSize.height,
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
        print("Symbol: \(String(describing: formulaText.propertyValue))")
        errorMessage.propertyValue = STRING_EMPTY
    }
    
    func updateLabel(_ symbol: String) {
        var origString = formulaLabelText.propertyValue
        origString += symbol
        formulaLabelText.propertyValue = origString
        print("Symbol: \(String(describing: formulaLabelText.propertyValue))")
        errorMessage.propertyValue = STRING_EMPTY
    }
    
    mutating func updateElement(_ model: MolecularCalculatorModel) {
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

struct XTRMolecularCalculatorView_Previews: PreviewProvider {
    static var previews: some View {
        XTRMolecularCalculatorView().previewLayout(.fixed(width: XTRMolecularCalculatorViewConfig.preferredContentSize.width, height: XTRMolecularCalculatorViewConfig.preferredContentSize.height))
    }
    
}

struct XTRCalculatorButtonView: View {
    
    var buttonText: String!
    var function: () -> Void
    
    var body: some View {
        Button(action: function) {
            Text(buttonText)
                .font(.system(size: 32.0))
        }
    }
    
}
