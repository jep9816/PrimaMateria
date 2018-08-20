//
//  XTRElement.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 4/15/16.
//  Copyright © 2018 xTrensa. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class XTRElementModel: NSObject {
    
    var elementDictionary: [String: Any]!
    
    init(dict: [String: Any]) {
        elementDictionary = dict
    }
    
    override func value(forKeyPath keyPath: String) -> Any? {
        switch keyPath {
        case ELEMENT_KSHELL_ELECTRONS:
            return kShellElectrons as AnyObject
        case ELEMENT_LSHELL_ELECTRONS:
            return lShellElectrons as AnyObject
        case ELEMENT_MSHELL_ELECTRONS:
            return mShellElectrons as AnyObject
        case ELEMENT_NSHELL_ELECTRONS:
            return nShellElectrons as AnyObject
        case ELEMENT_OSHELL_ELECTRONS:
            return oShellElectrons as AnyObject
        case ELEMENT_PSHELL_ELECTRONS:
            return pShellElectrons as AnyObject
        case ELEMENT_QSHELL_ELECTRONS:
            return qShellElectrons as AnyObject
        case ELEMENT_ATOMIC_MASS_AGGREGATE:
            return atomicMassAggregate as AnyObject
        default:
            let aValue = elementDictionary[keyPath]
            return (aValue != nil) ? aValue! as AnyObject: "" as AnyObject
        }
    }
    
    override func setValue(_ value: Any?, forKeyPath keyPath: String) {
        elementDictionary[keyPath] = value
    }
    
    var atomicNumber: BehaviorRelay<Int> {
        return value(forKeyPath: ELEMENT_ATOMIC_NUMBER) as! BehaviorRelay<Int>
    }
    
    var atomicRadius: Double {
        return double(ELEMENT_ATOMIC_RADIUS)
    }
    
    var atomicMass: Double {
        return double(ELEMENT_ATOMIC_MASS)
    }
    
    var atomicVolume: Double {
        return double(ELEMENT_ATOMIC_VOLUME)
    }
    
    var boilingPoint: Double {
        return double(ELEMENT_BOILING_POINT)
    }
    
    var covalentRadius: Double {
        return double(ELEMENT_COVALENT_RADIUS)
    }
    
    var coefficientOfLinealThermalExpansion: Double {
        return double(ELEMENT_COEFFICIENT_OF_LINEAL_THERMAL_EXPANSION)
    }
    
    var density: Double {
        return double(ELEMENT_DENSITY)
    }
    
    var descr: String? {
        return value(forKeyPath: ELEMENT_DESCR) as? String
    }
    
    var electronConfiguration: [String: AnyObject] {
        return (value(forKeyPath: ELEMENT_ELECTRON_CONFIGURATION) as? [String: AnyObject])!
    }
    
    var group: Int? {
        let aValue = value(forKeyPath: ELEMENT_GROUP) as? String
        return (aValue! == STRING_EMPTY) ? 0: Int(aValue!)
    }
    
    var meltingPoint: Double {
        return double(ELEMENT_MELTING_POINT)
    }
    
    var name: String? {
        return value(forKeyPath: ELEMENT_NAME) as? String
    }
    
    var nuclidesAndIsotopes: [[String: AnyObject]]? {
        return value(forKeyPath: ELEMENT_NUCLIDES_AND_ISOTOPES) as? [[String: AnyObject]]
    }
    
    var period: String? {
        return value(forKeyPath: ELEMENT_PERIOD) as? String
    }
    
    var series: String? {
        return value(forKeyPath: ELEMENT_SERIES) as? String
    }
    
    var symbol: String? {
        return value(forKeyPath: ELEMENT_SYMBOL) as? String
    }
    
    var lineSpectra: [[String: AnyObject]]? {
        return (value(forKeyPath: ELEMENT_LINE_SPECTRA) as? [[String: AnyObject]]?)!
    }
    
    var vaporPressure: [String: AnyObject]? {
        return value(forKeyPath: ELEMENT_VAPOR_PRESSURE) as? [String: AnyObject]
    }
    
    var elasticModulusBulk: Double {
        return double(ELEMENT_ELASTIC_MODULUS_BULK)
    }
    
    var elasticModulusRigidity: Double {
        return double(ELEMENT_ELASTIC_MODULUS_RIGIDITY)
    }
    
    var elasticModulusYoungs: Double {
        return double(ELEMENT_ELASTIC_MODULUS_YOUNGS)
    }
    
    var electroChemicalEquivalent: Double {
        return double(ELEMENT_ELECTRO_CHEMICAL_EQUIVALENT)
    }
    
    var crossSection: Double {
        return double(ELEMENT_CROSS_SECTION)
    }
    
    var electroNegativity: Double {
        return double(ELEMENT_ELECTRO_NEGATIVITY)
    }
    
    var electronWorkFunction: Double {
        return double(ELEMENT_ELECTRON_WORK_FUNCTION)
    }
    
    var enthalpyOfAutomization: Double {
        return double(ELEMENT_ENTHALPY_OF_ATOMIZATION)
    }
    
    var enthalpyOfFusion: Double {
        return double(ELEMENT_ENTHALPY_OF_FUSION)
    }
    
    var enthalpyOfVaporization: Double {
        return double(ELEMENT_ENTHALPY_OF_VAPORIZATION)
    }
    
    var ionicRadius: Double {
        return double(ELEMENT_IONIC_RADIUS)
    }
    
    var hardnessScaleBrinell: Double {
        return double(ELEMENT_HARDNESS_SCALE_BRINELL)
    }
    
    var hardnessScaleMohs: Double {
        return double(ELEMENT_HARDNESS_SCALE_MOHS)
    }
    
    var hardnessScaleVickers: Double {
        return double(ELEMENT_HARDNESS_SCALE_VICKERS)
    }
    
    var heatOfFusion: Double {
        return double(ELEMENT_HEAT_OF_FUSION)
    }
    
    var heatOfVaporization: Double {
        return double(ELEMENT_HEAT_OF_VAPORIZATION)
    }
    
    var ionizationPotentialFirst: Double {
        return double(ELEMENT_IONIZATION_POTENTIAL_FIRST)
    }
    
    var ionizationPotentialSecond: Double {
        return double(ELEMENT_IONIZATION_POTENTIAL_SECOND)
    }
    
    var ionizationPotentialThird: Double {
        return double(ELEMENT_IONIZATION_POTENTIAL_THIRD)
    }
    
    var molarHeatCapacity: Double {
        return double(ELEMENT_MOLAR_HEAT_CAPACITY)
    }
    
    var molarVolume: Double {
        return double(ELEMENT_MOLAR_VOLUME)
    }
    
    var specificHeatCapacity: Double {
        return double(ELEMENT_SPECIFIC_HEAT_CAPACITY)
    }
    
    var valenceElectronPotential: Double {
        return double(ELEMENT_VALENCE_ELECTRON_POTENTIAL)
    }
    
}
