//
//  XTRColorFactory.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 4/15/16.
//  Copyright © 2018 xTrensa. All rights reserved.
//

import UIKit

let RGB_CONSTANT = 255.0
let HSB_CONSTANT = 359.0

class XTRColorFactory : NSObject {
    
    class func colorFromDefaultsForKey(_ aColorKey: String) -> UIColor? {
        let colorData : Data? = XTRPropertiesStore.getColorDataForKey(aColorKey)
        var aColor : UIColor?
        
        if colorData != nil {
            aColor = NSKeyedUnarchiver.unarchiveObject(with: colorData!) as? UIColor
        }
        
        return aColor
    }
    
    class func colorForString(_ aString: String) -> UIColor {
        switch aString {
        case ElementSeries.actinide :
            return XTRColorFactory.actinideColor
        case ElementSeries.alkaliEarthMetal :
            return XTRColorFactory.alkaliEarthMetalColor
        case ElementSeries.alkaliMetal :
            return XTRColorFactory.alkaliMetalColor
        case ElementSeries.halogen :
            return XTRColorFactory.halogenColor
        case ElementSeries.lanthanide :
            return XTRColorFactory.lanthanideColor
        case ElementSeries.metal :
            return XTRColorFactory.metalColor
        case ElementSeries.nonMetal :
            return XTRColorFactory.nonMetalColor
        case ElementSeries.nobleGas :
            return XTRColorFactory.nobleGasColor
        case ElementSeries.transactinides :
            return XTRColorFactory.transactinideColor
        case ElementSeries.transitionMetal :
            return XTRColorFactory.transitionMetalColor
        case ElementStandardCondition.gas :
            return XTRColorFactory.gasConditionColor
        case ElementStandardCondition.liquid :
            return XTRColorFactory.liquidConditionColor
        case ElementStandardCondition.solid :
            return XTRColorFactory.solidConditionColor
        case ElementStandardCondition.synthetic :
            return XTRColorFactory.syntheticConditionColor
        default:
            return UIColor.white
        }
    }
    
    // MARK: - Series Colors
    
    class var actinideColor: UIColor {
        get {
            guard let aColor = XTRColorFactory.colorFromDefaultsForKey(ElementSeries.actinide) else { return XTRColorFactory.defaultActinideColor }
            return aColor
        }
    }
    
    class var alkaliEarthMetalColor: UIColor {
        get {
            guard let aColor = XTRColorFactory.colorFromDefaultsForKey(ElementSeries.alkaliEarthMetal) else { return XTRColorFactory.defaultAlkaliEarthMetalColor }
            return aColor
        }
    }
    
    class var alkaliMetalColor: UIColor {
        get {
            guard let aColor = XTRColorFactory.colorFromDefaultsForKey(ElementSeries.alkaliMetal) else { return XTRColorFactory.defaultAlkaliMetalColor }
            return aColor
        }
    }
    
    class var halogenColor: UIColor {
        get {
            guard let aColor = XTRColorFactory.colorFromDefaultsForKey(ElementSeries.halogen) else { return XTRColorFactory.defaultHalogenColor }
            return aColor
        }
    }
    
    class var lanthanideColor: UIColor {
        get {
            guard let aColor = XTRColorFactory.colorFromDefaultsForKey(ElementSeries.lanthanide) else { return XTRColorFactory.defaultLanthanideColor }
            return aColor
        }
    }
    
    class var metalColor: UIColor {
        get {
            guard let aColor = XTRColorFactory.colorFromDefaultsForKey(ElementSeries.metal) else { return XTRColorFactory.defaultMetalColor }
            return aColor
        }
    }
    
    class var nonMetalColor: UIColor {
        get {
            guard let aColor = XTRColorFactory.colorFromDefaultsForKey(ElementSeries.nonMetal) else { return XTRColorFactory.defaultNonMetalColor }
            return aColor
        }
    }
    
    class var nobleGasColor: UIColor {
        get {
            guard let aColor = XTRColorFactory.colorFromDefaultsForKey(ElementSeries.nobleGas) else { return XTRColorFactory.defaultNobleGasColor }
            return aColor
        }
    }
    
    class var transactinideColor: UIColor {
        get {
            guard let aColor = XTRColorFactory.colorFromDefaultsForKey(ElementSeries.transactinides) else { return XTRColorFactory.defaultTransactinideColor }
            return aColor
        }
    }
    
    class var transitionMetalColor: UIColor {
        get {
            guard let aColor = XTRColorFactory.colorFromDefaultsForKey(ElementSeries.transitionMetal) else { return XTRColorFactory.defaultTransitionMetalColor }
            return aColor
        }
    }
    
    class var defaultActinideColor: UIColor {
        return UIColor.color(hexString: "B1F7FF")
    }
    
    class var defaultAlkaliEarthMetalColor: UIColor {
        return UIColor.color(hexString: "7F85FF")
    }
    
    class var defaultAlkaliMetalColor: UIColor {
        return UIColor.color(hexString: "FF7CEC")
    }
    
    class var defaultHalogenColor: UIColor {
        return UIColor.color(hexString: "FFD47A")
    }
    
    class var defaultLanthanideColor: UIColor {
        return UIColor.color(hexString: "44D7FF")
    }
    
    class var defaultMetalColor: UIColor {
        return UIColor.color(hexString: "95FFA4")
    }
    
    class var defaultNobleGasColor: UIColor {
        return UIColor.color(hexString: "FF917D")
    }
    
    class var defaultNonMetalColor: UIColor {
        return UIColor.color(hexString: "FFFF77")
    }
    
    class var defaultTransactinideColor: UIColor {
        return UIColor.color(hexString: "7AFFCA")
    }
    
    class var defaultTransitionMetalColor: UIColor {
        return UIColor.color(hexString: "77FF5C")
    }
    
    // MARK: - Standard Condition Colors
    
    class var gasConditionColor: UIColor {
        return XTRColorFactory.defaultGasConditionColor
    }
    
    class var solidConditionColor: UIColor {
        return XTRColorFactory.defaultSolidConditionColor
    }
    
    class var liquidConditionColor: UIColor {
        return XTRColorFactory.defaultLiquidConditionColor
    }
    
    class var syntheticConditionColor: UIColor {
        return XTRColorFactory.defaultSyntheticConditionColor
    }
    
    class var defaultGasConditionColor: UIColor {
        return UIColor.red
    }
    
    class var defaultSolidConditionColor: UIColor {
        return UIColor.black
    }
    
    class var defaultLiquidConditionColor: UIColor {
        return UIColor.blue
    }
    
    class var defaultSyntheticConditionColor: UIColor {
        return UIColor.yellow
    }
    
    // MARK: - Miscellaneous Colors
    
    class var border : UIColor {
        if XTRAppearanceManager.manager.isClassicAppearance() {
            return XTRColorFactoryClassic.border
        } else {
            return XTRColorFactoryStandard.border
        }
    }
    
    class var successGreen : UIColor {
        if XTRAppearanceManager.manager.isClassicAppearance() {
            return XTRColorFactoryClassic.success
        } else {
            return XTRColorFactoryStandard.wavesOfGrass
        }
    }
    
    class var segmentedControlForgroundColor: UIColor {
        if XTRAppearanceManager.manager.isClassicAppearance() {
            return XTRColorFactoryClassic.jetBlue
        } else {
            return XTRColorFactoryStandard.navyBlue
        }
    }
    
    class var tabBarSelectedForgroundColor: UIColor {
        if XTRAppearanceManager.manager.isClassicAppearance() {
            return XTRColorFactoryClassic.armadillo
        } else {
            return XTRColorFactoryStandard.navyBlue
        }
    }
    
    class var switchOnTintColor: UIColor {
        if XTRAppearanceManager.manager.isClassicAppearance() {
            return XTRColorFactoryClassic.doveGrayColor
        } else {
            return XTRColorFactoryStandard.successGreen
        }
    }
    
    class var helpBackgroundColor: UIColor {
        if XTRAppearanceManager.manager.isClassicAppearance() {
            return UIColor.color(hexString: "dddd00")
        } else {
            return UIColor.color(hexString: "dcdc00")
        }
    }
    
    class var backgroundColor: UIColor {
        if XTRAppearanceManager.manager.isClassicAppearance() {
            return UIColor.color(hexString: "404040")
        } else {
            return XTRColorFactoryStandard.regalBlue
        }
    }
    
    class var navigationBarColor: UIColor {
        return UIColor.color(hexString: "242424")
    }
    
    class var toolBarColor: UIColor {
        return UIColor.color(hexString: "242424")
    }
    
    class var alternateRowColor: UIColor {
        return UIColor.color(hexString: "24F5F5")
    }
    
    class var rowColor: UIColor {
        return UIColor.color(hexString: "EDF3FF")
    }
    
    class var alternateRowTableCellTextLabelColor: UIColor {
        return UIColor.black
    }
    
    class var rowTableCellTextLabelColor: UIColor {
        return UIColor.white
    }
    
    class var labelColor: UIColor {
        return UIColor.color(hexString: "2C77A4")
    }
    
    class var tableBackgroundColor: UIColor {
        return UIColor.clear
    }
    
    class var viewBackgroundColor: UIColor {
        return UIColor.white
    }
    
    class var tableViewCellDetailLabelColor: UIColor {
        return UIColor.color(hexString: "324F85")
    }
    
    class var tableViewCellBorderColor: UIColor {
        return UIColor.color(hexString: "BFBFBF")
    }
    
    class var popupArrowColor: UIColor {
        return UIColor.color(hexString: "A3A3A3")
    }
    
}
