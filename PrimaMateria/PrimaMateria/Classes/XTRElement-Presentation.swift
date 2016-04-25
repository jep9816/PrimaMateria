//
//  XTRElement-Presentation.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 4/22/16.
//  Copyright © 2016 xTrensa. All rights reserved.
//

enum SuperScriptType: Int {
    case k0Superscript = 48
    case k1Superscript = 49
    case k2Superscript = 50
    case k3Superscript = 51
    case k4Superscript = 52
    case k5Superscript = 53
    case k6Superscript = 54
    case k7Superscript = 55
    case k8Superscript = 56
    case k9Superscript = 57
}

extension XTRElement {
    func _unknownImage() -> UIImage {
        let aPath : String? = NSBundle(forClass: XTRElement.classForCoder()).pathForResource(STRING_UNKNOWN, ofType: FILE_TYPE_PNG, inDirectory: SUPPORTING_FILES)
        return UIImage.init(contentsOfFile: aPath!)!
    }
    
    func pathForGeneralInfoDoc() -> String {
        let aPath : String? = NSBundle(forClass: XTRElement.classForCoder()).pathForResource(self.symbol(), ofType: FILE_TYPE_RTF, inDirectory: SUPPORTING_FILES)
        return aPath!
    }
    
    func _attributedStringForArray(anArray: NSArray?) -> String? {
        if (anArray == nil) {
            return String.init(format: "%@", STRING_UNKNOWN)
        } else {
            var attributedString : String = String()
            let outerCount = anArray!.count
            for index in 0...outerCount - 1 {
                let aDictionary : NSDictionary = anArray!.objectAtIndex(index) as! NSDictionary
                let allKeys : NSArray = aDictionary.allKeys
                let allValues : NSArray = aDictionary.allValues
                let count = allKeys.count
                if(count > 0) {
                    for i in 0...count - 1 {
                        let aKey : String = allKeys.objectAtIndex(i) as! String
                        let aValue : String = allValues.objectAtIndex(i) as! String
                        
                        if (aKey != "New item") {
                            let aString = Array(arrayLiteral: aValue)[0]
                            let character : Int = Int(aString)!
                            attributedString = attributedString + aKey
                            
                            switch (character) {
                            case SuperScriptType.k0Superscript.rawValue:
                                attributedString = attributedString + "⁰"
                                break
                                
                            case SuperScriptType.k1Superscript.rawValue:
                                attributedString = attributedString + "¹"
                                break
                                
                            case SuperScriptType.k2Superscript.rawValue:
                                attributedString = attributedString + "²"
                                break
                                
                            case SuperScriptType.k3Superscript.rawValue:
                                attributedString = attributedString + "³"
                                break
                                
                            case SuperScriptType.k4Superscript.rawValue:
                                attributedString = attributedString + "⁴"
                                break
                                
                            case SuperScriptType.k5Superscript.rawValue:
                                attributedString = attributedString + "⁵"
                                break
                                
                            case SuperScriptType.k6Superscript.rawValue:
                                attributedString = attributedString + "⁶"
                                break
                                
                            case SuperScriptType.k7Superscript.rawValue:
                                attributedString = attributedString + "⁷"
                                break
                                
                            case SuperScriptType.k8Superscript.rawValue:
                                attributedString = attributedString + "⁸"
                                break
                                
                            case SuperScriptType.k9Superscript.rawValue:
                                attributedString = attributedString + "⁹"
                                break
                                
                            default:
                                break
                            }
                        }
                    }
                }
            }
            return attributedString
        }
    }
    
    func atomicMassAggregate() -> String? {
        let atomicMassKnownAccurately : Bool = self.valueForKey(ELEMENT_ATOMIC_MASS_KNOWN_ACCURATELY) as! Bool
        
        if (!atomicMassKnownAccurately) {
            return String.init(format: "[%@]", self.atomicMass())
        } else {
            let temp : NSNumber? = self.valueForKey(ELEMENT_ATOMIC_MASS_UNCERTAINTY) as? NSNumber
            if (temp != 0) {
                return String.init(format: "%@(%@)", arguments: [self.atomicMass(), temp!])
            }
        }
        return STRING_EMPTY
    }
    
    func atomicMassFootnote() -> String {
        let footnote : String? =  self.valueForKey(ELEMENT_ATOMIC_MASS_FOOTNOTE) as? String
        return (footnote == nil) ? STRING_EMPTY : footnote!
    }
    
    func kShellElectrons() -> String {
        let s1String : String? = self.shell1s()
        
        let tot : NSNumber = ((s1String == STRING_EMPTY) ? 0 : Int(s1String!))!
        return (tot == 0) ? STRING_EMPTY : String.init(format: "%@", tot)
    }
    
    func lShellElectrons() -> String {
        let s2String : String? = self.shell2s()
        let p2String : String? = self.shell2p()
        
        let s2 : NSNumber = ((s2String == STRING_EMPTY) ? 0 : Int(s2String!))!
        let p2 : NSNumber = ((p2String == STRING_EMPTY) ? 0 : Int(p2String!))!
        
        let tot : NSNumber = Int(s2.integerValue + p2.integerValue)
        return (tot == 0) ? STRING_EMPTY : String.init(format: "%@", tot)
    }
    
    func mShellElectrons() -> String {
        let s3String : String? = self.shell3s()
        let p3String : String? = self.shell3p()
        let d3String : String? = self.shell3d()
        
        let s3 : NSNumber = ((s3String == STRING_EMPTY) ? 0 : Int(s3String!))!
        let p3 : NSNumber = ((p3String == STRING_EMPTY) ? 0 : Int(p3String!))!
        let d3 : NSNumber = ((d3String == STRING_EMPTY) ? 0 : Int(d3String!))!
        
        let tot : NSNumber = Int(s3.integerValue + p3.integerValue + d3.integerValue)
        return (tot == 0) ? STRING_EMPTY : String.init(format: "%@", tot)
    }
    
    func nShellElectrons() -> String {
        let s4String : String? = self.shell4s()
        let p4String : String? = self.shell4p()
        let d4String : String? = self.shell4d()
        let f4String : String? = self.shell4f()
        
        let s4 : NSNumber = ((s4String == STRING_EMPTY) ? 0 : Int(s4String!))!
        let p4 : NSNumber = ((p4String == STRING_EMPTY) ? 0 : Int(p4String!))!
        let d4 : NSNumber = ((d4String == STRING_EMPTY) ? 0 : Int(d4String!))!
        let f4 : NSNumber = ((f4String == STRING_EMPTY) ? 0 : Int(f4String!))!
        let tot : NSNumber = Int(s4.integerValue + p4.integerValue + d4.integerValue + f4.integerValue)
        return (tot == 0) ? STRING_EMPTY : String.init(format: "%@", tot)
    }
    
    func oShellElectrons() -> String {
        let s5String : String? = self.shell5s()
        let p5String : String? = self.shell5p()
        let d5String : String? = self.shell5d()
        let f5String : String? = self.shell5f()
        
        let s5 : NSNumber = ((s5String == STRING_EMPTY) ? 0 : Int(s5String!))!
        let p5 : NSNumber = ((p5String == STRING_EMPTY) ? 0 : Int(p5String!))!
        let d5 : NSNumber = ((d5String == STRING_EMPTY) ? 0 : Int(d5String!))!
        let f5 : NSNumber = ((f5String == STRING_EMPTY) ? 0 : Int(f5String!))!
        
        let tot : NSNumber = Int(s5.integerValue + p5.integerValue + d5.integerValue + f5.integerValue)
        return (tot == 0) ? STRING_EMPTY : String.init(format: "%@", tot)
    }
    
    func pShellElectrons() -> String {
        let s6String : String? = self.shell6s()
        let p6String : String? = self.shell6p()
        let d6String : String? = self.shell6d()
        
        let s6 : NSNumber = ((s6String == STRING_EMPTY) ? 0 : Int(s6String!))!
        let p6 : NSNumber = ((p6String == STRING_EMPTY) ? 0 : Int(p6String!))!
        let d6 : NSNumber = ((d6String == STRING_EMPTY) ? 0 : Int(d6String!))!
        
        let tot : NSNumber = Int(s6.integerValue + p6.integerValue + d6.integerValue)
        return (tot == 0) ? STRING_EMPTY : String.init(format: "%@", tot)
    }
    
    func qShellElectrons() -> String {
        let s7String : String? = self.shell7s()
        let p7String : String? = self.shell7p()
        
        let s7 : NSNumber = ((s7String == STRING_EMPTY) ? 0 : Int(s7String!))!
        let p7 : NSNumber = ((p7String == STRING_EMPTY) ? 0 : Int(p7String!))!
        
        let tot : NSNumber = Int(s7.integerValue + p7.integerValue)
        return (tot == 0) ? STRING_EMPTY : String.init(format: "%@", tot)
    }
    
    func shell1s() -> String {
        let aDict : NSDictionary = self.electronConfiguration()!
        let aValue : String? = aDict.objectForKey("1s") as? String
        
        if (aValue != nil && aValue != "?") {
            return aValue!
        } else {
            return STRING_EMPTY
        }
    }
    
    func shell2s() -> String {
        let aDict : NSDictionary = self.electronConfiguration()!
        let aValue : String? = aDict.objectForKey("2s") as? String
        
        if (aValue != nil && aValue != "?") {
            return aValue!
        } else {
            return STRING_EMPTY
        }
    }
    
    func shell2p() -> String {
        let aDict : NSDictionary = self.electronConfiguration()!
        let aValue : String? = aDict.objectForKey("2p") as? String
        
        if (aValue != nil && aValue != "?") {
            return aValue!
        } else {
            return STRING_EMPTY
        }
    }
    
    func shell3s() -> String {
        let aDict : NSDictionary = self.electronConfiguration()!
        let aValue : String? = aDict.objectForKey("3s") as? String
        
        if (aValue != nil && aValue != "?") {
            return aValue!
        } else {
            return STRING_EMPTY
        }
    }
    
    func shell3p() -> String {
        let aDict : NSDictionary = self.electronConfiguration()!
        let aValue : String? = aDict.objectForKey("3p") as? String
        
        if (aValue != nil && aValue != "?") {
            return aValue!
        } else {
            return STRING_EMPTY
        }
    }
    
    func shell3d() -> String {
        let aDict : NSDictionary = self.electronConfiguration()!
        let aValue : String? = aDict.objectForKey("3d") as? String
        
        if (aValue != nil && aValue != "?") {
            return aValue!
        } else {
            return STRING_EMPTY
        }
    }
    
    func shell4s() -> String {
        let aDict : NSDictionary = self.electronConfiguration()!
        let aValue : String? = aDict.objectForKey("4s") as? String
        
        if (aValue != nil && aValue != "?") {
            return aValue!
        } else {
            return STRING_EMPTY
        }
    }
    
    func shell4p() -> String {
        let aDict : NSDictionary = self.electronConfiguration()!
        let aValue : String? = aDict.objectForKey("4p") as? String
        
        if (aValue != nil && aValue != "?") {
            return aValue!
        } else {
            return STRING_EMPTY
        }
    }
    
    func shell4d() -> String {
        let aDict : NSDictionary = self.electronConfiguration()!
        let aValue : String? = aDict.objectForKey("4d") as? String
        
        if (aValue != nil && aValue != "?") {
            return aValue!
        } else {
            return STRING_EMPTY
        }
    }
    
    func shell4f() -> String {
        let aDict : NSDictionary = self.electronConfiguration()!
        let aValue : String? = aDict.objectForKey("4f") as? String
        
        if (aValue != nil && aValue != "?") {
            return aValue!
        } else {
            return STRING_EMPTY
        }
    }
    
    func shell5s() -> String {
        let aDict : NSDictionary = self.electronConfiguration()!
        let aValue : String? = aDict.objectForKey("5s") as? String
        
        if (aValue != nil && aValue != "?") {
            return aValue!
        } else {
            return STRING_EMPTY
        }
    }
    
    func shell5p() -> String {
        let aDict : NSDictionary = self.electronConfiguration()!
        let aValue : String? = aDict.objectForKey("5p") as? String
        
        if (aValue != nil && aValue != "?") {
            return aValue!
        } else {
            return STRING_EMPTY
        }
    }
    
    func shell5d() -> String {
        let aDict : NSDictionary = self.electronConfiguration()!
        let aValue : String? = aDict.objectForKey("5d") as? String
        
        if (aValue != nil && aValue != "?") {
            return aValue!
        } else {
            return STRING_EMPTY
        }
    }
    
    func shell5f() -> String {
        let aDict : NSDictionary = self.electronConfiguration()!
        let aValue : String? = aDict.objectForKey("5f") as? String
        
        if (aValue != nil && aValue != "?") {
            return aValue!
        } else {
            return STRING_EMPTY
        }
    }
    
    func shell6s() -> String {
        let aDict : NSDictionary = self.electronConfiguration()!
        let aValue : String? = aDict.objectForKey("6s") as? String
        
        if (aValue != nil && aValue != "?") {
            return aValue!
        } else {
            return STRING_EMPTY
        }
    }
    
    func shell6p() -> String {
        let aDict : NSDictionary = self.electronConfiguration()!
        let aValue : String? = aDict.objectForKey("6p") as? String
        
        if (aValue != nil && aValue != "?") {
            return aValue!
        } else {
            return STRING_EMPTY
        }
    }
    
    func shell6d() -> String {
        let aDict : NSDictionary = self.electronConfiguration()!
        let aValue : String? = aDict.objectForKey("6d") as? String
        
        if (aValue != nil && aValue != "?") {
            return aValue!
        } else {
            return STRING_EMPTY
        }
    }
    
    func shell7s() -> String {
        let aDict : NSDictionary = self.electronConfiguration()!
        let aValue : String? = aDict.objectForKey("7s") as? String
        
        if (aValue != nil && aValue != "?") {
            return aValue!
        } else {
            return STRING_EMPTY
        }
    }
    
    func shell7p() -> String {
        let aDict : NSDictionary = self.electronConfiguration()!
        let aValue : String? = aDict.objectForKey("7p") as? String
        
        if (aValue != nil && aValue != "?") {
            return aValue!
        } else {
            return STRING_EMPTY
        }
    }
    
    func seriesColor() -> UIColor {
        return XTRColorFactory.colorForString(self.valueForKey(ELEMENT_SERIES) as! String)
    }
    
    func standardConditionColor() -> UIColor {
        return XTRColorFactory.colorForString(self.valueForKey(ELEMENT_STANDARD_CONDITION) as! String)
    }
    
    func crystalStructureImage() -> UIImage {
        let aPath : String? = NSBundle(forClass: XTRElement.classForCoder()).pathForResource(self.valueForKey(ELEMENT_CRYSTAL_STRUCTURE) as? String, ofType: FILE_TYPE_PNG, inDirectory: SUPPORTING_FILES)
        return (aPath != nil) ? UIImage.init(contentsOfFile: aPath!)! : self._unknownImage()
    }
    
    func shellModelImage() -> UIImage {
        let aPath : String? = NSBundle(forClass: XTRElement.classForCoder()).pathForResource(self.symbol()!, ofType: FILE_TYPE_PNG, inDirectory: SUPPORTING_FILES)
        return (aPath != nil) ? UIImage.init(contentsOfFile: aPath!)! : self._unknownImage()
    }
    
    func hardnessScaleBrinellScaled() -> NSNumber {
        let aValue : NSNumber = self.hardnessScaleBrinell()
        return (aValue.floatValue / 100)
    }
    
    func hardnessScaleVickersScaled() -> NSNumber {
        let aValue : NSNumber = self.hardnessScaleVickers()
        return (aValue.floatValue / 100)
    }
    
    func coefficientOfLinealThermalExpansionScaled() -> NSNumber {
        let aValue : NSNumber = self.coefficientOfLinealThermalExpansion()
        return (aValue.floatValue * 100000)
    }
    
    func fillingOrbital() -> String {
        return self._attributedStringForArray(self.valueForKey(ELEMENT_FILLING_ORBITAL) as? NSArray)!
    }
    
    func valence() -> String {
        return self._attributedStringForArray(self.valueForKey(ELEMENT_VALENCE_ELECTRONS) as? NSArray)!
    }
    
    func boilingPointString() -> String {
        return String.init(format: "%@", self.boilingPoint())
    }
    
    func meltingPointString() -> String {
        return String.init(format: "%@", self.meltingPoint())
    }
    
    func nameString() -> String {
        return String.init(format: "Element Inspector for %@", self.name()!)
    }
    
    func periodString() -> String {
        return String.init(format: "%@ ", self.period()!)
    }
    
    func groupString() -> String {
        return String.init(format: "%@ ", self.group()!)
    }
    
    func seriesString() -> String {
        return String.init(format: " %@", self.series()!)
    }
    
    func casRegNoString() -> String {
        return String.init(format: " %@", self.valueForKey(ELEMENT_CAS_REGISTRY_NUMBER) as! String)
    }
}