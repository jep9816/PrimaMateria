//
//  XTRMolecularCalculator
//  PrimaMateria
//
//  Created by Jerry Porter on 4/23/16.
//  Copyright ©2018 xTrensa. All rights reserved.
//

class XTRMolecularCalculator : NSObject {
    
    class func calculateWithFormula(_ formula: String?) -> Float {
        var total : Float = 0.0
        
        if let localFormula = formula.map({ $0 as NSString }) {
            if localFormula.length > 0 {
                var regex : NSRegularExpression? = nil
                
                do {
                    try regex = NSRegularExpression(pattern: "[A-Z][a-z]*\\d*|\\([^)]+\\)\\d*", options: NSRegularExpression.Options.caseInsensitive)
                } catch {
                    assert(nil != regex, "Could not create regex. \(error)")
                }
                
                // print("Testing: %@", formula)
                
                let components = regex!.matches(in: localFormula as String, options: NSRegularExpression.MatchingOptions.anchored, range: NSMakeRange(0, localFormula.length))
                
                for index in 0..<components.count {
                    let match = components[index] 
                    let matchRange = match.range(at: 0)
                    let subString = localFormula.substring(with: matchRange) as NSString
                    let characters = subString.trimmingCharacters(in: CharacterSet.decimalDigits) as NSString
                    let numbers = subString.trimmingCharacters(in: CharacterSet.letters) as NSString
                    let element : XTRElement? = XTRDataSource.sharedInstance().elementForSymbol(characters as String)
                    let atomicMass = element!.atomicMass
                    var multiplier : Float = 0.0
                    var num : Float = 0.0

                    // print("characters: %@", characters)
                    // print("numbers: %@", numbers)
                    
                    if let doubleValue = Double(numbers as String) {
                        num = doubleValue != 0 ? Float(doubleValue) : 1
                    }
                    
                    multiplier = (numbers.length == 0) ? 1 : num
                    total = total + (atomicMass * multiplier)
                    // print("total: %f", total)
                }
            }
        }
        
        return total
    }
    
}
