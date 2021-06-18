//
//  XTRColorFactory.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 4/15/16.
//  Copyright ©2021 xTrensa. All rights reserved.
//

import UIKit

let RGB_CONSTANT = 255.0
let HSB_CONSTANT = 359.0

class XTRColorFactory: NSObject {

    class func colorFromDefaultsForKey(_ aColorKey: String) -> UIColor? {
        let colorData: Data? = XTRPropertiesStore.getColorDataForKey(aColorKey)
        var aColor: UIColor?

        if colorData != nil {
            do {
                aColor = try NSKeyedUnarchiver.unarchivedObject(ofClasses: [UIColor.self], from: colorData!) as? UIColor
            } catch {
            }
        }

        return aColor
    }

    class func colorForString(_ aString: String) -> UIColor {
        switch aString {
        case ElementSeries.actinide:
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
        case ElementSeries.transactinide :
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
            var aColor = XTRColorFactory.colorFromDefaultsForKey(ElementSeries.actinide)
            if aColor == nil {
                aColor = XTRColorFactory.defaultActinideColor
            }

            return aColor!
    }

    class var alkaliEarthMetalColor: UIColor {
            var aColor = XTRColorFactory.colorFromDefaultsForKey(ElementSeries.alkaliEarthMetal)
            if aColor == nil {
                aColor = XTRColorFactory.defaultAlkaliEarthMetalColor
            }
            return aColor!
    }

    class var alkaliMetalColor: UIColor {
            var aColor = XTRColorFactory.colorFromDefaultsForKey(ElementSeries.alkaliMetal)
            if aColor == nil {
                aColor = XTRColorFactory.defaultAlkaliMetalColor
            }
            return aColor!
    }

    class var halogenColor: UIColor {
            var aColor = XTRColorFactory.colorFromDefaultsForKey(ElementSeries.halogen)
            if aColor == nil {
                aColor = XTRColorFactory.defaultHalogenColor
            }
            return aColor!
    }

    class var lanthanideColor: UIColor {
            var aColor = XTRColorFactory.colorFromDefaultsForKey(ElementSeries.lanthanide)
            if aColor == nil {
                aColor = XTRColorFactory.defaultLanthanideColor
            }
            return aColor!
    }

    class var metalColor: UIColor {
            var aColor = XTRColorFactory.colorFromDefaultsForKey(ElementSeries.metal)
            if aColor == nil {
                aColor = XTRColorFactory.defaultMetalColor
            }
            return aColor!
    }

    class var nonMetalColor: UIColor {
            var aColor = XTRColorFactory.colorFromDefaultsForKey(ElementSeries.nonMetal)
            if aColor == nil {
                aColor = XTRColorFactory.defaultNonMetalColor
            }
            return aColor!
    }

    class var nobleGasColor: UIColor {
            var aColor = XTRColorFactory.colorFromDefaultsForKey(ElementSeries.nobleGas)
            if aColor == nil {
                aColor = XTRColorFactory.defaultNobleGasColor
            }
            return aColor!
    }

    class var transactinideColor: UIColor {
            var aColor = XTRColorFactory.colorFromDefaultsForKey(ElementSeries.transactinide)
            if aColor == nil {
                aColor = XTRColorFactory.defaultTransactinideColor
            }
            return aColor!
    }

    class var transitionMetalColor: UIColor {
            var aColor = XTRColorFactory.colorFromDefaultsForKey(ElementSeries.transitionMetal)
            if aColor == nil {
                aColor = XTRColorFactory.defaultTransitionMetalColor
            }
            return aColor!
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

    class var border: UIColor {
        if XTRAppearanceManager.manager.isClassicAppearance() {
            return XTRColorFactoryClassic.border
        } else {
            return XTRColorFactoryStandard.border
        }
    }

    class var buttonBorderColor: UIColor {
        if XTRAppearanceManager.manager.isClassicAppearance() {
            return XTRColorFactoryClassic.buttonBorderColor
        } else {
            return XTRColorFactoryStandard.buttonBorderColor
        }
    }

    class var successGreen: UIColor {
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
            return UIColor.color(hexString: "fcfc95")
        } else {
            return UIColor.color(hexString: "add8e6")
        }
    }

    class var helpButtonBorderColor: UIColor {
        if XTRAppearanceManager.manager.isClassicAppearance() {
            return UIColor.black
        } else {
            return UIColor.gray
        }
    }

    class var backgroundColor: UIColor {
        if XTRAppearanceManager.manager.isClassicAppearance() {
            return UIColor.color(hexString: "404040")
        } else {
            return XTRColorFactoryStandard.seamlessMetalTextureColor
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

    class var transparentColor: UIColor {
        return UIColor.clear
    }

    class var pageControlLabelColor: UIColor {
        if XTRAppearanceManager.manager.isClassicAppearance() {
            return XTRColorFactoryClassic.cotton
        } else {
            return XTRColorFactoryStandard.ghost
        }
    }

    class var pageIndicatorTintColor: UIColor {
        if XTRAppearanceManager.manager.isClassicAppearance() {
            return XTRColorFactoryClassic.denim
        } else {
            return XTRColorFactoryStandard.darkText
        }
    }

    class var currentPageIndicatorTintColor: UIColor {
        if XTRAppearanceManager.manager.isClassicAppearance() {
            return XTRColorFactoryClassic.cotton
        } else {
            return XTRColorFactoryClassic.caution
        }
    }

    class var switchBackgroundColor: UIColor {
        if XTRAppearanceManager.manager.isClassicAppearance() {
            return XTRColorFactoryClassic.buttonBorderColor
        } else {
            return XTRColorFactoryStandard.buttonBorderColor
        }
    }

}
