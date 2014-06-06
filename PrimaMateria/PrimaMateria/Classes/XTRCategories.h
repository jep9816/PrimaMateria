//
// XTRCategories.h
// PrimaMateria
//
//  Created by Jerry Porter on 3/22/2010.
//  Copyright 2014 xTrensa. All rights reserved.
//

@interface XTRElement (Presentation)
- (NSString *)atomicMassAggregate;
- (UIColor *)seriesColor;
- (UIColor *)standardConditionColor;
- (UIImage *)crystalStructureImage;
- (UIImage *)shellModelImage;
- (NSString *)pathForGeneralInfoDoc;
- (NSNumber *)hardnessScaleBrinellScaled;
- (NSNumber *)hardnessScaleVickersScaled;
- (NSNumber *)coefficientOfLinealThermalExpansionScaled;

- (NSString *)kShellElectrons;
- (NSString *)lShellElectrons;
- (NSString *)mShellElectrons;
- (NSString *)nShellElectrons;
- (NSString *)oShellElectrons;
- (NSString *)pShellElectrons;
- (NSString *)qShellElectrons;

- (NSString *)shell1s;
- (NSString *)shell2s;
- (NSString *)shell2p;
- (NSString *)shell3s;
- (NSString *)shell3p;
- (NSString *)shell3d;
- (NSString *)shell4s;
- (NSString *)shell4p;
- (NSString *)shell4d;
- (NSString *)shell4f;
- (NSString *)shell5s;
- (NSString *)shell5p;
- (NSString *)shell5d;
- (NSString *)shell5f;
- (NSString *)shell6s;
- (NSString *)shell6p;
- (NSString *)shell6d;
- (NSString *)shell7s;
- (NSString *)shell7p;

- (NSString *)fillingOrbital;
- (NSString *)valence;
- (NSString *)boilingPointString;
- (NSString *)meltingPointString;
- (NSString *)nameString;
- (NSString *)periodString;
- (NSString *)groupString;
- (NSString *)seriesString;
- (NSString *)casRegNoString;

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
