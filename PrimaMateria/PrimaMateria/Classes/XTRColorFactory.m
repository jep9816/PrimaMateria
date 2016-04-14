//
// XTRColorFactory.m
// PrimaMateria
//
//  Created by Jerry Porter on 3/22/2010.
//  Copyright 2016 xTrensa. All rights reserved.
//

@implementation XTRColorFactory

#pragma mark General Methods

+ (UIColor *)colorFromDefaultsForKey: (NSString *)aColorKey {
    NSData *colorData = [XTRPropertiesStore retreiveColorDataForColorKey: aColorKey];
    UIColor *aColor = nil;
    
    if(colorData) {
        aColor = [NSKeyedUnarchiver unarchiveObjectWithData:colorData];
    }
    return aColor;
}

+ (UIColor *) colorForString: (NSString *) aString {
    if ([aString isEqualToString: SERIES_ACTINIDE])
        return [XTRColorFactory actinideColor];
    else if ([aString isEqualToString: SERIES_ALKALI_EARTH_METAL])
        return [XTRColorFactory alkaliEarthMetalColor];
    else if ([aString isEqualToString: SERIES_ALKALI_METAL])
        return [XTRColorFactory alkaliMetalColor];
    else if ([aString isEqualToString: SERIES_HALOGEN])
        return [XTRColorFactory halogenColor];
    else if ([aString isEqualToString: SERIES_LANTHANIDE])
        return [XTRColorFactory lanthanideColor];
    else if ([aString isEqualToString: SERIES_METAL])
        return [XTRColorFactory metalColor];
    else if ([aString isEqualToString: SERIES_NON_METAL])
        return [XTRColorFactory nonMetalColor];
    else if ([aString isEqualToString: SERIES_NOBLE_GAS])
        return [XTRColorFactory nobleGasColor];
    else if ([aString isEqualToString: SERIES_TRANSACTINIDES])
        return [XTRColorFactory transactinideColor];
    else if ([aString isEqualToString: SERIES_TRANSITION_METAL])
        return [XTRColorFactory transitionMetalColor];
    else if ([aString isEqualToString: STANDARD_CONDITION_GAS])
        return [XTRColorFactory gasConditionColor];
    else if ([aString isEqualToString: STANDARD_CONDITION_LIQUID])
        return [XTRColorFactory liquidConditionColor];
    else if ([aString isEqualToString: STANDARD_CONDITION_SOLID])
        return [XTRColorFactory solidConditionColor];
    else if ([aString isEqualToString: STANDARD_CONDITION_SYNTHETIC])
        return [XTRColorFactory syntheticConditionColor];
    else
        return UIColor.whiteColor;
}

#pragma mark - Series Colors

+ (UIColor *) actinideColor {
    UIColor *actinideColor = nil;
    //if (!actinideColor) {
        UIColor *aColor = [XTRColorFactory colorFromDefaultsForKey: SERIES_ACTINIDE];
        if (aColor != nil)
            actinideColor = aColor;
        else
            actinideColor = [XTRColorFactory defaultActinideColor];
    //}
    return actinideColor;
}

+ (UIColor *) alkaliEarthMetalColor; {
    UIColor *alkaliEarthMetalColor = nil;
    //if (!alkaliEarthMetalColor) {
        UIColor *aColor = [XTRColorFactory colorFromDefaultsForKey: SERIES_ALKALI_EARTH_METAL];
        if (aColor != nil)
            alkaliEarthMetalColor = aColor;
        else
            alkaliEarthMetalColor = [XTRColorFactory defaultAlkaliEarthMetalColor];
    //}
    return alkaliEarthMetalColor;
}

+ (UIColor *) alkaliMetalColor {
    UIColor *alkaliMetalColor = nil;
    //if (!alkaliMetalColor) {
        UIColor *aColor = [XTRColorFactory colorFromDefaultsForKey: SERIES_ALKALI_METAL];
        if (aColor != nil)
            alkaliMetalColor = aColor;
        else
            alkaliMetalColor = [XTRColorFactory defaultAlkaliMetalColor];
    //}
    return alkaliMetalColor;
}

+ (UIColor *) halogenColor {
    UIColor *halogenColor = nil;
    //if (!halogenColor) {
        UIColor *aColor = [XTRColorFactory colorFromDefaultsForKey: SERIES_HALOGEN];
        if (aColor != nil)
            halogenColor = aColor;
        else
            halogenColor = [XTRColorFactory defaultHalogenColor];
    //}
    return halogenColor;
}

+ (UIColor *) lanthanideColor {
    UIColor *lanthanideColor = nil;
    //if (!lanthanideColor) {
        UIColor *aColor = [XTRColorFactory colorFromDefaultsForKey: SERIES_LANTHANIDE];
        if (aColor != nil)
            lanthanideColor = aColor;
        else
            lanthanideColor = [XTRColorFactory defaultLanthanideColor];
    //}
    return lanthanideColor;
}

+ (UIColor *) metalColor {
    UIColor *metalColor = nil;
    //if (!metalColor) {
        UIColor *aColor = [XTRColorFactory colorFromDefaultsForKey: SERIES_METAL];
        if (aColor != nil)
            metalColor = aColor;
        else
            metalColor = [XTRColorFactory defaultMetalColor];
    //}
    return metalColor;
}

+ (UIColor *) nonMetalColor {
    UIColor *nonMetalColor = nil;
    //if (!nonMetalColor) {
        UIColor *aColor = [XTRColorFactory colorFromDefaultsForKey: SERIES_NON_METAL];
        if (aColor != nil)
            nonMetalColor = aColor;
        else
            nonMetalColor = [XTRColorFactory defaultNonMetalColor];
    //}
    return nonMetalColor;
}

+ (UIColor *) nobleGasColor {
    UIColor *nobleGasColor = nil;
    //if (!nobleGasColor) {
        UIColor *aColor = [XTRColorFactory colorFromDefaultsForKey: SERIES_NOBLE_GAS];
        if (aColor != nil)
            nobleGasColor = aColor;
        else
            nobleGasColor = [XTRColorFactory defaultNobleGasColor];
    //}
    return nobleGasColor;
}

+ (UIColor *) transactinideColor {
    UIColor *transactinideColor = nil;
    //if (!transactinideColor) {
        UIColor *aColor = [XTRColorFactory colorFromDefaultsForKey: SERIES_TRANSACTINIDES];
        if (aColor != nil)
            transactinideColor = aColor;
        else
            transactinideColor = [XTRColorFactory defaultTransactinideColor];
    //}
    return transactinideColor;
}

+ (UIColor *) transitionMetalColor {
    UIColor *transitionMetalColor = nil;
    //if (!transitionMetalColor) {
        UIColor *aColor = [XTRColorFactory colorFromDefaultsForKey: SERIES_TRANSITION_METAL];
        if (aColor != nil)
            transitionMetalColor = aColor;
        else
            transitionMetalColor = [XTRColorFactory defaultTransitionMetalColor];
    //}
    return transitionMetalColor;
}

+ (UIColor *) defaultActinideColor {
    return [UIColor colorWithRed: 177 / RGB_CONSTANT green: 247 / RGB_CONSTANT blue: 255 / RGB_CONSTANT  alpha: 1.0f];
}

+ (UIColor *) defaultAlkaliEarthMetalColor {
    return [UIColor colorWithRed: 127 / RGB_CONSTANT green: 133 / RGB_CONSTANT blue: 255 / RGB_CONSTANT  alpha: 1.0f];
}

+ (UIColor *) defaultAlkaliMetalColor {
    return [UIColor colorWithRed: 255 / RGB_CONSTANT green: 124 / RGB_CONSTANT blue: 236 / RGB_CONSTANT  alpha: 1.0f];
}

+ (UIColor *) defaultHalogenColor {
    return [UIColor colorWithRed: 255 / RGB_CONSTANT green: 212 / RGB_CONSTANT blue: 122 / RGB_CONSTANT  alpha: 1.0f];
}

+ (UIColor *) defaultLanthanideColor {
    return [UIColor colorWithRed: 68 / RGB_CONSTANT green: 215 / RGB_CONSTANT blue: 255 / RGB_CONSTANT  alpha: 1.0f];
}

+ (UIColor *) defaultMetalColor {
    return [UIColor colorWithRed: 149 / RGB_CONSTANT green: 255 / RGB_CONSTANT blue: 164 / RGB_CONSTANT  alpha: 1.0f];
}

+ (UIColor *) defaultNobleGasColor {
    return [UIColor colorWithRed: 255 / RGB_CONSTANT green: 145 / RGB_CONSTANT blue: 125 / RGB_CONSTANT  alpha: 1.0f];
}

+ (UIColor *) defaultNonMetalColor {
    return [UIColor colorWithRed: 255 / RGB_CONSTANT green: 255 / RGB_CONSTANT blue: 119 / RGB_CONSTANT  alpha: 1.0f];
}

+ (UIColor *) defaultTransactinideColor {
    return [UIColor colorWithRed: 122 / RGB_CONSTANT green: 255 / RGB_CONSTANT blue: 202 / RGB_CONSTANT  alpha: 1.0f];
}

+ (UIColor *) defaultTransitionMetalColor {
    return [UIColor colorWithRed: 119 / RGB_CONSTANT green: 255 / RGB_CONSTANT  blue: 92 / RGB_CONSTANT  alpha: 1.0f];
}

#pragma mark - Standard Condition Colors

+ (UIColor *) gasConditionColor {
    static UIColor *gasConditionColor = nil;
    if (!gasConditionColor) {
        //    UIColor *aColor = [XTRColorFactory colorFromDefaultsForKey: STANDARD_CONDITION_GAS];
        //    if(aColor != nil)
        //        gasConditionColor = [aColor retain];
        //    else
        gasConditionColor = [XTRColorFactory defaultGasConditionColor];
    }
    return gasConditionColor;
}

+ (UIColor *) solidConditionColor {
    static UIColor *solidConditionColor = nil;
    if (!solidConditionColor) {
        //    UIColor *aColor = [XTRColorFactory colorFromDefaultsForKey: STANDARD_CONDITION_SOLID];
        //    if(aColor != nil)
        //        solidConditionColor = [aColor retain];
        //    else
        solidConditionColor = [XTRColorFactory defaultSolidConditionColor];
    }
    return solidConditionColor;
}

+ (UIColor *) liquidConditionColor {
    static UIColor *liquidConditionColor = nil;
    if (!liquidConditionColor) {
        //    UIColor *aColor = [XTRColorFactory colorFromDefaultsForKey: STANDARD_CONDITION_LIQUID];
        //    if(aColor != nil)
        //        liquidConditionColor = [aColor retain];
        //    else
        liquidConditionColor = [XTRColorFactory defaultLiquidConditionColor];
    }
    return liquidConditionColor;
}

+ (UIColor *) syntheticConditionColor {
    static UIColor *syntheticConditionColor = nil;
    if (!syntheticConditionColor) {
        //    UIColor *aColor = [XTRColorFactory colorFromDefaultsForKey: STANDARD_CONDITION_SYNTHETIC];
        //    if(aColor != nil)
        //        syntheticConditionColor = [aColor retain];
        //    else
        syntheticConditionColor = [XTRColorFactory defaultSyntheticConditionColor];
    }
    return syntheticConditionColor;
}

+ (UIColor *) defaultGasConditionColor {
    return UIColor.redColor;
}

+ (UIColor *) defaultSolidConditionColor {
    return UIColor.blackColor;
}

+ (UIColor *) defaultLiquidConditionColor {
    return UIColor.blueColor;
}

+ (UIColor *) defaultSyntheticConditionColor {
    return UIColor.yellowColor;
}

+ (UIColor *) navigationBarColor {
    return [UIColor colorWithRed:36 / RGB_CONSTANT green:36 / RGB_CONSTANT blue:36 / RGB_CONSTANT alpha:1.0];
}

+ (UIColor *) toolBarColor {
    return [UIColor colorWithRed:36 / RGB_CONSTANT green:36 / RGB_CONSTANT blue:36 / RGB_CONSTANT alpha:1.0];
}

+ (UIColor *) alternateRowColor {
    return [UIColor colorWithRed:(CGFloat) (245.0 / RGB_CONSTANT) green:(CGFloat) (245.0 / RGB_CONSTANT) blue:(CGFloat) (255.0 / RGB_CONSTANT) alpha:1.0];
}

+ (UIColor *) rowColor {
    return [UIColor colorWithRed:(CGFloat) (245.0 / RGB_CONSTANT) green:(CGFloat) (255.0 / RGB_CONSTANT) blue:(CGFloat) (255.0 / RGB_CONSTANT) alpha:1.0];
}

+ (UIColor *) alternateRowTableCellTextLabelColor {
    return UIColor.blackColor;
}

+ (UIColor *) rowTableCellTextLabelColor {
    return [UIColor whiteColor];
}

+ (UIColor *) labelColor {
    return [UIColor colorWithRed:(CGFloat) (44.0 / RGB_CONSTANT) green:(CGFloat) (119.0 / RGB_CONSTANT) blue:(CGFloat) (164.0 / RGB_CONSTANT) alpha:1.0];
}

+ (UIColor *) tableBackgroundColor {
    return UIColor.clearColor;
}

+ (UIColor *) viewBackgroundColor {
    return [UIColor whiteColor];
}

+ (UIColor *) tableViewCellDetailLabelColor {
    return [UIColor colorWithRed:(CGFloat) (50.0 / RGB_CONSTANT) green:(CGFloat) (79.0 / RGB_CONSTANT) blue:(CGFloat) (133.0 / RGB_CONSTANT) alpha:1.0f];
}

+ (UIColor *) tableViewCellBorderColor {
    return [UIColor colorWithRed:(CGFloat) (191.0 / RGB_CONSTANT) green:(CGFloat) (191.0 / RGB_CONSTANT) blue:(CGFloat) (191.0 / RGB_CONSTANT) alpha:1.0f];
}

@end
