//
//  XTRElementPropertiesViewController.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 4/17/16.
//  Copyright © 2016 xTrensa. All rights reserved.
//

@objc class XTRElementPropertiesViewController : XTRSwapableViewController {
    
    enum PropertiesViewTypes: Int {
        case kPhysicalPropertiesView
        case kChemicalPropertiesView
    }
    
    @IBOutlet var atomicMassFootnoteLabel : UILabel!
    @IBOutlet var atomicMassLabel : UILabel!
    @IBOutlet var boilingPointLabel : UILabel!
    @IBOutlet var coefficientOfLinealThermalExpansionLabel : UILabel!
    @IBOutlet var conductivityElectricalLabel : UILabel!
    @IBOutlet var conductivityThermalLabel : UILabel!
    @IBOutlet var criticalTemperatureLabel : UILabel!
    @IBOutlet var densityLabel : UILabel!
    @IBOutlet var descriptionLabel : UILabel!
    @IBOutlet var elasticModulusBulkLabel : UILabel!
    @IBOutlet var elasticModulusRigidityLabel : UILabel!
    @IBOutlet var elasticModulusYoungsLabel : UILabel!
    @IBOutlet var electroChemicalEquivalentLabel : UILabel!
    @IBOutlet var electroNegativityLabel : UILabel!
    @IBOutlet var electronWorkFunctionLabel : UILabel!
    @IBOutlet var enthalpyAtomizationLabel : UILabel!
    @IBOutlet var enthalpyFusionLabel : UILabel!
    @IBOutlet var enthalpyVaporizationLabel : UILabel!
    @IBOutlet var flammabilityClass : UILabel!
    @IBOutlet var hardnessScaleBrinellLabel : UILabel!
    @IBOutlet var hardnessScaleMohsLabel : UILabel!
    @IBOutlet var hardnessScaleVickersLabel : UILabel!
    @IBOutlet var heatCapacityMolarLabel : UILabel!
    @IBOutlet var heatCapacitySpecificLabel : UILabel!
    @IBOutlet var heatOfFusionLabel : UILabel!
    @IBOutlet var heatOfVaporizationLabel : UILabel!
    @IBOutlet var incompatabilitiesLabel : UILabel!
    @IBOutlet var ionizationPotentialFirstLabel : UILabel!
    @IBOutlet var ionizationPotentialSecondLabel : UILabel!
    @IBOutlet var ionizationPotentialThirdLabel : UILabel!
    @IBOutlet var magneticSusceptibilityLabel : UILabel!
    @IBOutlet var meltingPointFootnoteLabel : UILabel!
    @IBOutlet var meltingPointLabel : UILabel!
    @IBOutlet var molarVolumeLabel : UILabel!
    @IBOutlet var opticalReflectivityLabel : UILabel!
    @IBOutlet var opticalRefractiveIndexLabel : UILabel!
    @IBOutlet var qualitativeSolubilityLabel : UILabel!
    @IBOutlet var relativeGasDensityLabel : UILabel!
    @IBOutlet var valenceElectronPotentialLabel : UILabel!
    @IBOutlet var vaporPressure100PaLabel : UILabel!
    @IBOutlet var vaporPressure100kPaLabel : UILabel!
    @IBOutlet var vaporPressure10PaLabel : UILabel!
    @IBOutlet var vaporPressure10kPaLabel : UILabel!
    @IBOutlet var vaporPressure1PaLabel : UILabel!
    @IBOutlet var vaporPressure1kPaLabel : UILabel!
    @IBOutlet var chemicalPropertiesScrollView : UIScrollView!
    @IBOutlet var physicalPropertiesScrollView : UIScrollView!
    @IBOutlet var chemicalPropertiesView : UIView!
    @IBOutlet var physicalPropertiesView : UIView!
    @IBOutlet var swapView : UIView!
    
    // MARK: - Initialization Methods
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    // MARK: - Internal Methods
    
    // MARK: - Miscellaneous Methods
    
    override func setupUI() {
        if (self.element != nil) {
            let vaporPressure : NSDictionary = self.element!.vaporPressure()!
            
            self.atomicMassLabel.text = self.element!.atomicMassAggregate()
            self.atomicMassFootnoteLabel.text = self.element!.atomicMassFootnote()
            self.boilingPointLabel.text = self.element!.valueForKey(ELEMENT_BOILING_POINT) as? String
            self.coefficientOfLinealThermalExpansionLabel.text = self.element!.valueForKey(ELEMENT_COEFFICIENT_OF_LINEAL_THERMAL_EXPANSION) as? String
            self.criticalTemperatureLabel.text = self.element!.valueForKey(ELEMENT_CRITICAL_TEMPERATURE) as? String
            self.descriptionLabel.text = self.element!.valueForKey(ELEMENT_DESCR) as? String
            self.densityLabel.text = self.element!.valueForKey(ELEMENT_DENSITY) as? String
            self.flammabilityClass.text = self.element!.valueForKey(ELEMENT_FLAMMABILITY_CLASS) as? String
            self.heatOfVaporizationLabel.text = self.element!.valueForKey(ELEMENT_HEAT_OF_VAPORIZATION) as? String
            self.magneticSusceptibilityLabel.text = self.element!.valueForKey(ELEMENT_MAGNETIC_SUSCEPTIBILITY) as? String
            self.meltingPointLabel.text = self.element!.valueForKey(ELEMENT_MELTING_POINT) as? String
            self.meltingPointFootnoteLabel.text = self.element!.valueForKey(ELEMENT_MELTING_POINT_FOOTNOTE) as? String
            self.molarVolumeLabel.text = self.element!.valueForKey(ELEMENT_MOLAR_VOLUME) as? String
            self.opticalReflectivityLabel.text = self.element!.valueForKey(ELEMENT_OPTICAL_REFLECTIVITY) as? String
            self.opticalRefractiveIndexLabel.text = self.element!.valueForKey(ELEMENT_OPTICAL_REFRACTIVE_INDEX) as? String
            self.relativeGasDensityLabel.text = self.element!.valueForKey(ELEMENT_RELATIVE_GAS_DENSITY) as? String
            
            self.vaporPressure1PaLabel.text = String.init(format: "%@ %@", arguments: [vaporPressure.valueForKey("pa1") as! String, vaporPressure.valueForKey("pa1Footnote") as! String])
            
            self.vaporPressure10PaLabel.text = String.init(format: "%@ %@", arguments: [vaporPressure.valueForKey("pa10") as! String, vaporPressure.valueForKey("pa10Footnote") as! String])
            
            self.vaporPressure100PaLabel.text = String.init(format: "%@ %@", arguments: [vaporPressure.valueForKey("pa100") as! String, vaporPressure.valueForKey("pa100Footnote") as! String])
            
            self.vaporPressure1kPaLabel.text = String.init(format: "%@ %@", arguments: [vaporPressure.valueForKey("pa1k") as! String, vaporPressure.valueForKey("pa1kFootnote") as! String])
            
            self.vaporPressure10kPaLabel.text = String.init(format: "%@ %@", arguments: [vaporPressure.valueForKey("pa10k") as! String, vaporPressure.valueForKey("pa10kFootnote") as! String])
            
            self.vaporPressure100kPaLabel.text = String.init(format: "%@ %@", arguments: [vaporPressure.valueForKey("pa100k") as! String, vaporPressure.valueForKey("pa100kFootnote") as! String])
            
            self.conductivityThermalLabel.text = self.element!.valueForKey(ELEMENT_CONDUCTIVITY_THERMAL) as? String
            self.conductivityElectricalLabel.text = self.element!.valueForKey(ELEMENT_CONDUCTIVITY_ELECTRICAL) as? String
            self.elasticModulusBulkLabel.text = self.element!.valueForKey(ELEMENT_ELASTIC_MODULUS_BULK) as? String
            self.elasticModulusRigidityLabel.text = self.element!.valueForKey(ELEMENT_ELASTIC_MODULUS_RIGIDITY) as? String
            self.elasticModulusYoungsLabel.text = self.element!.valueForKey(ELEMENT_ELASTIC_MODULUS_YOUNGS) as? String
            self.enthalpyAtomizationLabel.text = self.element!.valueForKey(ELEMENT_ENTHALPY_OF_ATOMIZATION) as? String
            self.enthalpyFusionLabel.text = self.element!.valueForKey(ELEMENT_ENTHALPY_OF_FUSION) as? String
            self.enthalpyVaporizationLabel.text = self.element!.valueForKey(ELEMENT_ENTHALPY_OF_VAPORIZATION) as? String
            self.hardnessScaleBrinellLabel.text = self.element!.valueForKey(ELEMENT_HARDNESS_SCALE_BRINELL) as? String
            self.hardnessScaleMohsLabel.text = self.element!.valueForKey(ELEMENT_HARDNESS_SCALE_MOHS) as? String
            self.hardnessScaleVickersLabel.text = self.element!.valueForKey(ELEMENT_HARDNESS_SCALE_VICKERS) as? String
            self.heatCapacitySpecificLabel.text = self.element!.valueForKey(ELEMENT_SPECIFIC_HEAT_CAPACITY) as? String
            self.heatCapacityMolarLabel.text = self.element!.valueForKey(ELEMENT_MOLAR_HEAT_CAPACITY) as? String
            
            self.electroChemicalEquivalentLabel.text = self.element!.valueForKey(ELEMENT_ELECTRO_CHEMICAL_EQUIVALENT) as? String
            self.electronWorkFunctionLabel.text = self.element!.valueForKey(ELEMENT_ELECTRON_WORK_FUNCTION) as? String
            self.electroNegativityLabel.text = self.element!.valueForKey(ELEMENT_ELECTRO_NEGATIVITY) as? String
            self.heatOfFusionLabel.text = self.element!.valueForKey(ELEMENT_HEAT_OF_FUSION) as? String
            self.incompatabilitiesLabel.text = self.element!.valueForKey(ELEMENT_INCOMPATIBILITIES) as? String
            self.ionizationPotentialFirstLabel.text = self.element!.valueForKey(ELEMENT_IONIZATION_POTENTIAL_FIRST) as? String
            self.ionizationPotentialSecondLabel.text = self.element!.valueForKey(ELEMENT_IONIZATION_POTENTIAL_SECOND) as? String
            self.ionizationPotentialThirdLabel.text = self.element!.valueForKey(ELEMENT_IONIZATION_POTENTIAL_THIRD) as? String
            self.qualitativeSolubilityLabel.text = self.element!.valueForKey(ELEMENT_QUALITATIVE_SOLUBILITY) as? String
            self.valenceElectronPotentialLabel.text = self.element!.valueForKey(ELEMENT_VALENCE_ELECTRON_POTENTIAL) as? String
        }
    }
    
    // MARK: - Action Methods
    
    @IBAction func swapViews(sender: UISegmentedControl) {
        switch (sender.selectedSegmentIndex) {
        case PropertiesViewTypes.kChemicalPropertiesView.rawValue:
            self.chemicalPropertiesView.hidden = false
            self.physicalPropertiesView.hidden = true
        case PropertiesViewTypes.kPhysicalPropertiesView.rawValue:
            self.chemicalPropertiesView.hidden = true
            self.physicalPropertiesView.hidden = false            
        default:
            break
        }
    }
    
    // MARK: - View Management Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.chemicalPropertiesView.frame = self.swapView.frame
        self.chemicalPropertiesView.bounds = self.swapView.bounds
        self.chemicalPropertiesScrollView.contentSize = CGSizeMake(1024, 500)
        self.chemicalPropertiesView.hidden = true
        self.view.addSubview(self.chemicalPropertiesView)
        
        self.physicalPropertiesView.frame = self.swapView.frame
        self.physicalPropertiesView.bounds = self.swapView.bounds
        self.physicalPropertiesScrollView.contentSize = CGSizeMake(1024, 1670)
        self.physicalPropertiesView.hidden = false
        self.view.addSubview(self.physicalPropertiesView)
        
        self.swapView.removeFromSuperview()
    }
    
    override func shouldAutorotate() -> Bool {
        return true
    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return [UIInterfaceOrientationMask.LandscapeLeft, UIInterfaceOrientationMask.LandscapeRight]
    }
    
    // MARK: - Memory Management Methods
    
    deinit {
        self.atomicMassFootnoteLabel = nil
        self.atomicMassLabel = nil
        self.boilingPointLabel = nil
        self.chemicalPropertiesScrollView = nil
        self.chemicalPropertiesView = nil
        self.coefficientOfLinealThermalExpansionLabel = nil
        self.conductivityElectricalLabel = nil
        self.conductivityThermalLabel = nil
        self.criticalTemperatureLabel = nil
        self.densityLabel = nil
        self.descriptionLabel = nil
        self.elasticModulusBulkLabel = nil
        self.elasticModulusRigidityLabel = nil
        self.elasticModulusYoungsLabel = nil
        self.electroChemicalEquivalentLabel = nil
        self.electroNegativityLabel = nil
        self.electronWorkFunctionLabel = nil
        self.enthalpyAtomizationLabel = nil
        self.enthalpyFusionLabel = nil
        self.enthalpyVaporizationLabel = nil
        self.flammabilityClass = nil
        self.hardnessScaleBrinellLabel = nil
        self.hardnessScaleMohsLabel = nil
        self.hardnessScaleVickersLabel = nil
        self.heatCapacityMolarLabel = nil
        self.heatCapacitySpecificLabel = nil
        self.heatOfFusionLabel = nil
        self.heatOfVaporizationLabel = nil
        self.incompatabilitiesLabel = nil
        self.ionizationPotentialFirstLabel = nil
        self.ionizationPotentialSecondLabel = nil
        self.ionizationPotentialThirdLabel = nil
        self.magneticSusceptibilityLabel = nil
        self.meltingPointFootnoteLabel = nil
        self.meltingPointLabel = nil
        self.molarVolumeLabel = nil
        self.opticalReflectivityLabel = nil
        self.opticalRefractiveIndexLabel = nil
        self.physicalPropertiesScrollView = nil
        self.physicalPropertiesView = nil
        self.qualitativeSolubilityLabel = nil
        self.relativeGasDensityLabel = nil
        self.swapView = nil
        self.valenceElectronPotentialLabel = nil
        self.vaporPressure100PaLabel = nil
        self.vaporPressure100kPaLabel = nil
        self.vaporPressure10PaLabel = nil
        self.vaporPressure10kPaLabel = nil
        self.vaporPressure1PaLabel = nil
        self.vaporPressure1kPaLabel = nil
    }
}