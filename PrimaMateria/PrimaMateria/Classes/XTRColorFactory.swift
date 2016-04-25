//
//  XTRColorFactory.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 4/15/16.
//  Copyright © 2016 xTrensa. All rights reserved.
//

@objc class XTRColorFactory : NSObject {
    
    class func colorFromDefaultsForKey(aColorKey: String) -> UIColor? {
        let colorData : NSData? = XTRPropertiesStore.retreiveColorDataForColorKey(aColorKey)
        var aColor : UIColor?
        
        if(colorData != nil) {
            aColor = NSKeyedUnarchiver.unarchiveObjectWithData(colorData!) as? UIColor
        }
        return aColor
    }
    
    class func colorForString(aString: String) -> UIColor {
        if (aString == SERIES_ACTINIDE) {
            return XTRColorFactory.actinideColor()
        } else if (aString == SERIES_ALKALI_EARTH_METAL) {
            return XTRColorFactory.alkaliEarthMetalColor()
        } else if (aString == SERIES_ALKALI_METAL) {
            return XTRColorFactory.alkaliMetalColor()
        } else if (aString == SERIES_HALOGEN) {
            return XTRColorFactory.halogenColor()
        } else if (aString == SERIES_LANTHANIDE) {
            return XTRColorFactory.lanthanideColor()
        } else if (aString == SERIES_METAL) {
            return XTRColorFactory.metalColor()
        } else if (aString == SERIES_NON_METAL) {
            return XTRColorFactory.nonMetalColor()
        } else if (aString == SERIES_NOBLE_GAS) {
            return XTRColorFactory.nobleGasColor()
        } else if (aString == SERIES_TRANSACTINIDES) {
            return XTRColorFactory.transactinideColor()
        } else if (aString == SERIES_TRANSITION_METAL) {
            return XTRColorFactory.transitionMetalColor()
        } else if (aString == STANDARD_CONDITION_GAS) {
            return XTRColorFactory.gasConditionColor()
        } else if (aString == STANDARD_CONDITION_LIQUID) {
            return XTRColorFactory.liquidConditionColor()
        } else if (aString == STANDARD_CONDITION_SOLID) {
            return XTRColorFactory.solidConditionColor()
        } else if (aString == STANDARD_CONDITION_SYNTHETIC) {
            return XTRColorFactory.syntheticConditionColor()
        } else {
            return UIColor.whiteColor()
        }
    }
    
    // MARK: - Series Colors
    
    class func actinideColor() -> UIColor {
        let actinideColor : UIColor?
        let aColor : UIColor? = XTRColorFactory.colorFromDefaultsForKey(SERIES_ACTINIDE)
        if (aColor != nil) {
            actinideColor = aColor
        } else {
            actinideColor = XTRColorFactory.defaultActinideColor()
        }
        return actinideColor!
    }
    
    class func alkaliEarthMetalColor() -> UIColor {
        let alkaliEarthMetalColor : UIColor?
        let aColor : UIColor? = XTRColorFactory.colorFromDefaultsForKey(SERIES_ALKALI_EARTH_METAL)
        if (aColor != nil) {
            alkaliEarthMetalColor = aColor
        } else {
            alkaliEarthMetalColor = XTRColorFactory.defaultAlkaliEarthMetalColor()
        }
        return alkaliEarthMetalColor!
    }
    
    class func alkaliMetalColor() -> UIColor {
        let alkaliMetalColor : UIColor?
        let aColor : UIColor? = XTRColorFactory.colorFromDefaultsForKey(SERIES_ALKALI_METAL)
        if (aColor != nil) {
            alkaliMetalColor = aColor
        } else {
            alkaliMetalColor = XTRColorFactory.defaultAlkaliMetalColor()
        }
        return alkaliMetalColor!
    }
    
    class func halogenColor() -> UIColor {
        let halogenColor : UIColor?
        let aColor : UIColor? = XTRColorFactory.colorFromDefaultsForKey(SERIES_HALOGEN)
        if (aColor != nil) {
            halogenColor = aColor
        } else {
            halogenColor = XTRColorFactory.defaultHalogenColor()
        }
        return halogenColor!
    }
    
    class func lanthanideColor() -> UIColor {
        let lanthanideColor : UIColor?
        let aColor : UIColor? = XTRColorFactory.colorFromDefaultsForKey(SERIES_LANTHANIDE)
        if (aColor != nil) {
            lanthanideColor = aColor
        } else {
            lanthanideColor = XTRColorFactory.defaultLanthanideColor()
        }
        return lanthanideColor!
    }
    
    class func metalColor() -> UIColor {
        let metalColor : UIColor?
        let aColor : UIColor? = XTRColorFactory.colorFromDefaultsForKey(SERIES_METAL)
        if (aColor != nil) {
            metalColor = aColor
        } else {
            metalColor = XTRColorFactory.defaultMetalColor()
        }
        return metalColor!
    }
    
    class func nonMetalColor() -> UIColor {
        let nonMetalColor : UIColor?
        let aColor : UIColor? = XTRColorFactory.colorFromDefaultsForKey(SERIES_NON_METAL)
        if (aColor != nil) {
            nonMetalColor = aColor
        } else {
            nonMetalColor = XTRColorFactory.defaultNonMetalColor()
        }
        return nonMetalColor!
    }
    
    class func nobleGasColor() -> UIColor {
        let nobleGasColor : UIColor?
        let aColor : UIColor? = XTRColorFactory.colorFromDefaultsForKey(SERIES_NOBLE_GAS)
        if (aColor != nil) {
            nobleGasColor = aColor
        } else {
            nobleGasColor = XTRColorFactory.defaultNobleGasColor()
        }
        return nobleGasColor!
    }
    
    class func transactinideColor() -> UIColor {
        let transactinideColor : UIColor?
        let aColor : UIColor? = XTRColorFactory.colorFromDefaultsForKey(SERIES_TRANSACTINIDES)
        if (aColor != nil) {
            transactinideColor = aColor
        } else {
            transactinideColor = XTRColorFactory.defaultTransactinideColor()
        }
        return transactinideColor!
    }
    
    class func transitionMetalColor() -> UIColor {
        let transitionMetalColor : UIColor?
        let aColor : UIColor? = XTRColorFactory.colorFromDefaultsForKey(SERIES_TRANSITION_METAL)
        if (aColor != nil) {
            transitionMetalColor = aColor
        } else {
            transitionMetalColor = XTRColorFactory.defaultTransitionMetalColor()
        }
        return transitionMetalColor!
    }
    
    class func defaultActinideColor() -> UIColor {
        return UIColor(red: CGFloat(177 / RGB_CONSTANT), green: CGFloat(247 / RGB_CONSTANT), blue: CGFloat(255 / RGB_CONSTANT), alpha: 1)
    }
    
    class func defaultAlkaliEarthMetalColor() -> UIColor {
        return UIColor(red: CGFloat(127 / RGB_CONSTANT), green: CGFloat(133 / RGB_CONSTANT), blue: CGFloat(255 / RGB_CONSTANT), alpha: 1)
    }
    
    class func defaultAlkaliMetalColor() -> UIColor {
        return UIColor(red: CGFloat(255 / RGB_CONSTANT), green: CGFloat(124 / RGB_CONSTANT), blue: CGFloat(236 / RGB_CONSTANT), alpha: 1)
    }
    
    class func defaultHalogenColor() -> UIColor {
        return UIColor(red: CGFloat(255 / RGB_CONSTANT), green: CGFloat(212 / RGB_CONSTANT), blue: CGFloat(122 / RGB_CONSTANT), alpha: 1)
    }
    
    class func defaultLanthanideColor() -> UIColor {
        return UIColor(red: CGFloat(68 / RGB_CONSTANT), green: CGFloat(215 / RGB_CONSTANT), blue: CGFloat(255 / RGB_CONSTANT), alpha: 1)
    }
    
    class func defaultMetalColor() -> UIColor {
        return UIColor(red: CGFloat(149 / RGB_CONSTANT), green: CGFloat(255 / RGB_CONSTANT), blue: CGFloat(164 / RGB_CONSTANT), alpha: 1)
    }
    
    class func defaultNobleGasColor() -> UIColor {
        return UIColor(red: CGFloat(255 / RGB_CONSTANT), green: CGFloat(145 / RGB_CONSTANT), blue: CGFloat(125 / RGB_CONSTANT), alpha: 1)
    }
    
    class func defaultNonMetalColor() -> UIColor {
        return UIColor(red: CGFloat(255 / RGB_CONSTANT), green: CGFloat(255 / RGB_CONSTANT), blue: CGFloat(119 / RGB_CONSTANT), alpha: 1)
    }
    
    class func defaultTransactinideColor() -> UIColor {
        return UIColor(red: CGFloat(122 / RGB_CONSTANT), green: CGFloat(255 / RGB_CONSTANT), blue: CGFloat(202 / RGB_CONSTANT), alpha: 1)
    }
    
    class func defaultTransitionMetalColor() -> UIColor {
        return UIColor(red: CGFloat(119 / RGB_CONSTANT), green: CGFloat(255 / RGB_CONSTANT), blue: CGFloat(92 / RGB_CONSTANT), alpha: 1)
    }
    
    // MARK: - Standard Condition Colors
    
    class func gasConditionColor() -> UIColor {
        return XTRColorFactory.defaultGasConditionColor()
    }
    
    class func solidConditionColor() -> UIColor {
        return XTRColorFactory.defaultSolidConditionColor()
    }
    
    class func liquidConditionColor() -> UIColor {
        return XTRColorFactory.defaultLiquidConditionColor()
    }
    
    class func syntheticConditionColor() -> UIColor {
        return XTRColorFactory.defaultSyntheticConditionColor()
    }
    
    class func defaultGasConditionColor() -> UIColor {
    return UIColor.redColor()
    }
    
    class func defaultSolidConditionColor() -> UIColor {
        return UIColor.blackColor()
    }
    
    class func defaultLiquidConditionColor() -> UIColor {
        return UIColor.blueColor()
    }
    
    class func defaultSyntheticConditionColor() -> UIColor {
        return UIColor.yellowColor()
    }
    
    class func navigationBarColor() -> UIColor {
        return UIColor(red: CGFloat(36 / RGB_CONSTANT), green: CGFloat(36 / RGB_CONSTANT), blue: CGFloat(36 / RGB_CONSTANT), alpha: 1)
    }
    
    class func toolBarColor() -> UIColor {
        return UIColor(red: CGFloat(36 / RGB_CONSTANT), green: CGFloat(36 / RGB_CONSTANT), blue: CGFloat(36 / RGB_CONSTANT), alpha: 1)
    }
    
    class func alternateRowColor() -> UIColor {
        return UIColor(red: CGFloat(36 / RGB_CONSTANT), green: CGFloat(245.0 / RGB_CONSTANT), blue: CGFloat(245.0 / RGB_CONSTANT), alpha: 1)
    }
    
    class func rowColor() -> UIColor {
        return UIColor(red: CGFloat(245.0 / RGB_CONSTANT), green: CGFloat(255.0 / RGB_CONSTANT), blue: CGFloat(255.0 / RGB_CONSTANT), alpha: 1)
    }
    
    class func alternateRowTableCellTextLabelColor() -> UIColor {
        return UIColor.blackColor()
    }
    
    class func rowTableCellTextLabelColor() -> UIColor {
        return UIColor.whiteColor()
    }
    
    class func labelColor() -> UIColor {
        return UIColor(red: CGFloat(44.0 / RGB_CONSTANT), green: CGFloat(119.0 / RGB_CONSTANT), blue: CGFloat(164.0 / RGB_CONSTANT), alpha: 1)
    }
    
    class func tableBackgroundColor() -> UIColor {
        return UIColor.clearColor()
    }
    
    class func viewBackgroundColor() -> UIColor {
        return UIColor.whiteColor()
    }
    
    class func tableViewCellDetailLabelColor() -> UIColor {
        return UIColor(red: CGFloat(50.0 / RGB_CONSTANT), green: CGFloat(79.0 / RGB_CONSTANT), blue: CGFloat(133.0 / RGB_CONSTANT), alpha: 1)
    }
    
    class func tableViewCellBorderColor() -> UIColor {
        return UIColor(red: CGFloat(191.0 / RGB_CONSTANT), green: CGFloat(191.0 / RGB_CONSTANT), blue: CGFloat(191.0 / RGB_CONSTANT), alpha: 1)
    }
    
    class func popupArrowColor() -> UIColor {
        return UIColor.init(red: 0.24, green: 0.24, blue: 0.24, alpha: 1.0)
    }
}