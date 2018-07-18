//
//  XTRElement-Presentation.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 4/22/16.
//  Copyright © 2018 xTrensa. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

enum SuperScriptType {
    static let k0Superscript = 48
    static let k1Superscript = 49
    static let k2Superscript = 50
    static let k3Superscript = 51
    static let k4Superscript = 52
    static let k5Superscript = 53
    static let k6Superscript = 54
    static let k7Superscript = 55
    static let k8Superscript = 56
    static let k9Superscript = 57
}

extension XTRElementModel {
    
    func pathForGeneralInfoDoc() -> String {
        if let aPath = Bundle(for: XTRElementModel.classForCoder()).path(forResource: symbol, ofType: FileType.rtf, inDirectory: SUPPORTING_FILES) {
            return aPath
        }
        
        return STRING_EMPTY
    }
    
    var atomicMassAggregate: String {
        let atomicMassKnownAccurately = value(forKeyPath: ELEMENT_ATOMIC_MASS_KNOWN_ACCURATELY) as! Bool
        
        if !atomicMassKnownAccurately {
            return String(format: "[%d]", atomicMass)
        } else {
            let uncertainity = value(forKeyPath: ELEMENT_ATOMIC_MASS_UNCERTAINTY) as! Int64
            let atomicMass = value(forKeyPath: ELEMENT_ATOMIC_MASS) as! String
            
            if uncertainity != 0 {
                return String(format: "%@(%d)", arguments: [atomicMass, uncertainity])
            }
        }
        
        return STRING_EMPTY
    }
    
    var atomicMassFootnote: String {
        let footnote: String? =  value(forKeyPath: ELEMENT_ATOMIC_MASS_FOOTNOTE) as? String
        
        return (footnote == nil) ? STRING_EMPTY: footnote!
    }
    
    var kShellElectrons: String {
        let s1String: String? = shell1s
        let tot = (s1String == STRING_EMPTY) ? NSNumber(value: 0): NSNumber(value: Int(s1String!)!)
        
        return (tot == 0) ? STRING_EMPTY: String(format: "%@", tot)
    }
    
    var lShellElectrons: String {
        let s2String: String? = shell2s
        let p2String: String? = shell2p
        let s2Value = (s2String == STRING_EMPTY) ? NSNumber(value: 0): NSNumber(value: Int(s2String!)!)
        let p2Value = (p2String == STRING_EMPTY) ? NSNumber(value: 0): NSNumber(value: Int(p2String!)!)
        let tot = NSNumber(value: Int(s2Value.intValue + p2Value.intValue))
        
        return (tot == 0) ? STRING_EMPTY: String(format: "%@", tot)
    }
    
    var mShellElectrons: String {
        let s3String: String? = shell3s
        let p3String: String? = shell3p
        let d3String: String? = shell3d
        let s3Value = (s3String == STRING_EMPTY) ? NSNumber(value: 0): NSNumber(value: Int(s3String!)!)
        let p3Value = (p3String == STRING_EMPTY) ? NSNumber(value: 0): NSNumber(value: Int(p3String!)!)
        let d3Value = (d3String == STRING_EMPTY) ? NSNumber(value: 0): NSNumber(value: Int(d3String!)!)
        let tot = NSNumber(value: Int(s3Value.intValue + p3Value.intValue + d3Value.intValue))
        
        return (tot == 0) ? STRING_EMPTY: String(format: "%@", tot)
    }
    
    var nShellElectrons: String {
        let s4String: String? = shell4s
        let p4String: String? = shell4p
        let d4String: String? = shell4d
        let f4String: String? = shell4f
        let s4Value = (s4String == STRING_EMPTY) ? NSNumber(value: 0): NSNumber(value: Int(s4String!)!)
        let p4Value = (p4String == STRING_EMPTY) ? NSNumber(value: 0): NSNumber(value: Int(p4String!)!)
        let d4Value = (d4String == STRING_EMPTY) ? NSNumber(value: 0): NSNumber(value: Int(d4String!)!)
        let f4Value = (f4String == STRING_EMPTY) ? NSNumber(value: 0): NSNumber(value: Int(f4String!)!)
        let tot = NSNumber(value: Int(s4Value.intValue + p4Value.intValue + d4Value.intValue + f4Value.intValue))
        
        return (tot == 0) ? STRING_EMPTY: String(format: "%@", tot)
    }
    
    var oShellElectrons: String {
        let s5String: String? = shell5s
        let p5String: String? = shell5p
        let d5String: String? = shell5d
        let f5String: String? = shell5f
        let s5Value = (s5String == STRING_EMPTY) ? NSNumber(value: 0): NSNumber(value: Int(s5String!)!)
        let p5Value = (p5String == STRING_EMPTY) ? NSNumber(value: 0): NSNumber(value: Int(p5String!)!)
        let d5Value = (d5String == STRING_EMPTY) ? NSNumber(value: 0): NSNumber(value: Int(d5String!)!)
        let f5Value = (f5String == STRING_EMPTY) ? NSNumber(value: 0): NSNumber(value: Int(f5String!)!)
        let tot = NSNumber(value: Int(s5Value.intValue + p5Value.intValue + d5Value.intValue + f5Value.intValue))
        
        return (tot == 0) ? STRING_EMPTY: String(format: "%@", tot)
    }
    
    var pShellElectrons: String {
        let s6String: String? = shell6s
        let p6String: String? = shell6p
        let d6String: String? = shell6d
        let s6Value = (s6String == STRING_EMPTY) ? NSNumber(value: 0): NSNumber(value: Int(s6String!)!)
        let p6Value = (p6String == STRING_EMPTY) ? NSNumber(value: 0): NSNumber(value: Int(p6String!)!)
        let d6Value = (d6String == STRING_EMPTY) ? NSNumber(value: 0): NSNumber(value: Int(d6String!)!)
        let tot = NSNumber(value: Int(s6Value.intValue + p6Value.intValue + d6Value.intValue))
        
        return (tot == 0) ? STRING_EMPTY: String(format: "%@", tot)
    }
    
    var qShellElectrons: String {
        let s7String: String? = shell7s
        let p7String: String? = shell7p
        let s7Value = (s7String! == STRING_EMPTY) ? NSNumber(value: 0): NSNumber(value: Int(s7String!)!)
        let p7Value = (p7String! == STRING_EMPTY) ? NSNumber(value: 0): NSNumber(value: Int(p7String!)!)
        let tot = NSNumber(value: Int(s7Value.intValue + p7Value.intValue))
        
        return (tot == 0) ? STRING_EMPTY: String(format: "%@", tot)
    }
    
    var shell1s: String {
        let aDict = electronConfiguration!
        let aValue: String? = aDict["1s"] as? String
        
        return (aValue != nil && aValue != "?") ? aValue!: STRING_EMPTY
    }
    
    var shell2s: String {
        let aDict = electronConfiguration!
        let aValue: String? = aDict["2s"] as? String
        
        return (aValue != nil && aValue != "?") ? aValue!: STRING_EMPTY
    }
    
    var shell2p: String {
        let aDict = electronConfiguration!
        let aValue: String? = aDict["2p"] as? String
        
        return (aValue != nil && aValue != "?") ? aValue!: STRING_EMPTY
    }
    
    var shell3s: String {
        let aDict = electronConfiguration!
        let aValue: String? = aDict["3s"] as? String
        
        return (aValue != nil && aValue != "?") ? aValue!: STRING_EMPTY
    }
    
    var shell3p: String {
        let aDict = electronConfiguration!
        let aValue: String? = aDict["3p"] as? String
        
        return (aValue != nil && aValue != "?") ? aValue!: STRING_EMPTY
    }
    
    var shell3d: String {
        let aDict = electronConfiguration!
        let aValue: String? = aDict["3d"] as? String
        
        return (aValue != nil && aValue != "?") ? aValue!: STRING_EMPTY
    }
    
    var shell4s: String {
        let aDict = electronConfiguration!
        let aValue: String? = aDict["4s"] as? String
        
        return (aValue != nil && aValue != "?") ? aValue!: STRING_EMPTY
    }
    
    var shell4p: String {
        let aDict = electronConfiguration!
        let aValue: String? = aDict["4p"] as? String
        
        return (aValue != nil && aValue != "?") ? aValue!: STRING_EMPTY
    }
    
    var shell4d: String {
        let aDict = electronConfiguration!
        let aValue: String? = aDict["4d"] as? String
        
        return (aValue != nil && aValue != "?") ? aValue!: STRING_EMPTY
    }
    
    var shell4f: String {
        let aDict = electronConfiguration!
        let aValue: String? = aDict["4f"] as? String
        
        return (aValue != nil && aValue != "?") ? aValue!: STRING_EMPTY
    }
    
    var shell5s: String {
        let aDict = electronConfiguration!
        let aValue: String? = aDict["5s"] as? String
        
        return (aValue != nil && aValue != "?") ? aValue!: STRING_EMPTY
    }
    
    var shell5p: String {
        let aDict = electronConfiguration!
        let aValue: String? = aDict["5p"] as? String
        
        return (aValue != nil && aValue != "?") ? aValue!: STRING_EMPTY
    }
    
    var shell5d: String {
        let aDict = electronConfiguration!
        let aValue: String? = aDict["5d"] as? String
        
        return (aValue != nil && aValue != "?") ? aValue!: STRING_EMPTY
    }
    
    var shell5f: String {
        let aDict = electronConfiguration!
        let aValue: String? = aDict["5f"] as? String
        
        return (aValue != nil && aValue != "?") ? aValue!: STRING_EMPTY
    }
    
    var shell6s: String {
        let aDict = electronConfiguration!
        let aValue: String? = aDict["6s"] as? String
        
        return (aValue != nil && aValue != "?") ? aValue!: STRING_EMPTY
    }
    
    var shell6p: String {
        let aDict = electronConfiguration!
        let aValue: String? = aDict["6p"] as? String
        
        return (aValue != nil && aValue != "?") ? aValue!: STRING_EMPTY
    }
    
    var shell6d: String {
        let aDict = electronConfiguration!
        let aValue: String? = aDict["6d"] as? String
        
        return (aValue != nil && aValue != "?") ? aValue!: STRING_EMPTY
    }
    
    var shell7s: String {
        let aDict = electronConfiguration!
        let aValue: String? = aDict["7s"] as? String
        
        return (aValue != nil && aValue != "?") ? aValue!: STRING_EMPTY
    }
    
    var shell7p: String {
        let aDict = electronConfiguration!
        let aValue: String? = aDict["7p"] as? String
        
        return (aValue != nil && aValue != "?") ? aValue!: STRING_EMPTY
    }
    
    var seriesColor: UIColor {
        let series = value(forKeyPath: ELEMENT_SERIES) as! String
        let camelCased = series.camelCasedString.lowercasingFirstLetter()
        return XTRColorFactory.colorForString(camelCased)
    }
    
    var standardConditionColor: UIColor {
        return XTRColorFactory.colorForString(value(forKeyPath: ELEMENT_STANDARD_CONDITION) as! String)
    }
    
    var crystalStructureScene: SCNScene {
        let crystalStructure = self.value(forKeyPath: ELEMENT_CRYSTAL_STRUCTURE) as! String
        return SCNScene(named: crystalStructure + ".scn")!
    }
    
    var shellModelScene: XTRShellModelScene {
        return XTRShellModelScene(size: CGSize(width: 322, height: 322), element: self)
    }
    
    var hardnessScaleBrinellScaled: Double {
        let aValue = hardnessScaleBrinell
        return aValue / 100.0
    }
    
    var hardnessScaleVickersScaled: Double {
        let aValue = hardnessScaleVickers
        return aValue / 100.0
    }
    
    var coeffOfLinealThermExpansScaled: Double {
        let aValue = coefficientOfLinealThermalExpansion
        return aValue * 100000.0
    }
    
    var fillingOrbital: String {
        let aValue = value(forKeyPath: ELEMENT_FILLING_ORBITAL) as! [Any]?
        return _attributedStringForArray(aValue)!
    }
    
    var valence: String {
        let aValue = value(forKeyPath: ELEMENT_VALENCE_ELECTRONS) as! [Any]?
        return _attributedStringForArray(aValue)!
    }
    
    func nameString() -> String {
        return "\(NSLocalizedString("elementInspectorFor", comment: "")) \( name!)"
    }
    
    var groupString: String {
        return "\(group!) "
    }
    
    var casRegNoString: String {
        return " \(value(forKeyPath: ELEMENT_CAS_REGISTRY_NUMBER) as! String)"
    }
    
    private func _attributedStringForArray(_ anArray: [Any]?) -> String? {
        if anArray == nil {
            return STRING_UNKNOWN
        } else {
            var attributedString = ""
            let outerCount = anArray!.count
            
            for index in 0..<outerCount {
                let aDictionary = anArray![index] as! [String: String]
                let keysCollection = aDictionary.keys
                let valuesCollection = aDictionary.values
                let allKeys = Array(keysCollection)
                let allValues = Array(valuesCollection)
                let counter = allKeys.count
                
                for idx in 0..<counter {
                    let aKey = allKeys[idx]
                    let aValue = allValues[idx]
                    
                    if aKey != "New item" {
                        let aString = String(aValue[aValue.startIndex])
                        let character = Int(aString)!
                        attributedString += aKey
                        
                        switch character {
                        case SuperScriptType.k0Superscript:
                            attributedString += "⁰"
                        case SuperScriptType.k1Superscript:
                            attributedString += "¹"
                        case SuperScriptType.k2Superscript:
                            attributedString += "²"
                        case SuperScriptType.k3Superscript:
                            attributedString += "³"
                        case SuperScriptType.k4Superscript:
                            attributedString += "⁴"
                        case SuperScriptType.k5Superscript:
                            attributedString += "⁵"
                        case SuperScriptType.k6Superscript:
                            attributedString += "⁶"
                        case SuperScriptType.k7Superscript:
                            attributedString += "⁷"
                        case SuperScriptType.k8Superscript:
                            attributedString += "⁸"
                        case SuperScriptType.k9Superscript:
                            attributedString += "⁹"
                        default:
                            break
                        }
                    }
                }
            }
            
            return attributedString
        }
    }
    
}
