//
// XTRElement.h
// PrimaMateria
//
//  Created by Jerry Porter on 3/22/2010.
//  Copyright 2016 xTrensa. All rights reserved.
//

@interface XTRElement : NSObject

@property (nonatomic, strong) NSMutableDictionary *elementDictionary;

@property (nonatomic, readonly, copy) NSNumber *atomicMass;
@property (nonatomic, readonly, copy) NSNumber *atomicNumber;
@property (nonatomic, readonly, copy) NSNumber *atomicRadius;
@property (nonatomic, readonly, copy) NSNumber *atomicVolume;
@property (nonatomic, readonly, copy) NSNumber *boilingPoint;
@property (nonatomic, readonly, copy) NSNumber *coefficientOfLinealThermalExpansion;
@property (nonatomic, readonly, copy) NSNumber *covalentRadius;
@property (nonatomic, readonly, copy) NSNumber *crossSection;
@property (nonatomic, readonly, copy) NSNumber *density;
@property (nonatomic, readonly, copy) NSNumber *elasticModulusBulk;
@property (nonatomic, readonly, copy) NSNumber *elasticModulusRigidity;
@property (nonatomic, readonly, copy) NSNumber *elasticModulusYoungs;
@property (nonatomic, readonly, copy) NSNumber *electroChemicalEquivalent;
@property (nonatomic, readonly, copy) NSNumber *electroNegativity;
@property (nonatomic, readonly, copy) NSDictionary *electronConfiguration;
@property (nonatomic, readonly, copy) NSNumber *electronWorkFunction;
@property (nonatomic, readonly, copy) NSNumber *enthalpyOfAutomization;
@property (nonatomic, readonly, copy) NSNumber *enthalpyOfFusion;
@property (nonatomic, readonly, copy) NSNumber *enthalpyOfVaporization;
@property (nonatomic, readonly, copy) NSNumber *group;
@property (nonatomic, readonly, copy) NSNumber *hardnessScaleBrinell;
@property (nonatomic, readonly, copy) NSNumber *hardnessScaleMohs;
@property (nonatomic, readonly, copy) NSNumber *hardnessScaleVickers;
@property (nonatomic, readonly, copy) NSNumber *heatOfFusion;
@property (nonatomic, readonly, copy) NSNumber *heatOfVaporization;
@property (nonatomic, readonly, copy) NSNumber *ionicRadius;
@property (nonatomic, readonly, copy) NSNumber *ionizationPotentialFirst;
@property (nonatomic, readonly, copy) NSNumber *ionizationPotentialSecond;
@property (nonatomic, readonly, copy) NSNumber *ionizationPotentialThird;
@property (nonatomic, readonly, copy) NSArray *lineSpectra;
@property (nonatomic, readonly, copy) NSNumber *meltingPoint;
@property (nonatomic, readonly, copy) NSNumber *molarHeatCapacity;
@property (nonatomic, readonly, copy) NSNumber *molarVolume;
@property (nonatomic, readonly, copy) NSArray *nuclidesAndIsotopes;
@property (nonatomic, readonly, copy) NSNumber *period;
@property (nonatomic, readonly, copy) NSNumber *specificHeatCapacity;
@property (nonatomic, readonly, copy) NSNumber *valenceElectronPotential;
@property (nonatomic, readonly, copy) NSDictionary *vaporPressure;
@property (nonatomic, readonly, copy) NSString *descr;
@property (nonatomic, readonly, copy) NSString *name;
@property (nonatomic, readonly, copy) NSString *series;
@property (nonatomic, readonly, copy) NSString *symbol;

@end
