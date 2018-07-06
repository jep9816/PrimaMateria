//
//  XTRElementPropertiesViewController.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 4/17/16.
//  Copyright © 2018 xTrensa. All rights reserved.
//

import UIKit

class XTRElementPropertiesViewController : XTRSwapableViewController {
    
    enum PropertiesViewTypes {
        static let kPhysicalPropertiesView = 0
        static let kChemicalPropertiesView = 1
    }
    
    @IBOutlet var segmentedControl: UISegmentedControl!
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
        if element != nil {
            let vaporPressure = element!.vaporPressure!
            
            atomicMassLabel.text = element!.atomicMassAggregate
            atomicMassFootnoteLabel.text = element!.atomicMassFootnote
            boilingPointLabel.text = element!.value(forKeyPath: ELEMENT_BOILING_POINT) as? String
            coefficientOfLinealThermalExpansionLabel.text = element!.value(forKeyPath: ELEMENT_COEFFICIENT_OF_LINEAL_THERMAL_EXPANSION) as? String
            criticalTemperatureLabel.text = element!.value(forKeyPath: ELEMENT_CRITICAL_TEMPERATURE) as? String
            descriptionLabel.text = element!.value(forKeyPath: ELEMENT_DESCR) as? String
            densityLabel.text = element!.value(forKeyPath: ELEMENT_DENSITY) as? String
            flammabilityClass.text = element!.value(forKeyPath: ELEMENT_FLAMMABILITY_CLASS) as? String
            heatOfVaporizationLabel.text = element!.value(forKeyPath: ELEMENT_HEAT_OF_VAPORIZATION) as? String
            magneticSusceptibilityLabel.text = element!.value(forKeyPath: ELEMENT_MAGNETIC_SUSCEPTIBILITY) as? String
            meltingPointLabel.text = element!.value(forKeyPath: ELEMENT_MELTING_POINT) as? String
            meltingPointFootnoteLabel.text = element!.value(forKeyPath: ELEMENT_MELTING_POINT_FOOTNOTE) as? String
            molarVolumeLabel.text = element!.value(forKeyPath: ELEMENT_MOLAR_VOLUME) as? String
            opticalReflectivityLabel.text = element!.value(forKeyPath: ELEMENT_OPTICAL_REFLECTIVITY) as? String
            opticalRefractiveIndexLabel.text = element!.value(forKeyPath: ELEMENT_OPTICAL_REFRACTIVE_INDEX) as? String
            relativeGasDensityLabel.text = element!.value(forKeyPath: ELEMENT_RELATIVE_GAS_DENSITY) as? String
            
            vaporPressure1PaLabel.text = String(format: "%@ %@", arguments: [vaporPressure["pa1"] as! String, vaporPressure["pa1Footnote"] as! String])
            vaporPressure10PaLabel.text = String(format: "%@ %@", arguments: [vaporPressure["pa10"] as! String, vaporPressure["pa10Footnote"] as! String])
            vaporPressure100PaLabel.text = String(format: "%@ %@", arguments: [vaporPressure["pa100"] as! String, vaporPressure["pa100Footnote"] as! String])
            vaporPressure1kPaLabel.text = String(format: "%@ %@", arguments: [vaporPressure["pa1k"] as! String, vaporPressure["pa1kFootnote"] as! String])
            vaporPressure10kPaLabel.text = String(format: "%@ %@", arguments: [vaporPressure["pa10k"] as! String, vaporPressure["pa10kFootnote"] as! String])
            vaporPressure100kPaLabel.text = String(format: "%@ %@", arguments: [vaporPressure["pa100k"] as! String, vaporPressure["pa100kFootnote"] as! String])
            
            conductivityThermalLabel.text = element!.value(forKeyPath: ELEMENT_CONDUCTIVITY_THERMAL) as? String
            conductivityElectricalLabel.text = element!.value(forKeyPath: ELEMENT_CONDUCTIVITY_ELECTRICAL) as? String
            elasticModulusBulkLabel.text = element!.value(forKeyPath: ELEMENT_ELASTIC_MODULUS_BULK) as? String
            elasticModulusRigidityLabel.text = element!.value(forKeyPath: ELEMENT_ELASTIC_MODULUS_RIGIDITY) as? String
            elasticModulusYoungsLabel.text = element!.value(forKeyPath: ELEMENT_ELASTIC_MODULUS_YOUNGS) as? String
            enthalpyAtomizationLabel.text = element!.value(forKeyPath: ELEMENT_ENTHALPY_OF_ATOMIZATION) as? String
            enthalpyFusionLabel.text = element!.value(forKeyPath: ELEMENT_ENTHALPY_OF_FUSION) as? String
            enthalpyVaporizationLabel.text = element!.value(forKeyPath: ELEMENT_ENTHALPY_OF_VAPORIZATION) as? String
            hardnessScaleBrinellLabel.text = element!.value(forKeyPath: ELEMENT_HARDNESS_SCALE_BRINELL) as? String
            hardnessScaleMohsLabel.text = element!.value(forKeyPath: ELEMENT_HARDNESS_SCALE_MOHS) as? String
            hardnessScaleVickersLabel.text = element!.value(forKeyPath: ELEMENT_HARDNESS_SCALE_VICKERS) as? String
            heatCapacitySpecificLabel.text = element!.value(forKeyPath: ELEMENT_SPECIFIC_HEAT_CAPACITY) as? String
            heatCapacityMolarLabel.text = element!.value(forKeyPath: ELEMENT_MOLAR_HEAT_CAPACITY) as? String
            
            electroChemicalEquivalentLabel.text = element!.value(forKeyPath: ELEMENT_ELECTRO_CHEMICAL_EQUIVALENT) as? String
            electronWorkFunctionLabel.text = element!.value(forKeyPath: ELEMENT_ELECTRON_WORK_FUNCTION) as? String
            electroNegativityLabel.text = element!.value(forKeyPath: ELEMENT_ELECTRO_NEGATIVITY) as? String
            heatOfFusionLabel.text = element!.value(forKeyPath: ELEMENT_HEAT_OF_FUSION) as? String
            incompatabilitiesLabel.text = element!.value(forKeyPath: ELEMENT_INCOMPATIBILITIES) as? String
            ionizationPotentialFirstLabel.text = element!.value(forKeyPath: ELEMENT_IONIZATION_POTENTIAL_FIRST) as? String
            ionizationPotentialSecondLabel.text = element!.value(forKeyPath: ELEMENT_IONIZATION_POTENTIAL_SECOND) as? String
            ionizationPotentialThirdLabel.text = element!.value(forKeyPath: ELEMENT_IONIZATION_POTENTIAL_THIRD) as? String
            qualitativeSolubilityLabel.text = element!.value(forKeyPath: ELEMENT_QUALITATIVE_SOLUBILITY) as? String
            valenceElectronPotentialLabel.text = element!.value(forKeyPath: ELEMENT_VALENCE_ELECTRON_POTENTIAL) as? String
        }
    }
    
    // MARK: - Action Methods
    
    @IBAction func swapViews(_ sender: UISegmentedControl) {
        switch (sender.selectedSegmentIndex) {
        case PropertiesViewTypes.kChemicalPropertiesView:
            chemicalPropertiesView.isHidden = false
            physicalPropertiesView.isHidden = true
        case PropertiesViewTypes.kPhysicalPropertiesView:
            chemicalPropertiesView.isHidden = true
            physicalPropertiesView.isHidden = false            
        default:
            break
        }
    }
    
    // MARK: - View Management Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        segmentedControl.setTitle(NSLocalizedString("physicalProperties", comment: ""), forSegmentAt: 0)
        segmentedControl.setTitle(NSLocalizedString("chemicalProperties", comment: ""), forSegmentAt: 1)

        chemicalPropertiesView.frame = swapView.frame
        chemicalPropertiesView.bounds = swapView.bounds
        chemicalPropertiesScrollView.contentSize = CGSize(width: 1024, height: 500)
        chemicalPropertiesView.isHidden = true
        view.addSubview(chemicalPropertiesView)
        
        physicalPropertiesView.frame = swapView.frame
        physicalPropertiesView.bounds = swapView.bounds
        physicalPropertiesScrollView.contentSize = CGSize(width: 1024, height: 1670)
        physicalPropertiesView.isHidden = false
        let rect = segmentedControl.frame
        let newRect = CGRect(x: rect.origin.x, y: rect.origin.y, width: rect.size.width, height: 34.0)
        segmentedControl.frame = newRect

        view.addSubview(physicalPropertiesView)
        
        swapView.removeFromSuperview()
    }
    
    override var shouldAutorotate : Bool {
        return false
    }
    
    override var supportedInterfaceOrientations : UIInterfaceOrientationMask {
        return .landscape
    }
    
    // MARK: - Memory Management Methods
    
    deinit {
        atomicMassFootnoteLabel = nil
        atomicMassLabel = nil
        boilingPointLabel = nil
        chemicalPropertiesScrollView = nil
        chemicalPropertiesView = nil
        coefficientOfLinealThermalExpansionLabel = nil
        conductivityElectricalLabel = nil
        conductivityThermalLabel = nil
        criticalTemperatureLabel = nil
        densityLabel = nil
        descriptionLabel = nil
        elasticModulusBulkLabel = nil
        elasticModulusRigidityLabel = nil
        elasticModulusYoungsLabel = nil
        electroChemicalEquivalentLabel = nil
        electroNegativityLabel = nil
        electronWorkFunctionLabel = nil
        enthalpyAtomizationLabel = nil
        enthalpyFusionLabel = nil
        enthalpyVaporizationLabel = nil
        flammabilityClass = nil
        hardnessScaleBrinellLabel = nil
        hardnessScaleMohsLabel = nil
        hardnessScaleVickersLabel = nil
        heatCapacityMolarLabel = nil
        heatCapacitySpecificLabel = nil
        heatOfFusionLabel = nil
        heatOfVaporizationLabel = nil
        incompatabilitiesLabel = nil
        ionizationPotentialFirstLabel = nil
        ionizationPotentialSecondLabel = nil
        ionizationPotentialThirdLabel = nil
        magneticSusceptibilityLabel = nil
        meltingPointFootnoteLabel = nil
        meltingPointLabel = nil
        molarVolumeLabel = nil
        opticalReflectivityLabel = nil
        opticalRefractiveIndexLabel = nil
        physicalPropertiesScrollView = nil
        physicalPropertiesView = nil
        qualitativeSolubilityLabel = nil
        relativeGasDensityLabel = nil
        swapView = nil
        valenceElectronPotentialLabel = nil
        vaporPressure100PaLabel = nil
        vaporPressure100kPaLabel = nil
        vaporPressure10PaLabel = nil
        vaporPressure10kPaLabel = nil
        vaporPressure1PaLabel = nil
        vaporPressure1kPaLabel = nil
    }
}
