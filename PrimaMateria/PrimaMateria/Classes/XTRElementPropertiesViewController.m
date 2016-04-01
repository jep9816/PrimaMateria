//
//  XTRElementPropertiesViewController.m
//  PrimaMateria
//
//  Created by Jerry Porter on 11/21/11.
//  Copyright 2016 xTrensa. All rights reserved.
//

#import "PrimaMateria.h"

typedef enum ViewTypes: NSInteger {
    kPhysicalPropertiesView = 0,
    kChemicalPropertiesView = 1
}
SwapViews;

@implementation XTRElementPropertiesViewController
@synthesize atomicMassFootnoteLabel;
@synthesize atomicMassLabel;
@synthesize boilingPointLabel;
@synthesize chemicalPropertiesScrollView;
@synthesize chemicalPropertiesView;
@synthesize coefficientOfLinealThermalExpansionLabel;
@synthesize conductivityElectricalLabel;
@synthesize conductivityThermalLabel;
@synthesize criticalTemperatureLabel;
@synthesize densityLabel;
@synthesize descriptionLabel;
@synthesize elasticModulusBulkLabel;
@synthesize elasticModulusRigidityLabel;
@synthesize elasticModulusYoungsLabel;
@synthesize electroChemicalEquivalentLabel;
@synthesize electroNegativityLabel;
@synthesize electronWorkFunctionLabel;
@synthesize enthalpyAtomizationLabel;
@synthesize enthalpyFusionLabel;
@synthesize enthalpyVaporizationLabel;
@synthesize flammabilityClass;
@synthesize hardnessScaleBrinellLabel;
@synthesize hardnessScaleMohsLabel;
@synthesize hardnessScaleVickersLabel;
@synthesize heatCapacityMolarLabel;
@synthesize heatCapacitySpecificLabel;
@synthesize heatOfFusionLabel;
@synthesize heatOfVaporizationLabel;
@synthesize incompatabilitiesLabel;
@synthesize ionizationPotentialFirstLabel;
@synthesize ionizationPotentialSecondLabel;
@synthesize ionizationPotentialThirdLabel;
@synthesize magneticSusceptibilityLabel;
@synthesize meltingPointFootnoteLabel;
@synthesize meltingPointLabel;
@synthesize molarVolumeLabel;
@synthesize opticalReflectivityLabel;
@synthesize opticalRefractiveIndexLabel;
@synthesize physicalPropertiesScrollView;
@synthesize physicalPropertiesView;
@synthesize qualitativeSolubilityLabel;
@synthesize relativeGasDensityLabel;
@synthesize swapView;
@synthesize valenceElectronPotentialLabel;
@synthesize vaporPressure100PaLabel;
@synthesize vaporPressure100kPaLabel;
@synthesize vaporPressure10PaLabel;
@synthesize vaporPressure10kPaLabel;
@synthesize vaporPressure1PaLabel;
@synthesize vaporPressure1kPaLabel;

#pragma mark Misc Methods

- (void) setupUI {
    if (self.element != nil) {
        atomicMassLabel.text = (self.element).atomicMassAggregate;
        atomicMassFootnoteLabel.text = [self.element valueForKey: ELEMENT_ATOMIC_MASS_FOOTNOTE];
        boilingPointLabel.text = [self.element valueForKey: ELEMENT_BOILING_POINT];
        coefficientOfLinealThermalExpansionLabel.text = [self.element valueForKey: ELEMENT_COEFFICIENT_OF_LINEAL_THERMAL_EXPANSION];
        criticalTemperatureLabel.text = [self.element valueForKey: ELEMENT_CRITICAL_TEMPERATURE];
        descriptionLabel.text = [self.element valueForKey: ELEMENT_DESCR];
        densityLabel.text = [self.element valueForKey: ELEMENT_DENSITY];
        flammabilityClass.text = [self.element valueForKey: ELEMENT_FLAMMABILITY_CLASS];
        heatOfVaporizationLabel.text = [self.element valueForKey: ELEMENT_HEAT_OF_VAPORIZATION];
        magneticSusceptibilityLabel.text = [self.element valueForKey: ELEMENT_MAGNETIC_SUSCEPTIBILITY];
        meltingPointLabel.text = [self.element valueForKey: ELEMENT_MELTING_POINT];
        meltingPointFootnoteLabel.text = [self.element valueForKey: ELEMENT_MELTING_POINT_FOOTNOTE];
        molarVolumeLabel.text = [self.element valueForKey: ELEMENT_MOLAR_VOLUME];
        opticalReflectivityLabel.text = [self.element valueForKey: ELEMENT_OPTICAL_REFLECTIVITY];
        opticalRefractiveIndexLabel.text = [self.element valueForKey: ELEMENT_OPTICAL_REFRACTIVE_INDEX];
        relativeGasDensityLabel.text = [self.element valueForKey: ELEMENT_RELATIVE_GAS_DENSITY];
        
        vaporPressure1PaLabel.text =
        [NSString stringWithFormat: @"%@ %@",
         [(self.element).vaporPressure valueForKey: @"pa1"],
         [(self.element).vaporPressure valueForKey: @"pa1Footnote"]];
        vaporPressure10PaLabel.text =
        [NSString stringWithFormat: @"%@ %@",
         [(self.element).vaporPressure valueForKey: @"pa10"],
         [(self.element).vaporPressure valueForKey: @"pa10Footnote"]];
        vaporPressure100PaLabel.text =
        [NSString stringWithFormat: @"%@ %@",
         [(self.element).vaporPressure valueForKey: @"pa100"],
         [(self.element).vaporPressure valueForKey: @"pa100Footnote"]];
        vaporPressure1kPaLabel.text =
        [NSString stringWithFormat: @"%@ %@",
         [(self.element).vaporPressure valueForKey: @"pa1k"],
         [(self.element).vaporPressure valueForKey: @"pa1kFootnote"]];
        vaporPressure10kPaLabel.text =
        [NSString stringWithFormat: @"%@ %@",
         [(self.element).vaporPressure valueForKey: @"pa10k"],
         [(self.element).vaporPressure valueForKey: @"pa10kFootnote"]];
        vaporPressure100kPaLabel.text =
        [NSString stringWithFormat: @"%@ %@",
         [(self.element).vaporPressure valueForKey: @"pa100k"],
         [(self.element).vaporPressure valueForKey: @"pa100kFootnote"]];
        
        conductivityThermalLabel.text = [self.element valueForKey: ELEMENT_CONDUCTIVITY_THERMAL];
        conductivityElectricalLabel.text = [self.element valueForKey: ELEMENT_CONDUCTIVITY_ELECTRICAL];
        elasticModulusBulkLabel.text = [self.element valueForKey: ELEMENT_ELASTIC_MODULUS_BULK];
        elasticModulusRigidityLabel.text = [self.element valueForKey: ELEMENT_ELASTIC_MODULUS_RIGIDITY];
        elasticModulusYoungsLabel.text = [self.element valueForKey: ELEMENT_ELASTIC_MODULUS_YOUNGS];
        enthalpyAtomizationLabel.text = [self.element valueForKey: ELEMENT_ENTHALPY_OF_ATOMIZATION];
        enthalpyFusionLabel.text = [self.element valueForKey: ELEMENT_ENTHALPY_OF_FUSION];
        enthalpyVaporizationLabel.text = [self.element valueForKey: ELEMENT_ENTHALPY_OF_VAPORIZATION];
        hardnessScaleBrinellLabel.text = [self.element valueForKey: ELEMENT_HARDNESS_SCALE_BRINELL];
        hardnessScaleMohsLabel.text = [self.element valueForKey: ELEMENT_HARDNESS_SCALE_MOHS];
        hardnessScaleVickersLabel.text = [self.element valueForKey: ELEMENT_HARDNESS_SCALE_VICKERS];
        heatCapacitySpecificLabel.text = [self.element valueForKey: ELEMENT_SPECIFIC_HEAT_CAPACITY];
        heatCapacityMolarLabel.text = [self.element valueForKey: ELEMENT_MOLAR_HEAT_CAPACITY];
        
        electroChemicalEquivalentLabel.text = [self.element valueForKey: ELEMENT_ELECTRO_CHEMICAL_EQUIVALENT];
        electronWorkFunctionLabel.text = [self.element valueForKey: ELEMENT_ELECTRON_WORK_FUNCTION];
        electroNegativityLabel.text = [self.element valueForKey: ELEMENT_ELECTRO_NEGATIVITY];
        heatOfFusionLabel.text = [self.element valueForKey: ELEMENT_HEAT_OF_FUSION];
        incompatabilitiesLabel.text = [self.element valueForKey: ELEMENT_INCOMPATIBILITIES];
        ionizationPotentialFirstLabel.text = [self.element valueForKey: ELEMENT_IONIZATION_POTENTIAL_FIRST];
        ionizationPotentialSecondLabel.text = [self.element valueForKey: ELEMENT_IONIZATION_POTENTIAL_SECOND];
        ionizationPotentialThirdLabel.text = [self.element valueForKey: ELEMENT_IONIZATION_POTENTIAL_THIRD];
        qualitativeSolubilityLabel.text = [self.element valueForKey: ELEMENT_QUALITATIVE_SOLUBILITY];
        valenceElectronPotentialLabel.text = [self.element valueForKey: ELEMENT_VALENCE_ELECTRON_POTENTIAL];
    }
}

#pragma mark - Action Methods

- (IBAction) swapViews: (UISegmentedControl *) sender {
    switch (sender.selectedSegmentIndex) {
        case kChemicalPropertiesView:
            chemicalPropertiesView.hidden = NO;
            physicalPropertiesView.hidden = YES;
            break;
            
        case kPhysicalPropertiesView:
            chemicalPropertiesView.hidden = YES;
            physicalPropertiesView.hidden = NO;
            break;
            
        default:
            break;
    }
}

#pragma mark - View Management Methods

- (void) viewDidLoad {
    [super viewDidLoad];
    chemicalPropertiesView.frame = self.swapView.frame;
    chemicalPropertiesView.bounds = self.swapView.bounds;
    chemicalPropertiesScrollView.contentSize = CGSizeMake(1024, 500);
    chemicalPropertiesView.hidden = YES;
    [self.view addSubview: chemicalPropertiesView];

    physicalPropertiesView.frame = self.swapView.frame;
    physicalPropertiesView.bounds = self.swapView.bounds;
    physicalPropertiesScrollView.contentSize = CGSizeMake(1024, 1670);
    physicalPropertiesView.hidden = NO;
    [self.view addSubview: physicalPropertiesView];

    [self.swapView removeFromSuperview];
}

- (BOOL) shouldAutorotateToInterfaceOrientation: (UIInterfaceOrientation) interfaceOrientation {
    return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

#pragma mark - Memory Management Methods

- (void) dealloc {
    atomicMassFootnoteLabel = nil;
    atomicMassLabel = nil;
    boilingPointLabel = nil;
    chemicalPropertiesScrollView = nil;
    chemicalPropertiesView = nil;
    coefficientOfLinealThermalExpansionLabel = nil;
    conductivityElectricalLabel = nil;
    conductivityThermalLabel = nil;
    criticalTemperatureLabel = nil;
    densityLabel = nil;
    descriptionLabel = nil;
    elasticModulusBulkLabel = nil;
    elasticModulusRigidityLabel = nil;
    elasticModulusYoungsLabel = nil;
    electroChemicalEquivalentLabel = nil;
    electroNegativityLabel = nil;
    electronWorkFunctionLabel = nil;
    enthalpyAtomizationLabel = nil;
    enthalpyFusionLabel = nil;
    enthalpyVaporizationLabel = nil;
    flammabilityClass = nil;
    hardnessScaleBrinellLabel = nil;
    hardnessScaleMohsLabel = nil;
    hardnessScaleVickersLabel = nil;
    heatCapacityMolarLabel = nil;
    heatCapacitySpecificLabel = nil;
    heatOfFusionLabel = nil;
    heatOfVaporizationLabel = nil;
    incompatabilitiesLabel = nil;
    ionizationPotentialFirstLabel = nil;
    ionizationPotentialSecondLabel = nil;
    ionizationPotentialThirdLabel = nil;
    magneticSusceptibilityLabel = nil;
    meltingPointFootnoteLabel = nil;
    meltingPointLabel = nil;
    molarVolumeLabel = nil;
    opticalReflectivityLabel = nil;
    opticalRefractiveIndexLabel = nil;
    physicalPropertiesScrollView = nil;
    physicalPropertiesView = nil;
    qualitativeSolubilityLabel = nil;
    relativeGasDensityLabel = nil;
    swapView = nil;
    valenceElectronPotentialLabel = nil;
    vaporPressure100PaLabel = nil;
    vaporPressure100kPaLabel = nil;
    vaporPressure10PaLabel = nil;
    vaporPressure10kPaLabel = nil;
    vaporPressure1PaLabel = nil;
    vaporPressure1kPaLabel = nil;
}

@end
