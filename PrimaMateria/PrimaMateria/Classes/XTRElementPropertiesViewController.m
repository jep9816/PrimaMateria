//
//  XTRElementPropertiesViewController.m
//  PrimaMateria
//
//  Created by Jerry Porter on 11/21/11.
//  Copyright 2016 xTrensa. All rights reserved.
//

typedef NS_ENUM(NSInteger, PropertiesViewTypes) {
    kPhysicalPropertiesView = 0,
    kChemicalPropertiesView = 1
};

@implementation XTRElementPropertiesViewController

#pragma mark Misc Methods

- (void)setupUI {
    if (self.element != nil) {
        self.atomicMassLabel.text = (self.element).atomicMassAggregate;
        self.atomicMassFootnoteLabel.text = self.element.atomicMassFootnote;
        self.boilingPointLabel.text = [self.element valueForKey: ELEMENT_BOILING_POINT];
        self.coefficientOfLinealThermalExpansionLabel.text = [self.element valueForKey: ELEMENT_COEFFICIENT_OF_LINEAL_THERMAL_EXPANSION];
        self.criticalTemperatureLabel.text = [self.element valueForKey: ELEMENT_CRITICAL_TEMPERATURE];
        self.descriptionLabel.text = [self.element valueForKey: ELEMENT_DESCR];
        self.densityLabel.text = [self.element valueForKey: ELEMENT_DENSITY];
        self.flammabilityClass.text = [self.element valueForKey: ELEMENT_FLAMMABILITY_CLASS];
        self.heatOfVaporizationLabel.text = [self.element valueForKey: ELEMENT_HEAT_OF_VAPORIZATION];
        self.magneticSusceptibilityLabel.text = [self.element valueForKey: ELEMENT_MAGNETIC_SUSCEPTIBILITY];
        self.meltingPointLabel.text = [self.element valueForKey: ELEMENT_MELTING_POINT];
        self.meltingPointFootnoteLabel.text = [self.element valueForKey: ELEMENT_MELTING_POINT_FOOTNOTE];
        self.molarVolumeLabel.text = [self.element valueForKey: ELEMENT_MOLAR_VOLUME];
        self.opticalReflectivityLabel.text = [self.element valueForKey: ELEMENT_OPTICAL_REFLECTIVITY];
        self.opticalRefractiveIndexLabel.text = [self.element valueForKey: ELEMENT_OPTICAL_REFRACTIVE_INDEX];
        self.relativeGasDensityLabel.text = [self.element valueForKey: ELEMENT_RELATIVE_GAS_DENSITY];
        
        self.vaporPressure1PaLabel.text = [NSString stringWithFormat: @"%@ %@", (self.element).vaporPressure[@"pa1"], (self.element).vaporPressure[@"pa1Footnote"]];
        self.vaporPressure10PaLabel.text = [NSString stringWithFormat: @"%@ %@", (self.element).vaporPressure[@"pa10"], (self.element).vaporPressure[@"pa10Footnote"]];
        self.vaporPressure100PaLabel.text = [NSString stringWithFormat: @"%@ %@", (self.element).vaporPressure[@"pa100"], (self.element).vaporPressure[@"pa100Footnote"]];
        self.vaporPressure1kPaLabel.text = [NSString stringWithFormat: @"%@ %@", (self.element).vaporPressure[@"pa1k"], (self.element).vaporPressure[@"pa1kFootnote"]];
        self.vaporPressure10kPaLabel.text = [NSString stringWithFormat: @"%@ %@", (self.element).vaporPressure[@"pa10k"], (self.element).vaporPressure[@"pa10kFootnote"]];
        self.vaporPressure100kPaLabel.text = [NSString stringWithFormat: @"%@ %@", (self.element).vaporPressure[@"pa100k"], (self.element).vaporPressure[@"pa100kFootnote"]];
        
        self.conductivityThermalLabel.text = [self.element valueForKey: ELEMENT_CONDUCTIVITY_THERMAL];
        self.conductivityElectricalLabel.text = [self.element valueForKey: ELEMENT_CONDUCTIVITY_ELECTRICAL];
        self.elasticModulusBulkLabel.text = [self.element valueForKey: ELEMENT_ELASTIC_MODULUS_BULK];
        self.elasticModulusRigidityLabel.text = [self.element valueForKey: ELEMENT_ELASTIC_MODULUS_RIGIDITY];
        self.elasticModulusYoungsLabel.text = [self.element valueForKey: ELEMENT_ELASTIC_MODULUS_YOUNGS];
        self.enthalpyAtomizationLabel.text = [self.element valueForKey: ELEMENT_ENTHALPY_OF_ATOMIZATION];
        self.enthalpyFusionLabel.text = [self.element valueForKey: ELEMENT_ENTHALPY_OF_FUSION];
        self.enthalpyVaporizationLabel.text = [self.element valueForKey: ELEMENT_ENTHALPY_OF_VAPORIZATION];
        self.hardnessScaleBrinellLabel.text = [self.element valueForKey: ELEMENT_HARDNESS_SCALE_BRINELL];
        self.hardnessScaleMohsLabel.text = [self.element valueForKey: ELEMENT_HARDNESS_SCALE_MOHS];
        self.hardnessScaleVickersLabel.text = [self.element valueForKey: ELEMENT_HARDNESS_SCALE_VICKERS];
        self.heatCapacitySpecificLabel.text = [self.element valueForKey: ELEMENT_SPECIFIC_HEAT_CAPACITY];
        self.heatCapacityMolarLabel.text = [self.element valueForKey: ELEMENT_MOLAR_HEAT_CAPACITY];
        
        self.electroChemicalEquivalentLabel.text = [self.element valueForKey: ELEMENT_ELECTRO_CHEMICAL_EQUIVALENT];
        self.electronWorkFunctionLabel.text = [self.element valueForKey: ELEMENT_ELECTRON_WORK_FUNCTION];
        self.electroNegativityLabel.text = [self.element valueForKey: ELEMENT_ELECTRO_NEGATIVITY];
        self.heatOfFusionLabel.text = [self.element valueForKey: ELEMENT_HEAT_OF_FUSION];
        self.incompatabilitiesLabel.text = [self.element valueForKey: ELEMENT_INCOMPATIBILITIES];
        self.ionizationPotentialFirstLabel.text = [self.element valueForKey: ELEMENT_IONIZATION_POTENTIAL_FIRST];
        self.ionizationPotentialSecondLabel.text = [self.element valueForKey: ELEMENT_IONIZATION_POTENTIAL_SECOND];
        self.ionizationPotentialThirdLabel.text = [self.element valueForKey: ELEMENT_IONIZATION_POTENTIAL_THIRD];
        self.qualitativeSolubilityLabel.text = [self.element valueForKey: ELEMENT_QUALITATIVE_SOLUBILITY];
        self.valenceElectronPotentialLabel.text = [self.element valueForKey: ELEMENT_VALENCE_ELECTRON_POTENTIAL];
    }
}

#pragma mark - Action Methods

- (IBAction) swapViews: (UISegmentedControl *) sender {
    switch (sender.selectedSegmentIndex) {
        case kChemicalPropertiesView:
            self.chemicalPropertiesView.hidden = NO;
            self.physicalPropertiesView.hidden = YES;
            break;
            
        case kPhysicalPropertiesView:
            self.chemicalPropertiesView.hidden = YES;
            self.physicalPropertiesView.hidden = NO;
            break;
            
        default:
            break;
    }
}

#pragma mark - View Management Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    self.chemicalPropertiesView.frame = self.swapView.frame;
    self.chemicalPropertiesView.bounds = self.swapView.bounds;
    self.chemicalPropertiesScrollView.contentSize = CGSizeMake(1024, 500);
    self.chemicalPropertiesView.hidden = YES;
    [self.view addSubview: self.chemicalPropertiesView];
    
    self.physicalPropertiesView.frame = self.swapView.frame;
    self.physicalPropertiesView.bounds = self.swapView.bounds;
    self.physicalPropertiesScrollView.contentSize = CGSizeMake(1024, 1670);
    self.physicalPropertiesView.hidden = NO;
    [self.view addSubview: self.physicalPropertiesView];
    
    [self.swapView removeFromSuperview];
}

- (BOOL) shouldAutorotateToInterfaceOrientation: (UIInterfaceOrientation) interfaceOrientation {
    return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

#pragma mark - Memory Management Methods

- (void)dealloc {
    self.atomicMassFootnoteLabel = nil;
    self.atomicMassLabel = nil;
    self.boilingPointLabel = nil;
    self.chemicalPropertiesScrollView = nil;
    self.chemicalPropertiesView = nil;
    self.coefficientOfLinealThermalExpansionLabel = nil;
    self.conductivityElectricalLabel = nil;
    self.conductivityThermalLabel = nil;
    self.criticalTemperatureLabel = nil;
    self.densityLabel = nil;
    self.descriptionLabel = nil;
    self.elasticModulusBulkLabel = nil;
    self.elasticModulusRigidityLabel = nil;
    self.elasticModulusYoungsLabel = nil;
    self.electroChemicalEquivalentLabel = nil;
    self.electroNegativityLabel = nil;
    self.electronWorkFunctionLabel = nil;
    self.enthalpyAtomizationLabel = nil;
    self.enthalpyFusionLabel = nil;
    self.enthalpyVaporizationLabel = nil;
    self.flammabilityClass = nil;
    self.hardnessScaleBrinellLabel = nil;
    self.hardnessScaleMohsLabel = nil;
    self.hardnessScaleVickersLabel = nil;
    self.heatCapacityMolarLabel = nil;
    self.heatCapacitySpecificLabel = nil;
    self.heatOfFusionLabel = nil;
    self.heatOfVaporizationLabel = nil;
    self.incompatabilitiesLabel = nil;
    self.ionizationPotentialFirstLabel = nil;
    self.ionizationPotentialSecondLabel = nil;
    self.ionizationPotentialThirdLabel = nil;
    self.magneticSusceptibilityLabel = nil;
    self.meltingPointFootnoteLabel = nil;
    self.meltingPointLabel = nil;
    self.molarVolumeLabel = nil;
    self.opticalReflectivityLabel = nil;
    self.opticalRefractiveIndexLabel = nil;
    self.physicalPropertiesScrollView = nil;
    self.physicalPropertiesView = nil;
    self.qualitativeSolubilityLabel = nil;
    self.relativeGasDensityLabel = nil;
    self.swapView = nil;
    self.valenceElectronPotentialLabel = nil;
    self.vaporPressure100PaLabel = nil;
    self.vaporPressure100kPaLabel = nil;
    self.vaporPressure10PaLabel = nil;
    self.vaporPressure10kPaLabel = nil;
    self.vaporPressure1PaLabel = nil;
    self.vaporPressure1kPaLabel = nil;
}

@end
