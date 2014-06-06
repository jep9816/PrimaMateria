//
// XTRElement.h
// PrimaMateria
//
//  Created by Jerry Porter on 3/22/2010.
//  Copyright 2014 xTrensa. All rights reserved.
//

@interface XTRElement : NSObject

@property (nonatomic, strong) NSMutableDictionary *elementDictionary;

- (NSNumber *)atomicMass;
- (NSNumber *)atomicNumber;
- (NSNumber *)atomicRadius;
- (NSNumber *)atomicVolume;
- (NSNumber *)boilingPoint;
- (NSNumber *)coefficientOfLinealThermalExpansion;
- (NSNumber *)covalentRadius;
- (NSNumber *)crossSection;
- (NSNumber *)density;
- (NSNumber *)elasticModulusBulk;
- (NSNumber *)elasticModulusRigidity;
- (NSNumber *)elasticModulusYoungs;
- (NSNumber *)electroChemicalEquivalent;
- (NSNumber *)electroNegativity;
- (NSDictionary *)electronConfiguration;
- (NSNumber *)electronWorkFunction;
- (NSNumber *)enthalpyOfAutomization;
- (NSNumber *)enthalpyOfFusion;
- (NSNumber *)enthalpyOfVaporization;
- (NSNumber *)group;
- (NSNumber *)hardnessScaleBrinell;
- (NSNumber *)hardnessScaleMohs;
- (NSNumber *)hardnessScaleVickers;
- (NSNumber *)heatOfFusion;
- (NSNumber *)heatOfVaporization;
- (NSNumber *)ionicRadius;
- (NSNumber *)ionizationPotentialFirst;
- (NSNumber *)ionizationPotentialSecond;
- (NSNumber *)ionizationPotentialThird;
- (NSArray *)lineSpectra;
- (NSNumber *)meltingPoint;
- (NSNumber *)molarHeatCapacity;
- (NSNumber *)molarVolume;
- (NSArray *)nuclidesAndIsotopes;
- (NSNumber *)period;
- (NSNumber *)specificHeatCapacity;
- (NSNumber *)valenceElectronPotential;
- (NSDictionary *)vaporPressure;
- (NSString *)descr;
- (NSString *)name;
- (NSString *)series;
- (NSString *)symbol;

@end
