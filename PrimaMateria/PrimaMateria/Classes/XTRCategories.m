//
// XTRCategories.m
// PrimaMateria
//
//  Created by Jerry Porter on 3/22/2010.
//  Copyright 2014 xTrensa. All rights reserved.
//

#import "PrimaMateria.h"

enum chars {
    k0Superscript = 48,
    k1Superscript = 49,
    k2Superscript = 50,
    k3Superscript = 51,
    k4Superscript = 52,
    k5Superscript = 53,
    k6Superscript = 54,
    k7Superscript = 55,
    k8Superscript = 56,
    k9Superscript = 57
};

@implementation XTRElement (Presentation)

- (UIImage *) _unknownImage {
    NSString *aPath = [[NSBundle bundleForClass:[self class]] pathForResource: STRING_UNKNOWN ofType: @"png" inDirectory: SUPPORTING_FILES];
    UIImage *image = [[UIImage alloc] initWithContentsOfFile: aPath];
    return image;
}

- (NSString *) pathForGeneralInfoDoc {
    return [[NSBundle bundleForClass:[self class]] pathForResource:[self symbol] ofType: @"rtf" inDirectory: SUPPORTING_FILES];
}

- (NSString *) _attributedStringForArray: (NSArray *) anArray {
    if (anArray == nil)
        return [NSString stringWithFormat: @"%@", STRING_UNKNOWN];
    else {
        NSMutableString *attributedString = [[NSMutableString alloc] initWithString: STRING_EMPTY];
        for (NSDictionary *aDictionary in anArray) {
            NSArray *allKeys = [aDictionary allKeys];
            NSArray *allValues = [aDictionary allValues];
            NSInteger count = [allKeys count];
            for (NSInteger i = 0; i < count; i++) {
                NSString *aKey = allKeys[i];
                NSString *aValue = allValues[i];
                if (![aKey isEqualToString: @"New item"]) {
                    NSInteger character = [aValue characterAtIndex: 0];
                    [attributedString appendString: aKey];
                    switch (character) {
                        case k0Superscript:
                            [attributedString appendString: @"⁰"];
                            break;
                            
                        case k1Superscript:
                            [attributedString appendString: @"¹"];
                            break;
                            
                        case k2Superscript:
                            [attributedString appendString: @"²"];
                            break;
                            
                        case k3Superscript:
                            [attributedString appendString: @"³"];
                            break;
                            
                        case k4Superscript:
                            [attributedString appendString: @"⁴"];
                            break;
                            
                        case k5Superscript:
                            [attributedString appendString: @"⁵"];
                            break;
                            
                        case k6Superscript:
                            [attributedString appendString: @"⁶"];
                            break;
                            
                        case k7Superscript:
                            [attributedString appendString: @"⁷"];
                            break;
                            
                        case k8Superscript:
                            [attributedString appendString: @"⁸"];
                            break;
                            
                        case k9Superscript:
                            [attributedString appendString: @"⁹"];
                            break;
                            
                        default:
                            break;
                    }
                }
            }
        }
        return attributedString;
    }
}

- (NSString *) atomicMassAggregate {
    Boolean atomicMassKnownAccurately = [[self valueForKey: ELEMENT_ATOMIC_MASS_KNOWN_ACCURATELY] boolValue];
    if (!atomicMassKnownAccurately)
        return [NSString stringWithFormat: @"[%@]", self.atomicMass];
    else {
        NSString *atomicMassUncertainty = [self valueForKey: ELEMENT_ATOMIC_MASS_UNCERTAINTY];
        if (atomicMassUncertainty != nil)
            return [NSString stringWithFormat: @"%@(%@)", self.atomicMass, atomicMassUncertainty];
    }
    return nil;
}

- (NSString *) kShellElectrons {
    NSInteger s1 = [(self.electronConfiguration)[@"1s"] intValue];
    return (s1 == 0) ? STRING_EMPTY : [NSString stringWithFormat: @"%d", s1];
}

- (NSString *) lShellElectrons {
    NSInteger s2 = [(self.electronConfiguration)[@"2s"] intValue];
    NSInteger p2 = [(self.electronConfiguration)[@"2p"] intValue];
    NSInteger tot = s2 + p2;
    return (tot == 0) ? STRING_EMPTY : [NSString stringWithFormat: @"%d", tot];
}

- (NSString *) mShellElectrons {
    NSInteger s3 = [(self.electronConfiguration)[@"3s"] intValue];
    NSInteger p3 = [(self.electronConfiguration)[@"3p"] intValue];
    NSInteger d3 = [(self.electronConfiguration)[@"3d"] intValue];
    NSInteger tot = s3 + p3 + d3;
    return (tot == 0) ? STRING_EMPTY : [NSString stringWithFormat: @"%d", tot];
}

- (NSString *) nShellElectrons {
    NSInteger s4 = [(self.electronConfiguration)[@"4s"] intValue];
    NSInteger p4 = [(self.electronConfiguration)[@"4p"] intValue];
    NSInteger d4 = [(self.electronConfiguration)[@"4d"] intValue];
    NSInteger f4 = [(self.electronConfiguration)[@"4f"] intValue];
    NSInteger tot = s4 + p4 + d4 + f4;
    return (tot == 0) ? STRING_EMPTY : [NSString stringWithFormat: @"%d", tot];
}

- (NSString *) oShellElectrons {
    NSInteger s5 = [(self.electronConfiguration)[@"5s"] intValue];
    NSInteger p5 = [(self.electronConfiguration)[@"5p"] intValue];
    NSInteger d5 = [(self.electronConfiguration)[@"5d"] intValue];
    NSInteger f5 = [(self.electronConfiguration)[@"5f"] intValue];
    NSInteger tot = s5 + p5 + d5 + f5;
    return (tot == 0) ? STRING_EMPTY : [NSString stringWithFormat: @"%d", tot];
}

- (NSString *) pShellElectrons {
    NSInteger s6 = [(self.electronConfiguration)[@"6s"] intValue];
    NSInteger p6 = [(self.electronConfiguration)[@"6p"] intValue];
    NSInteger d6 = [(self.electronConfiguration)[@"6d"] intValue];
    NSInteger tot = s6 + p6 + d6;
    return (tot == 0) ? STRING_EMPTY : [NSString stringWithFormat: @"%d", tot];
}

- (NSString *) qShellElectrons {
    NSInteger s7 = [(self.electronConfiguration)[@"7s"] intValue];
    NSInteger p7 = [(self.electronConfiguration)[@"7p"] intValue];
    NSInteger tot = s7 + p7;
    return (tot == 0) ? STRING_EMPTY : [NSString stringWithFormat: @"%d", tot];
}

- (NSString *) shell1s {
    return ((self.electronConfiguration)[@"1s"] != nil) ? (self.electronConfiguration)[@"1s"] : STRING_EMPTY;
}

- (NSString *) shell2s {
    return ((self.electronConfiguration)[@"2s"] != nil) ? (self.electronConfiguration)[@"2s"] : STRING_EMPTY;
}

- (NSString *) shell2p {
    return ((self.electronConfiguration)[@"2p"] != nil) ? (self.electronConfiguration)[@"2p"] : STRING_EMPTY;
}

- (NSString *) shell3s {
    return ((self.electronConfiguration)[@"3s"] != nil) ? (self.electronConfiguration)[@"3s"] : STRING_EMPTY;
}

- (NSString *) shell3p {
    return ((self.electronConfiguration)[@"3p"] != nil) ? (self.electronConfiguration)[@"3p"] : STRING_EMPTY;
}

- (NSString *) shell3d {
    return ((self.electronConfiguration)[@"3d"] != nil) ? (self.electronConfiguration)[@"3d"] : STRING_EMPTY;
}

- (NSString *) shell4s {
    return ((self.electronConfiguration)[@"4s"] != nil) ? (self.electronConfiguration)[@"4s"] : STRING_EMPTY;
}

- (NSString *) shell4p {
    return ((self.electronConfiguration)[@"4p"] != nil) ? (self.electronConfiguration)[@"4p"] : STRING_EMPTY;
}

- (NSString *) shell4d {
    return ((self.electronConfiguration)[@"4d"] != nil) ? (self.electronConfiguration)[@"4d"] : STRING_EMPTY;
}

- (NSString *) shell4f {
    return ((self.electronConfiguration)[@"4f"] != nil) ? (self.electronConfiguration)[@"4f"] : STRING_EMPTY;
}

- (NSString *) shell5s {
    return ((self.electronConfiguration)[@"5s"] != nil) ? (self.electronConfiguration)[@"5s"] : STRING_EMPTY;
}

- (NSString *) shell5p {
    return ((self.electronConfiguration)[@"5p"] != nil) ? (self.electronConfiguration)[@"5p"] : STRING_EMPTY;
}

- (NSString *) shell5d {
    return ((self.electronConfiguration)[@"5d"] != nil) ? (self.electronConfiguration)[@"5d"] : STRING_EMPTY;
}

- (NSString *) shell5f {
    return ((self.electronConfiguration)[@"5f"] != nil) ? (self.electronConfiguration)[@"5f"] : STRING_EMPTY;
}

- (NSString *) shell6s {
    return ((self.electronConfiguration)[@"6s"] != nil) ? (self.electronConfiguration)[@"6s"] : STRING_EMPTY;
}

- (NSString *) shell6p {
    return ((self.electronConfiguration)[@"6p"] != nil) ? (self.electronConfiguration)[@"6p"] : STRING_EMPTY;
}

- (NSString *) shell6d {
    return ((self.electronConfiguration)[@"6d"] != nil) ? (self.electronConfiguration)[@"6d"] : STRING_EMPTY;
}

- (NSString *) shell7s {
    return ((self.electronConfiguration)[@"7s"] != nil) ? (self.electronConfiguration)[@"7s"] : STRING_EMPTY;
}

- (NSString *) shell7p {
    return ((self.electronConfiguration)[@"7p"] != nil) ? (self.electronConfiguration)[@"7p"] : STRING_EMPTY;
}

- (UIColor *) seriesColor {
    return [[XTRColorFactory class] colorForString:[self valueForKey: ELEMENT_SERIES]];
}

- (UIColor *) standardConditionColor {
    return [[XTRColorFactory class] colorForString:[self valueForKey: ELEMENT_STANDARD_CONDITION]];
}

- (UIImage *) crystalStructureImage {
    NSString *aPath = [[NSBundle bundleForClass:[self class]] pathForResource:[self valueForKey: ELEMENT_CRYSTAL_STRUCTURE] ofType: @"png" inDirectory: SUPPORTING_FILES];
    UIImage *image = [[UIImage alloc] initWithContentsOfFile: aPath];
    return (aPath != nil) ? image : [self _unknownImage];
}

- (UIImage *) shellModelImage {
    NSString *aPath = [[NSBundle bundleForClass:[self class]] pathForResource:[self symbol] ofType: @"png" inDirectory: SUPPORTING_FILES];
    UIImage *image = [[UIImage alloc] initWithContentsOfFile: aPath];
    return (aPath != nil) ? image : [self _unknownImage];
}

- (NSNumber *) hardnessScaleBrinellScaled {
    NSNumber *aValue = self.hardnessScaleBrinell;
    return @([aValue floatValue] / 100);
}

- (NSNumber *) hardnessScaleVickersScaled {
    NSNumber *aValue = self.hardnessScaleVickers;
    return @([aValue floatValue] / 100);
}

- (NSNumber *) coefficientOfLinealThermalExpansionScaled {
    NSNumber *aValue = self.coefficientOfLinealThermalExpansion;
    return @([aValue floatValue] * 100000);
}

- (NSString *) fillingOrbital {
    return [self _attributedStringForArray:[self valueForKey: ELEMENT_FILLING_ORBITAL]];
}

- (NSString *) valence {
    return [self _attributedStringForArray:[self valueForKey: ELEMENT_VALENCE_ELECTRONS]];
}

- (NSString *)boilingPointString {
    return [NSString stringWithFormat: @"%@", self.boilingPoint];
}

- (NSString *)meltingPointString {
    return [NSString stringWithFormat: @"%@", self.meltingPoint];
}

- (NSString *)nameString {
    return [NSString stringWithFormat: @"Element Inspector for %@", self.name];
}

- (NSString *)periodString {
    return [NSString stringWithFormat: @"%d ", [self.period intValue]];
}

- (NSString *)groupString {
    return [NSString stringWithFormat: @"%d ", [self.group intValue]];
}

- (NSString *)seriesString {
    return [NSString stringWithFormat: @" %@", self.series];
}

- (NSString *)casRegNoString {
    return [NSString stringWithFormat: @" %@", [self valueForKey: ELEMENT_CAS_REGISTRY_NUMBER]];
}

@end

@implementation XTRElement (Sorting)

- (NSComparisonResult) _compareInt: (int) first withInt: (int) secondInt {
    if (first < secondInt)
        return NSOrderedAscending;
    else if (first > secondInt)
        return NSOrderedDescending;
    else
        return NSOrderedSame;
}

- (NSComparisonResult) _compareFloat: (float) first withFloat: (float) second {
    if (first < second)
        return NSOrderedAscending;
    else if (first > second)
        return NSOrderedDescending;
    else
        return NSOrderedSame;
}

- (NSComparisonResult) atomicNumberComparison: (XTRElement *) anElement {
    return [self _compareInt:[self.atomicNumber intValue] withInt:[anElement.atomicNumber intValue]];
}

- (NSComparisonResult) atomicMassComparison: (XTRElement *) anElement {
    return [self _compareFloat:[self.atomicMass floatValue] withFloat:[anElement.atomicMass floatValue]];
}

- (NSComparisonResult) boilingPointComparison: (XTRElement *) anElement {
    return [self _compareFloat:[self.boilingPoint floatValue] withFloat:[anElement.boilingPoint floatValue]];
}

- (NSComparisonResult) densityComparison: (XTRElement *) anElement {
    return [self _compareFloat:[self.density floatValue] withFloat:[anElement.density floatValue]];
}

- (NSComparisonResult) groupComparison: (XTRElement *) anElement {
    return [self _compareInt:[self.group intValue] withInt:[anElement.group intValue]];
}

- (NSComparisonResult) meltingPointComparison: (XTRElement *) anElement {
    return [self _compareFloat:[self.meltingPoint floatValue] withFloat:[anElement.meltingPoint floatValue]];
}

- (NSComparisonResult) nameComparison: (XTRElement *) anElement {
    return [self.name compare:anElement.name options: NSCaseInsensitiveSearch];
}

- (NSComparisonResult) periodComparison: (XTRElement *) anElement {
    return [self _compareInt:[self.period intValue] withInt:[anElement.period intValue]];
}

- (NSComparisonResult) seriesComparison: (XTRElement *) anElement {
    return [self.series compare:anElement.series options: NSCaseInsensitiveSearch];
}

- (NSComparisonResult) symbolComparison: (XTRElement *) anElement {
    return [self.symbol compare:anElement.symbol options: NSCaseInsensitiveSearch];
}

@end
