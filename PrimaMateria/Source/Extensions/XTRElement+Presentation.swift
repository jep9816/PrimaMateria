//
//  XTRElement+Presentation.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 4/22/16.
//  Copyright ©2021 xTrensa. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit
import RxSwift
import RxCocoa

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
        guard let atomicMassKnownAccurately = value(forKeyPath: ELEMENT_ATOMIC_MASS_KNOWN_ACCURATELY) as? Bool else { return STRING_EMPTY }

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
        guard let footnote = value(forKeyPath: ELEMENT_ATOMIC_MASS_FOOTNOTE) as? String else { return STRING_EMPTY }

        return footnote
    }

    var electronConfigurationModel: XTYRElectronConfigurationModel? {
        let dict = self.electronConfiguration
        return XTYRElectronConfigurationModel(dictionary: dict)
    }

    var nuclidesAndIsotopesModels: BehaviorRelay<[XTRIsotopeModel]>? {
        let models: BehaviorRelay<[XTRIsotopeModel]> = BehaviorRelay(value: [])
        var modelsCopy: [XTRIsotopeModel] = []
        guard let list = self.nuclidesAndIsotopes else { return models }

        list.forEach {
            modelsCopy.append(XTRIsotopeModel(dictionary: $0))
        }

        models.accept(modelsCopy)

        return models
    }

    var lineSpectraModels: BehaviorRelay<[XTRSpectraModel]>? {
        let models: BehaviorRelay<[XTRSpectraModel]> = BehaviorRelay(value: [])
        var modelsCopy: [XTRSpectraModel] = []
        guard let list = self.lineSpectra else { return models }

        list.forEach {
            modelsCopy.append(XTRSpectraModel(dictionary: $0))
        }

        models.accept(modelsCopy)

        return models
    }

    var kShellElectrons: String {
        let s1String = electronConfigurationModel?.shell1s
        let tot = (s1String == STRING_EMPTY) ? NSNumber(value: 0): NSNumber(value: Int(s1String!)!)

        return (tot == 0) ? STRING_EMPTY: String(format: "%@", tot)
    }

    var lShellElectrons: String {
        let s2String = electronConfigurationModel?.shell2s
        let p2String = electronConfigurationModel?.shell2p
        let s2Value = (s2String == STRING_EMPTY) ? NSNumber(value: 0): NSNumber(value: Int(s2String!)!)
        let p2Value = (p2String == STRING_EMPTY) ? NSNumber(value: 0): NSNumber(value: Int(p2String!)!)
        let tot = NSNumber(value: Int(s2Value.intValue + p2Value.intValue))

        return (tot == 0) ? STRING_EMPTY: String(format: "%@", tot)
    }

    var mShellElectrons: String {
        let s3String = electronConfigurationModel?.shell3s
        let p3String = electronConfigurationModel?.shell3p
        let d3String = electronConfigurationModel?.shell3d
        let s3Value = (s3String == STRING_EMPTY) ? NSNumber(value: 0): NSNumber(value: Int(s3String!)!)
        let p3Value = (p3String == STRING_EMPTY) ? NSNumber(value: 0): NSNumber(value: Int(p3String!)!)
        let d3Value = (d3String == STRING_EMPTY) ? NSNumber(value: 0): NSNumber(value: Int(d3String!)!)
        let tot = NSNumber(value: Int(s3Value.intValue + p3Value.intValue + d3Value.intValue))

        return (tot == 0) ? STRING_EMPTY: String(format: "%@", tot)
    }

    var nShellElectrons: String {
        let s4String = electronConfigurationModel?.shell4s
        let p4String = electronConfigurationModel?.shell4p
        let d4String = electronConfigurationModel?.shell4d
        let f4String = electronConfigurationModel?.shell4f
        let s4Value = (s4String == STRING_EMPTY) ? NSNumber(value: 0): NSNumber(value: Int(s4String!)!)
        let p4Value = (p4String == STRING_EMPTY) ? NSNumber(value: 0): NSNumber(value: Int(p4String!)!)
        let d4Value = (d4String == STRING_EMPTY) ? NSNumber(value: 0): NSNumber(value: Int(d4String!)!)
        let f4Value = (f4String == STRING_EMPTY) ? NSNumber(value: 0): NSNumber(value: Int(f4String!)!)
        let tot = NSNumber(value: Int(s4Value.intValue + p4Value.intValue + d4Value.intValue + f4Value.intValue))

        return (tot == 0) ? STRING_EMPTY: String(format: "%@", tot)
    }

    var oShellElectrons: String {
        let s5String = electronConfigurationModel?.shell5s
        let p5String = electronConfigurationModel?.shell5p
        let d5String = electronConfigurationModel?.shell5d
        let f5String = electronConfigurationModel?.shell5f
        let s5Value = (s5String == STRING_EMPTY) ? NSNumber(value: 0): NSNumber(value: Int(s5String!)!)
        let p5Value = (p5String == STRING_EMPTY) ? NSNumber(value: 0): NSNumber(value: Int(p5String!)!)
        let d5Value = (d5String == STRING_EMPTY) ? NSNumber(value: 0): NSNumber(value: Int(d5String!)!)
        let f5Value = (f5String == STRING_EMPTY) ? NSNumber(value: 0): NSNumber(value: Int(f5String!)!)
        let tot = NSNumber(value: Int(s5Value.intValue + p5Value.intValue + d5Value.intValue + f5Value.intValue))

        return (tot == 0) ? STRING_EMPTY: String(format: "%@", tot)
    }

    var pShellElectrons: String {
        let s6String = electronConfigurationModel?.shell6s
        let p6String = electronConfigurationModel?.shell6p
        let d6String = electronConfigurationModel?.shell6d
        let s6Value = (s6String == STRING_EMPTY) ? NSNumber(value: 0): NSNumber(value: Int(s6String!)!)
        let p6Value = (p6String == STRING_EMPTY) ? NSNumber(value: 0): NSNumber(value: Int(p6String!)!)
        let d6Value = (d6String == STRING_EMPTY) ? NSNumber(value: 0): NSNumber(value: Int(d6String!)!)
        let tot = NSNumber(value: Int(s6Value.intValue + p6Value.intValue + d6Value.intValue))

        return (tot == 0) ? STRING_EMPTY: String(format: "%@", tot)
    }

    var qShellElectrons: String {
        let s7String = electronConfigurationModel?.shell7s
        let p7String = electronConfigurationModel?.shell7p
        let s7Value = (s7String! == STRING_EMPTY) ? NSNumber(value: 0): NSNumber(value: Int(s7String!)!)
        let p7Value = (p7String! == STRING_EMPTY) ? NSNumber(value: 0): NSNumber(value: Int(p7String!)!)
        let tot = NSNumber(value: Int(s7Value.intValue + p7Value.intValue))

        return (tot == 0) ? STRING_EMPTY: String(format: "%@", tot)
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
        //let scene = SCNScene()
        let crystalStructure = self.value(forKeyPath: ELEMENT_CRYSTAL_STRUCTURE) as! String
        let scene = SCNScene(named: crystalStructure + ".scn")!
        //let boxGeometry = SCNBox(width: 100.0, height: 100.0, length: 100.0, chamferRadius: 1.0)
        //let boxNode = SCNNode(geometry: boxGeometry)

        //scene.rootNode.addChildNode(boxNode)

//        let ambientLightNode = SCNNode()
//        ambientLightNode.light = SCNLight()
//        ambientLightNode.light!.type = .ambient
//        ambientLightNode.light!.color = UIColor.blue.withAlphaComponent(0.5)
//        scene.rootNode.addChildNode(ambientLightNode)
//
//        let omniLightNode = SCNNode()
//        omniLightNode.light = SCNLight()
//        omniLightNode.light!.type = .omni
//        omniLightNode.light!.color = UIColor(white: 0.75, alpha: 1.0)
//        omniLightNode.position = SCNVector3Make(0, 100, 100)
//        scene.rootNode.addChildNode(omniLightNode)
//
//        let cameraNode = SCNNode()
//        cameraNode.camera = SCNCamera()
//        cameraNode.position = SCNVector3Make(0, 0, 200)
//        scene.rootNode.addChildNode(cameraNode)

        return scene
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

    var vaporPressureModel: XTRVaporPressurenModel? {
        return XTRVaporPressurenModel(dictionary: self.vaporPressure!)
    }

    func nameString() -> String {
        return " \(NSLocalizedString("elementInspectorFor", comment: "")) \( name!)"
    }

    var groupString: String {
        return "\(group!) "
    }

    var casRegNoString: String {
        return " \(value(forKeyPath: ELEMENT_CAS_REGISTRY_NUMBER) as! String)"
    }

    private func _attributedStringForArray(_ anArray: [Any]?) -> String? {
        var attributedString = STRING_UNKNOWN

        if anArray != nil {
            let outerCount = anArray!.count

            for index in 0..<outerCount {
                let aDictionary = anArray![index] as! [String: String]
                let keysCollection = aDictionary.keys
                let valuesCollection = aDictionary.values
                let allKeys = Array(keysCollection)
                let allValues = Array(valuesCollection)
                let counter = allKeys.count

                for idx in 0..<counter {
                    let aValue = allValues[idx]

                    if allKeys[idx] != "New item" {
                        let aString = String(aValue[aValue.startIndex])
                        let character = Int(aString)!
                        attributedString += allKeys[idx]

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
        }

        return attributedString
    }

}
