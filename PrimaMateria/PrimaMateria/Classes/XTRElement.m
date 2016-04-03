//
// XTRElement.m
// PrimaMateria
//
//  Created by Jerry Porter on 3/22/2010.
//  Copyright 2016 xTrensa. All rights reserved.
//

#import "PrimaMateria.h"

@implementation XTRElement

#pragma mark Accessor Methods

- (id) valueForKey: (NSString *) aKey {
    if ([aKey isEqualToString: ELEMENT_KSHELL_ELECTRONS])
        return self.kShellElectrons;
    else if ([aKey isEqualToString: ELEMENT_LSHELL_ELECTRONS])
        return self.lShellElectrons;
    else if ([aKey isEqualToString: ELEMENT_MSHELL_ELECTRONS])
        return self.mShellElectrons;
    else if ([aKey isEqualToString: ELEMENT_NSHELL_ELECTRONS])
        return self.nShellElectrons;
    else if ([aKey isEqualToString: ELEMENT_OSHELL_ELECTRONS])
        return self.oShellElectrons;
    else if ([aKey isEqualToString: ELEMENT_PSHELL_ELECTRONS])
        return self.pShellElectrons;
    else if ([aKey isEqualToString: ELEMENT_QSHELL_ELECTRONS])
        return self.qShellElectrons;
    else if ([aKey isEqualToString: ELEMENT_ATOMIC_MASS_AGGREGATE])
        return self.atomicMassAggregate;
    else return [self.elementDictionary valueForKey: aKey];
}

- (void)setValue: (id) anObject forKey: (NSString *) aKey {
    self.elementDictionary[aKey] = anObject;
}

- (NSNumber *) atomicNumber {
    return ([self valueForKey: ELEMENT_ATOMIC_NUMBER] != nil) ? [self valueForKey: ELEMENT_ATOMIC_NUMBER] : @0;
}

- (NSNumber *) atomicRadius {
    NSNumber *aValue = [self valueForKey: ELEMENT_ATOMIC_RADIUS];
    return (aValue != nil) ? aValue : @0;
}

- (NSNumber *) atomicMass {
    NSNumber *aValue = [self valueForKey: ELEMENT_ATOMIC_MASS];
    return (aValue != nil) ? aValue : @0;
}

- (NSNumber *) atomicVolume {
    NSNumber *aValue = [self valueForKey: ELEMENT_ATOMIC_VOLUME];
    return (aValue != nil) ? aValue : @0;
}

- (NSNumber *) boilingPoint {
    NSNumber *aValue = [self valueForKey: ELEMENT_BOILING_POINT];
    return (aValue != nil) ? aValue : @0;
}

- (NSNumber *) covalentRadius {
    NSNumber *aValue = [self valueForKey: ELEMENT_COVALENT_RADIUS];
    return (aValue != nil) ? aValue : @0;
}

- (NSNumber *) coefficientOfLinealThermalExpansion {
    NSNumber *aValue = [self valueForKey: ELEMENT_COEFFICIENT_OF_LINEAL_THERMAL_EXPANSION];
    return (aValue != nil) ? aValue : @0;
}

- (NSNumber *) density {
    NSNumber *aValue = [self valueForKey: ELEMENT_DENSITY];
    return (aValue != nil) ? aValue : @0;
}

- (NSString *) descr {
    return [self valueForKey: ELEMENT_DESCR];
}

- (NSDictionary *) electronConfiguration {
    return [self valueForKey: ELEMENT_ELECTRON_CONFIGURATION];
}

- (NSNumber *) group {
    return [self valueForKey: ELEMENT_GROUP];
}

- (NSNumber *) meltingPoint {
    return [self valueForKey: ELEMENT_MELTING_POINT];
}

- (NSString *) name {
    return [self valueForKey: ELEMENT_NAME];
}

- (NSArray *) nuclidesAndIsotopes {
    return [self valueForKey: ELEMENT_NUCLIDESANDISOTOPES];
}

- (NSNumber *) period {
    return [self valueForKey: ELEMENT_PERIOD];
}

- (NSString *) series {
    return [self valueForKey: ELEMENT_SERIES];
}

- (NSString *) symbol {
    return [self valueForKey: ELEMENT_SYMBOL];
}

- (NSArray *) lineSpectra {
    return [self valueForKey: ELEMENT_LINE_SPECTRA];
}

- (NSDictionary *) vaporPressure {
    return [self valueForKey: ELEMENT_VAPOR_PRESSURE];
}

- (NSNumber *) elasticModulusBulk {
    NSNumber *aValue = [self valueForKey: ELEMENT_ELASTIC_MODULUS_BULK];
    return (aValue != nil) ? aValue : @0;
}

- (NSNumber *) elasticModulusRigidity {
    NSNumber *aValue = [self valueForKey: ELEMENT_ELASTIC_MODULUS_RIGIDITY];
    return (aValue != nil) ? aValue : @0;
}

- (NSNumber *) elasticModulusYoungs {
    NSNumber *aValue = [self valueForKey: ELEMENT_ELASTIC_MODULUS_YOUNGS];
    return (aValue != nil) ? aValue : @0;
}

- (NSNumber *) electroChemicalEquivalent {
    NSNumber *aValue = [self valueForKey: ELEMENT_ELECTRO_CHEMICAL_EQUIVALENT];
    return (aValue != nil) ? aValue : @0;
}

- (NSNumber *) crossSection {
    NSNumber *aValue = [self valueForKey: ELEMENT_CROSS_SECTION];
    return (aValue != nil) ? aValue : @0;
}

- (NSNumber *) electroNegativity {
    NSNumber *aValue = [self valueForKey: ELEMENT_ELECTRO_NEGATIVITY];
    return (aValue != nil) ? aValue : @0;
}

- (NSNumber *) electronWorkFunction {
    NSNumber *aValue = [self valueForKey: ELEMENT_ELECTRON_WORK_FUNCTION];
    return (aValue != nil) ? aValue : @0;
}

- (NSNumber *) enthalpyOfAutomization {
    NSNumber *aValue = [self valueForKey: ELEMENT_ENTHALPY_OF_ATOMIZATION];
    return (aValue != nil) ? aValue : @0;
}

- (NSNumber *) enthalpyOfFusion {
    NSNumber *aValue = [self valueForKey: ELEMENT_ENTHALPY_OF_FUSION];
    return (aValue != nil) ? aValue : @0;
}

- (NSNumber *) enthalpyOfVaporization {
    NSNumber *aValue = [self valueForKey: ELEMENT_ENTHALPY_OF_VAPORIZATION];
    return (aValue != nil) ? aValue : @0;
}

- (NSNumber *) ionicRadius {
    NSNumber *aValue = [self valueForKey: ELEMENT_IONIC_RADIUS];
    return (aValue != nil) ? aValue : @0;
}

- (NSNumber *) hardnessScaleBrinell {
    NSNumber *aValue = [self valueForKey: ELEMENT_HARDNESS_SCALE_BRINELL];
    return (aValue != nil) ? aValue : @0;
}

- (NSNumber *) hardnessScaleMohs {
    NSNumber *aValue = [self valueForKey: ELEMENT_HARDNESS_SCALE_MOHS];
    return (aValue != nil) ? aValue : @0;
}

- (NSNumber *) hardnessScaleVickers {
    NSNumber *aValue = [self valueForKey: ELEMENT_HARDNESS_SCALE_VICKERS];
    return (aValue != nil) ? aValue : @0;
}

- (NSNumber *) heatOfFusion {
    NSNumber *aValue = [self valueForKey: ELEMENT_HEAT_OF_FUSION];
    return (aValue != nil) ? aValue : @0;
}

- (NSNumber *) heatOfVaporization {
    NSNumber *aValue = [self valueForKey: ELEMENT_HEAT_OF_VAPORIZATION];
    return (aValue != nil) ? aValue : @0;
}

- (NSNumber *) ionizationPotentialFirst {
    NSNumber *aValue = [self valueForKey: ELEMENT_IONIZATION_POTENTIAL_FIRST];
    return (aValue != nil) ? aValue : @0;
}

- (NSNumber *) ionizationPotentialSecond {
    NSNumber *aValue = [self valueForKey: ELEMENT_IONIZATION_POTENTIAL_SECOND];
    return (aValue != nil) ? aValue : @0;
}

- (NSNumber *) ionizationPotentialThird {
    NSNumber *aValue = [self valueForKey: ELEMENT_IONIZATION_POTENTIAL_THIRD];
    return (aValue != nil) ? aValue : @0;
}

- (NSNumber *) molarHeatCapacity {
    NSNumber *aValue = [self valueForKey: ELEMENT_MOLAR_HEAT_CAPACITY];
    return (aValue != nil) ? aValue : @0;
}

- (NSNumber *) molarVolume {
    NSNumber *aValue = [self valueForKey: ELEMENT_MOLAR_VOLUME];
    return (aValue != nil) ? aValue : @0;
}

- (NSNumber *) specificHeatCapacity {
    NSNumber *aValue = [self valueForKey: ELEMENT_SPECIFIC_HEAT_CAPACITY];
    return (aValue != nil) ? aValue : @0;
}

- (NSNumber *) valenceElectronPotential {
    NSNumber *aValue = [self valueForKey: ELEMENT_VALENCE_ELECTRON_POTENTIAL];
    return (aValue != nil) ? aValue : @0;
}

#pragma mark - Memory Management Methods

@end
