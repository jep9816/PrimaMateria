//
//  MolecularCalculator.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 4/23/16.
//  Copyright © 2016 xTrensa. All rights reserved.
//

@objc class MolecularCalculator : NSObject {
    
    class func calculateWithFormula(formula: NSString?) -> CGFloat {
        var total : CGFloat = 0
        
        if(formula != nil && formula!.length > 0){
            var regex : NSRegularExpression? = nil
            do {
                try regex = NSRegularExpression.init(pattern: "[A-Z][a-z]*\\d*|\\([^)]+\\)\\d*", options: NSRegularExpressionOptions.CaseInsensitive)
            } catch {
                assert(nil != regex, "Could not create regex. \(error)")
            }
            
            // print("Testing: %@", formula)
            
            let components : NSArray = regex!.matchesInString(formula! as String, options: NSMatchingOptions.Anchored, range: NSMakeRange(0, formula!.length))
            
            for index in 0..<components.count {
                let match : NSTextCheckingResult = components.objectAtIndex(index) as! NSTextCheckingResult
                let element : XTRElement?
                let matchRange : NSRange = match.rangeAtIndex(0)
                let subString : NSString = formula!.substringWithRange(matchRange)
                let characters : NSString = subString.stringByTrimmingCharactersInSet(NSCharacterSet.decimalDigitCharacterSet())
                let numbers : NSString = subString.stringByTrimmingCharactersInSet(NSCharacterSet.letterCharacterSet())
                var multiplier : CGFloat = 0
                var atomicMass : CGFloat = 0
                var num : CGFloat = 0
                
                // print("characters: %@", characters)
                // print("numbers: %@", numbers)
                
                if let doubleValue = Double(numbers as String) {
                    num = CGFloat(doubleValue)
                }
                
                multiplier = (numbers.length == 0) ? 1 : num
                
                element = XTRDataSource.sharedInstance().elementForSymbol(characters as String)
                atomicMass = CGFloat(element!.atomicMass())
                total = total + (atomicMass * multiplier)
                // print("total: %f", total)
            }
        }
        return total
    }
}
