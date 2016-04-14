//
// XTRCategories.h
// PrimaMateria
//
//  Created by Jerry Porter on 3/22/2010.
//  Copyright 2016 xTrensa. All rights reserved.
//

@interface UIImage (Extentions)
+ (UIImage *)imageWithColor: (UIColor *)color size: (CGSize)size;
@end

@interface UIColor (Extentions)
+ (UIColor *)reverseColorOf: (UIColor *)oldColor;
@end

@interface XTRElement (Presentation)
@property (NS_NONATOMIC_IOSONLY, readonly, copy) NSString *atomicMassAggregate;
@property (NS_NONATOMIC_IOSONLY, readonly, copy) NSString *atomicMassFootnote;
@property (NS_NONATOMIC_IOSONLY, readonly, copy) UIColor *seriesColor;
@property (NS_NONATOMIC_IOSONLY, readonly, copy) UIColor *standardConditionColor;
@property (NS_NONATOMIC_IOSONLY, readonly, strong) UIImage *crystalStructureImage;
@property (NS_NONATOMIC_IOSONLY, readonly, strong) UIImage *shellModelImage;
@property (NS_NONATOMIC_IOSONLY, readonly, copy) NSString *pathForGeneralInfoDoc;
@property (NS_NONATOMIC_IOSONLY, readonly, copy) NSNumber *hardnessScaleBrinellScaled;
@property (NS_NONATOMIC_IOSONLY, readonly, copy) NSNumber *hardnessScaleVickersScaled;
@property (NS_NONATOMIC_IOSONLY, readonly, copy) NSNumber *coefficientOfLinealThermalExpansionScaled;

@property (NS_NONATOMIC_IOSONLY, readonly, copy) NSString *kShellElectrons;
@property (NS_NONATOMIC_IOSONLY, readonly, copy) NSString *lShellElectrons;
@property (NS_NONATOMIC_IOSONLY, readonly, copy) NSString *mShellElectrons;
@property (NS_NONATOMIC_IOSONLY, readonly, copy) NSString *nShellElectrons;
@property (NS_NONATOMIC_IOSONLY, readonly, copy) NSString *oShellElectrons;
@property (NS_NONATOMIC_IOSONLY, readonly, copy) NSString *pShellElectrons;
@property (NS_NONATOMIC_IOSONLY, readonly, copy) NSString *qShellElectrons;

@property (NS_NONATOMIC_IOSONLY, readonly, copy) NSString *shell1s;
@property (NS_NONATOMIC_IOSONLY, readonly, copy) NSString *shell2s;
@property (NS_NONATOMIC_IOSONLY, readonly, copy) NSString *shell2p;
@property (NS_NONATOMIC_IOSONLY, readonly, copy) NSString *shell3s;
@property (NS_NONATOMIC_IOSONLY, readonly, copy) NSString *shell3p;
@property (NS_NONATOMIC_IOSONLY, readonly, copy) NSString *shell3d;
@property (NS_NONATOMIC_IOSONLY, readonly, copy) NSString *shell4s;
@property (NS_NONATOMIC_IOSONLY, readonly, copy) NSString *shell4p;
@property (NS_NONATOMIC_IOSONLY, readonly, copy) NSString *shell4d;
@property (NS_NONATOMIC_IOSONLY, readonly, copy) NSString *shell4f;
@property (NS_NONATOMIC_IOSONLY, readonly, copy) NSString *shell5s;
@property (NS_NONATOMIC_IOSONLY, readonly, copy) NSString *shell5p;
@property (NS_NONATOMIC_IOSONLY, readonly, copy) NSString *shell5d;
@property (NS_NONATOMIC_IOSONLY, readonly, copy) NSString *shell5f;
@property (NS_NONATOMIC_IOSONLY, readonly, copy) NSString *shell6s;
@property (NS_NONATOMIC_IOSONLY, readonly, copy) NSString *shell6p;
@property (NS_NONATOMIC_IOSONLY, readonly, copy) NSString *shell6d;
@property (NS_NONATOMIC_IOSONLY, readonly, copy) NSString *shell7s;
@property (NS_NONATOMIC_IOSONLY, readonly, copy) NSString *shell7p;

@property (NS_NONATOMIC_IOSONLY, readonly, copy) NSString *fillingOrbital;
@property (NS_NONATOMIC_IOSONLY, readonly, copy) NSString *valence;
@property (NS_NONATOMIC_IOSONLY, readonly, copy) NSString *boilingPointString;
@property (NS_NONATOMIC_IOSONLY, readonly, copy) NSString *meltingPointString;
@property (NS_NONATOMIC_IOSONLY, readonly, copy) NSString *nameString;
@property (NS_NONATOMIC_IOSONLY, readonly, copy) NSString *periodString;
@property (NS_NONATOMIC_IOSONLY, readonly, copy) NSString *groupString;
@property (NS_NONATOMIC_IOSONLY, readonly, copy) NSString *seriesString;
@property (NS_NONATOMIC_IOSONLY, readonly, copy) NSString *casRegNoString;

@end

@interface XTRElement (Sorting)
- (NSComparisonResult)atomicNumberComparison : (XTRElement *)anElement;
- (NSComparisonResult)atomicMassComparison : (XTRElement *)anElement;
- (NSComparisonResult)boilingPointComparison : (XTRElement *)anElement;
- (NSComparisonResult)densityComparison : (XTRElement *)anElement;
- (NSComparisonResult)groupComparison : (XTRElement *)anElement;
- (NSComparisonResult)meltingPointComparison : (XTRElement *)anElement;
- (NSComparisonResult)nameComparison : (XTRElement *)anElement;
- (NSComparisonResult)periodComparison : (XTRElement *)anElement;
- (NSComparisonResult)seriesComparison : (XTRElement *)anElement;
- (NSComparisonResult)symbolComparison : (XTRElement *)anElement;
@end
