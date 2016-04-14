//
//  XTRElementPropertiesViewController.h
//  PrimaMateria
//
//  Created by Jerry Porter on 11/21/11.
//  Copyright (c) 2016 xTrensa. All rights reserved.
//

@interface XTRElementPropertiesViewController : XTRSwapableViewController
@property (nonatomic, strong) IBOutlet UILabel *atomicMassFootnoteLabel;
@property (nonatomic, strong) IBOutlet UILabel *atomicMassLabel;
@property (nonatomic, strong) IBOutlet UILabel *boilingPointLabel;
@property (nonatomic, strong) IBOutlet UILabel *coefficientOfLinealThermalExpansionLabel;
@property (nonatomic, strong) IBOutlet UILabel *conductivityElectricalLabel;
@property (nonatomic, strong) IBOutlet UILabel *conductivityThermalLabel;
@property (nonatomic, strong) IBOutlet UILabel *criticalTemperatureLabel;
@property (nonatomic, strong) IBOutlet UILabel *densityLabel;
@property (nonatomic, strong) IBOutlet UILabel *descriptionLabel;
@property (nonatomic, strong) IBOutlet UILabel *elasticModulusBulkLabel;
@property (nonatomic, strong) IBOutlet UILabel *elasticModulusRigidityLabel;
@property (nonatomic, strong) IBOutlet UILabel *elasticModulusYoungsLabel;
@property (nonatomic, strong) IBOutlet UILabel *electroChemicalEquivalentLabel;
@property (nonatomic, strong) IBOutlet UILabel *electroNegativityLabel;
@property (nonatomic, strong) IBOutlet UILabel *electronWorkFunctionLabel;
@property (nonatomic, strong) IBOutlet UILabel *enthalpyAtomizationLabel;
@property (nonatomic, strong) IBOutlet UILabel *enthalpyFusionLabel;
@property (nonatomic, strong) IBOutlet UILabel *enthalpyVaporizationLabel;
@property (nonatomic, strong) IBOutlet UILabel *flammabilityClass;
@property (nonatomic, strong) IBOutlet UILabel *hardnessScaleBrinellLabel;
@property (nonatomic, strong) IBOutlet UILabel *hardnessScaleMohsLabel;
@property (nonatomic, strong) IBOutlet UILabel *hardnessScaleVickersLabel;
@property (nonatomic, strong) IBOutlet UILabel *heatCapacityMolarLabel;
@property (nonatomic, strong) IBOutlet UILabel *heatCapacitySpecificLabel;
@property (nonatomic, strong) IBOutlet UILabel *heatOfFusionLabel;
@property (nonatomic, strong) IBOutlet UILabel *heatOfVaporizationLabel;
@property (nonatomic, strong) IBOutlet UILabel *incompatabilitiesLabel;
@property (nonatomic, strong) IBOutlet UILabel *ionizationPotentialFirstLabel;
@property (nonatomic, strong) IBOutlet UILabel *ionizationPotentialSecondLabel;
@property (nonatomic, strong) IBOutlet UILabel *ionizationPotentialThirdLabel;
@property (nonatomic, strong) IBOutlet UILabel *magneticSusceptibilityLabel;
@property (nonatomic, strong) IBOutlet UILabel *meltingPointFootnoteLabel;
@property (nonatomic, strong) IBOutlet UILabel *meltingPointLabel;
@property (nonatomic, strong) IBOutlet UILabel *molarVolumeLabel;
@property (nonatomic, strong) IBOutlet UILabel *opticalReflectivityLabel;
@property (nonatomic, strong) IBOutlet UILabel *opticalRefractiveIndexLabel;
@property (nonatomic, strong) IBOutlet UILabel *qualitativeSolubilityLabel;
@property (nonatomic, strong) IBOutlet UILabel *relativeGasDensityLabel;
@property (nonatomic, strong) IBOutlet UILabel *valenceElectronPotentialLabel;
@property (nonatomic, strong) IBOutlet UILabel *vaporPressure100PaLabel;
@property (nonatomic, strong) IBOutlet UILabel *vaporPressure100kPaLabel;
@property (nonatomic, strong) IBOutlet UILabel *vaporPressure10PaLabel;
@property (nonatomic, strong) IBOutlet UILabel *vaporPressure10kPaLabel;
@property (nonatomic, strong) IBOutlet UILabel *vaporPressure1PaLabel;
@property (nonatomic, strong) IBOutlet UILabel *vaporPressure1kPaLabel;
@property (nonatomic, strong) IBOutlet UIScrollView *chemicalPropertiesScrollView;
@property (nonatomic, strong) IBOutlet UIScrollView *physicalPropertiesScrollView;
@property (nonatomic, strong) IBOutlet UIView *chemicalPropertiesView;
@property (nonatomic, strong) IBOutlet UIView *physicalPropertiesView;
@property (nonatomic, strong) IBOutlet UIView *swapView;

- (IBAction)swapViews : (UISegmentedControl *)sender;
- (void)setupUI;

@end
