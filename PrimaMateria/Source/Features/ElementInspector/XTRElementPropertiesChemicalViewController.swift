//
//  XTRElementPropertiesChemicalViewController.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 6/12/21.
//  Copyright ©2021 Jerry Porter. All rights reserved.
//

import UIKit

class XTRElementPropertiesChemicalViewController: XTRSwapableViewController {

    @IBOutlet var electroChemicalEquivalentLabel: UILabel!
    @IBOutlet var electronWorkFunctionLabel: UILabel!
    @IBOutlet var electroNegativityLabel: UILabel!
    @IBOutlet var heatOfFusionLabel: UILabel!
    @IBOutlet var incompatabilitiesLabel: UILabel!
    @IBOutlet var valenceElectronPotentialLabel: UILabel!
    @IBOutlet var ionizationPotentialFirstLabel: UILabel!
    @IBOutlet var ionizationPotentialSecondLabel: UILabel!
    @IBOutlet var ionizationPotentialThirdLabel: UILabel!
    @IBOutlet var qualitativeSolubilityLabel: UILabel!
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

    func setupIonizationLabels(_ element: XTRElementModel) {
        ionizationPotentialFirstLabel.text = element.value(forKeyPath: ELEMENT_IONIZATION_POTENTIAL_FIRST) as? String
        ionizationPotentialSecondLabel.text = element.value(forKeyPath: ELEMENT_IONIZATION_POTENTIAL_SECOND) as? String
        ionizationPotentialThirdLabel.text = element.value(forKeyPath: ELEMENT_IONIZATION_POTENTIAL_THIRD) as? String
    }

    func setupLabels(element: XTRElementModel) {
        electroChemicalEquivalentLabel.text = element.value(forKeyPath: ELEMENT_ELECTRO_CHEMICAL_EQUIVALENT) as? String
        electronWorkFunctionLabel.text = element.value(forKeyPath: ELEMENT_ELECTRON_WORK_FUNCTION) as? String
        electroNegativityLabel.text = element.value(forKeyPath: ELEMENT_ELECTRO_NEGATIVITY) as? String
        heatOfFusionLabel.text = element.value(forKeyPath: ELEMENT_HEAT_OF_FUSION) as? String
        incompatabilitiesLabel.text = element.value(forKeyPath: ELEMENT_INCOMPATIBILITIES) as? String
        setupIonizationLabels(element)
        qualitativeSolubilityLabel.text = element.value(forKeyPath: ELEMENT_QUALITATIVE_SOLUBILITY) as? String
        valenceElectronPotentialLabel.text = element.value(forKeyPath: ELEMENT_VALENCE_ELECTRON_POTENTIAL) as? String
    }

    // MARK: - Action Methods

    // MARK: - View Management Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.delaysContentTouches = false
    }
    
    override var shouldAutorotate: Bool {
        return false
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscape
    }

    // MARK: - Memory Management Methods

    fileprivate func denitGroup1Labels() {
        electroChemicalEquivalentLabel = nil
        electroNegativityLabel = nil
        electronWorkFunctionLabel = nil
    }

    fileprivate func deinitGroup2Labels() {
        heatOfFusionLabel = nil
        incompatabilitiesLabel = nil
        ionizationPotentialFirstLabel = nil
        ionizationPotentialSecondLabel = nil
        ionizationPotentialThirdLabel = nil
        qualitativeSolubilityLabel = nil
        valenceElectronPotentialLabel = nil
    }

    deinit {
        denitGroup1Labels()
        deinitGroup2Labels()
    }

}
