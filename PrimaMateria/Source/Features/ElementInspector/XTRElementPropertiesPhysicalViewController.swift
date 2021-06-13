//
//  XTRElementPropertiesPhysicalViewController.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 6/12/21.
//  Copyright © 2021 Jerry Porter. All rights reserved.
//

import UIKit

class XTRElementPropertiesPhysicalViewController: XTRSwapableViewController {

    @IBOutlet var atomicMassFootnoteLabel: UILabel!
    @IBOutlet var atomicMassLabel: UILabel!
    @IBOutlet var boilingPointLabel: UILabel!
    @IBOutlet var coefficientOfLinealThermalExpansionLabel: UILabel!
    @IBOutlet var conductivityElectricalLabel: UILabel!
    @IBOutlet var conductivityThermalLabel: UILabel!
    @IBOutlet var criticalTemperatureLabel: UILabel!
    @IBOutlet var densityLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var elasticModulusBulkLabel: UILabel!
    @IBOutlet var elasticModulusRigidityLabel: UILabel!
    @IBOutlet var elasticModulusYoungsLabel: UILabel!
    @IBOutlet var enthalpyAtomizationLabel: UILabel!
    @IBOutlet var enthalpyFusionLabel: UILabel!
    @IBOutlet var enthalpyVaporizationLabel: UILabel!
    @IBOutlet var flammabilityClass: UILabel!
    @IBOutlet var hardnessScaleBrinellLabel: UILabel!
    @IBOutlet var hardnessScaleMohsLabel: UILabel!
    @IBOutlet var hardnessScaleVickersLabel: UILabel!
    @IBOutlet var heatCapacityMolarLabel: UILabel!
    @IBOutlet var heatCapacitySpecificLabel: UILabel!
    @IBOutlet var heatOfVaporizationLabel: UILabel!
    @IBOutlet var magneticSusceptibilityLabel: UILabel!
    @IBOutlet var meltingPointFootnoteLabel: UILabel!
    @IBOutlet var meltingPointLabel: UILabel!
    @IBOutlet var molarVolumeLabel: UILabel!
    @IBOutlet var opticalReflectivityLabel: UILabel!
    @IBOutlet var opticalRefractiveIndexLabel: UILabel!
    @IBOutlet var relativeGasDensityLabel: UILabel!
    @IBOutlet var vaporPressure100PaLabel: UILabel!
    @IBOutlet var vaporPressure100kPaLabel: UILabel!
    @IBOutlet var vaporPressure10PaLabel: UILabel!
    @IBOutlet var vaporPressure10kPaLabel: UILabel!
    @IBOutlet var vaporPressure1PaLabel: UILabel!
    @IBOutlet var vaporPressure1kPaLabel: UILabel!
    @IBOutlet var scrollView: UIScrollView!

    // MARK: - Initialization Methods

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    // MARK: - Internal Methods

    // MARK: - Miscellaneous Methods

    override func setupUIForAnimation(element: XTRElementModel) {
        super.setupUIForAnimation(element: element)

        setupLabels(element: element)
    }

    override func setupUI(element: XTRElementModel) {
        super.setupUI(element: element)

        setupLabels(element: element)
    }

    func setupVaporPressureLabels(_ vaporPressureModel: XTRVaporPressurenModel) {
        vaporPressure1PaLabel.text = vaporPressureModel.pa1
        vaporPressure10PaLabel.text = vaporPressureModel.pa10
        vaporPressure100PaLabel.text = vaporPressureModel.pa100
        vaporPressure1kPaLabel.text = vaporPressureModel.pa1k
        vaporPressure10kPaLabel.text = vaporPressureModel.pa10k
        vaporPressure100kPaLabel.text = vaporPressureModel.pa100k
    }

    func setupLabels(element: XTRElementModel) {
        let vaporPressureModel = element.vaporPressureModel!

        atomicMassLabel.text = element.atomicMassAggregate
        atomicMassFootnoteLabel.text = element.atomicMassFootnote
        boilingPointLabel.text = element.value(forKeyPath: ELEMENT_BOILING_POINT) as? String
        coefficientOfLinealThermalExpansionLabel.text = element.value(forKeyPath: ELEMENT_COEFFICIENT_OF_LINEAL_THERMAL_EXPANSION) as? String
        criticalTemperatureLabel.text = element.value(forKeyPath: ELEMENT_CRITICAL_TEMPERATURE) as? String
        descriptionLabel.text = element.value(forKeyPath: ELEMENT_DESCR) as? String
        densityLabel.text = element.value(forKeyPath: ELEMENT_DENSITY) as? String
        flammabilityClass.text = element.value(forKeyPath: ELEMENT_FLAMMABILITY_CLASS) as? String
        heatOfVaporizationLabel.text = element.value(forKeyPath: ELEMENT_HEAT_OF_VAPORIZATION) as? String
        magneticSusceptibilityLabel.text = element.value(forKeyPath: ELEMENT_MAGNETIC_SUSCEPTIBILITY) as? String
        meltingPointLabel.text = element.value(forKeyPath: ELEMENT_MELTING_POINT) as? String
        meltingPointFootnoteLabel.text = element.value(forKeyPath: ELEMENT_MELTING_POINT_FOOTNOTE) as? String
        molarVolumeLabel.text = element.value(forKeyPath: ELEMENT_MOLAR_VOLUME) as? String
        opticalReflectivityLabel.text = element.value(forKeyPath: ELEMENT_OPTICAL_REFLECTIVITY) as? String
        opticalRefractiveIndexLabel.text = element.value(forKeyPath: ELEMENT_OPTICAL_REFRACTIVE_INDEX) as? String
        relativeGasDensityLabel.text = element.value(forKeyPath: ELEMENT_RELATIVE_GAS_DENSITY) as? String

        setupVaporPressureLabels(vaporPressureModel)

        conductivityThermalLabel.text = element.value(forKeyPath: ELEMENT_CONDUCTIVITY_THERMAL) as? String
        conductivityElectricalLabel.text = element.value(forKeyPath: ELEMENT_CONDUCTIVITY_ELECTRICAL) as? String
        elasticModulusBulkLabel.text = element.value(forKeyPath: ELEMENT_ELASTIC_MODULUS_BULK) as? String
        elasticModulusRigidityLabel.text = element.value(forKeyPath: ELEMENT_ELASTIC_MODULUS_RIGIDITY) as? String
        elasticModulusYoungsLabel.text = element.value(forKeyPath: ELEMENT_ELASTIC_MODULUS_YOUNGS) as? String
        enthalpyAtomizationLabel.text = element.value(forKeyPath: ELEMENT_ENTHALPY_OF_ATOMIZATION) as? String
        enthalpyFusionLabel.text = element.value(forKeyPath: ELEMENT_ENTHALPY_OF_FUSION) as? String
        enthalpyVaporizationLabel.text = element.value(forKeyPath: ELEMENT_ENTHALPY_OF_VAPORIZATION) as? String
        hardnessScaleBrinellLabel.text = element.value(forKeyPath: ELEMENT_HARDNESS_SCALE_BRINELL) as? String
        hardnessScaleMohsLabel.text = element.value(forKeyPath: ELEMENT_HARDNESS_SCALE_MOHS) as? String
        hardnessScaleVickersLabel.text = element.value(forKeyPath: ELEMENT_HARDNESS_SCALE_VICKERS) as? String
        heatCapacitySpecificLabel.text = element.value(forKeyPath: ELEMENT_SPECIFIC_HEAT_CAPACITY) as? String
        heatCapacityMolarLabel.text = element.value(forKeyPath: ELEMENT_MOLAR_HEAT_CAPACITY) as? String
    }

    // MARK: - Action Methods

    // MARK: - View Management Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.delaysContentTouches = false
    }

    override func viewDidLayoutSubviews() {
        scrollView.contentSize = CGSize(width: 1024, height: 1100)
    }

    override var shouldAutorotate: Bool {
        return false
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscape
    }

    // MARK: - Memory Management Methods

    private func deinitVaporPressureLabels() {
        vaporPressure100PaLabel = nil
        vaporPressure100kPaLabel = nil
        vaporPressure10PaLabel = nil
        vaporPressure10kPaLabel = nil
        vaporPressure1PaLabel = nil
        vaporPressure1kPaLabel = nil
    }

    fileprivate func denitGroup1Labels() {
        atomicMassFootnoteLabel = nil
        atomicMassLabel = nil
        boilingPointLabel = nil
        coefficientOfLinealThermalExpansionLabel = nil
        conductivityElectricalLabel = nil
        conductivityThermalLabel = nil
        criticalTemperatureLabel = nil
        densityLabel = nil
        descriptionLabel = nil
        elasticModulusBulkLabel = nil
        elasticModulusRigidityLabel = nil
        elasticModulusYoungsLabel = nil
        enthalpyAtomizationLabel = nil
        enthalpyFusionLabel = nil
        enthalpyVaporizationLabel = nil
    }

    fileprivate func deinitGroup2Labels() {
        flammabilityClass = nil
        hardnessScaleBrinellLabel = nil
        hardnessScaleMohsLabel = nil
        hardnessScaleVickersLabel = nil
        heatCapacityMolarLabel = nil
        heatCapacitySpecificLabel = nil
        heatOfVaporizationLabel = nil
        magneticSusceptibilityLabel = nil
        meltingPointFootnoteLabel = nil
        meltingPointLabel = nil
        molarVolumeLabel = nil
        opticalReflectivityLabel = nil
        opticalRefractiveIndexLabel = nil
        scrollView = nil
        relativeGasDensityLabel = nil
        deinitVaporPressureLabels()
    }

    deinit {
        denitGroup1Labels()
        deinitGroup2Labels()
    }
    
}
