//
//  XTRElement.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 4/15/16.
//  Copyright ©2018 xTrensa. All rights reserved.
//

import UIKit

class XTRElement : NSObject {
    
    var elementDictionary : [String: Any] = [:]
    
    private func floatForKey(_ aKey: String?) -> Float {
        var floatValue : Float = 0.0
        
        if let floatString = value(forKeyPath: aKey!) as! String?  {
            if let floatNumber = NumberFormatter().number(from: floatString) {
                floatValue = floatNumber.floatValue
            }
        }
        
        return floatValue
    }

    override func value(forKeyPath keyPath: String) -> Any? {
        if keyPath == ELEMENT_KSHELL_ELECTRONS {
            return kShellElectrons as AnyObject
        } else if keyPath == ELEMENT_LSHELL_ELECTRONS {
            return lShellElectrons as AnyObject
        } else if keyPath == ELEMENT_MSHELL_ELECTRONS {
            return mShellElectrons as AnyObject
        } else if keyPath == ELEMENT_NSHELL_ELECTRONS {
            return nShellElectrons as AnyObject
        } else if keyPath == ELEMENT_OSHELL_ELECTRONS {
            return oShellElectrons as AnyObject
        } else if keyPath == ELEMENT_PSHELL_ELECTRONS {
            return pShellElectrons as AnyObject
        } else if keyPath == ELEMENT_QSHELL_ELECTRONS {
            return qShellElectrons as AnyObject
        } else if keyPath == ELEMENT_ATOMIC_MASS_AGGREGATE {
            return atomicMassAggregate as AnyObject
        } else {
            let aValue = elementDictionary[keyPath]
            return (aValue != nil) ? aValue! as AnyObject : "" as AnyObject
        }
    }
    
    override func setValue(_ value: Any?, forKeyPath keyPath: String) {
        elementDictionary[keyPath] = value
    }
        
    var atomicNumber: Int {
        return value(forKeyPath: ELEMENT_ATOMIC_NUMBER) as! Int
    }
    
    var atomicRadius: Float {
        return floatForKey(ELEMENT_ATOMIC_RADIUS)
    }
    
    var atomicMass: Float {
        return floatForKey(ELEMENT_ATOMIC_MASS)
    }
    
    var atomicVolume: Float {
        return floatForKey(ELEMENT_ATOMIC_VOLUME)
    }
    
    var boilingPoint: Float {
        return floatForKey(ELEMENT_BOILING_POINT)
    }
    
    var covalentRadius: Float {
        return floatForKey(ELEMENT_COVALENT_RADIUS)
    }
    
    var coefficientOfLinealThermalExpansion: Float {
        return floatForKey(ELEMENT_COEFFICIENT_OF_LINEAL_THERMAL_EXPANSION)
    }
    
    var density: Float {
        return floatForKey(ELEMENT_DENSITY)
    }
    
    var descr: String? {
        return value(forKeyPath: ELEMENT_DESCR) as? String
    }
    
    var electronConfiguration: [String : AnyObject]? {
        return value(forKeyPath: ELEMENT_ELECTRON_CONFIGURATION) as? [String : AnyObject]
    }
    
    var group: Int? {
        get {
            let aValue : String? = value(forKeyPath: ELEMENT_GROUP) as? String
            return (aValue! == STRING_EMPTY) ? 0 : Int(aValue!)
        }
    }
    
    var meltingPoint: Float {
        return floatForKey(ELEMENT_MELTING_POINT)
    }
    
    var name: String? {
        return value(forKeyPath: ELEMENT_NAME) as? String
    }
    
    var nuclidesAndIsotopes: [AnyObject]? {
        return value(forKeyPath: ELEMENT_NUCLIDES_AND_ISOTOPES) as? [AnyObject]
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
    
    var lineSpectra: [[String : AnyObject]]? {
        return value(forKeyPath: ELEMENT_LINE_SPECTRA) as! [[String : AnyObject]]?
    }
    
    var vaporPressure: [String : AnyObject]? {
        return value(forKeyPath: ELEMENT_VAPOR_PRESSURE) as? [String : AnyObject]
    }
    
    var elasticModulusBulk: Float {
        return floatForKey(ELEMENT_ELASTIC_MODULUS_BULK)
    }
    
    var elasticModulusRigidity: Float {
        return floatForKey(ELEMENT_ELASTIC_MODULUS_RIGIDITY)
    }
    
    var elasticModulusYoungs: Float {
        return floatForKey(ELEMENT_ELASTIC_MODULUS_YOUNGS)
    }
    
    var electroChemicalEquivalent: Float {
        return floatForKey(ELEMENT_ELECTRO_CHEMICAL_EQUIVALENT)
    }
    
    var crossSection: Float {
        return floatForKey(ELEMENT_CROSS_SECTION)
    }
    
    var electroNegativity: Float {
        return floatForKey(ELEMENT_ELECTRO_NEGATIVITY)
    }
    
    var electronWorkFunction: Float {
        return floatForKey(ELEMENT_ELECTRON_WORK_FUNCTION)
    }
    
    var enthalpyOfAutomization: Float {
        return floatForKey(ELEMENT_ENTHALPY_OF_ATOMIZATION)
    }
    
    var enthalpyOfFusion: Float {
        return floatForKey(ELEMENT_ENTHALPY_OF_FUSION)
    }
    
    var enthalpyOfVaporization: Float {
        return floatForKey(ELEMENT_ENTHALPY_OF_VAPORIZATION)
    }
    
    var ionicRadius: Float {
        return floatForKey(ELEMENT_IONIC_RADIUS)
    }
    
    var hardnessScaleBrinell: Float {
        return floatForKey(ELEMENT_HARDNESS_SCALE_BRINELL)
    }
    
    var hardnessScaleMohs: Float {
        return floatForKey(ELEMENT_HARDNESS_SCALE_MOHS)
    }
    
    var hardnessScaleVickers: Float {
        return floatForKey(ELEMENT_HARDNESS_SCALE_VICKERS)
    }
    
    var heatOfFusion: Float {
        return floatForKey(ELEMENT_HEAT_OF_FUSION)
    }
    
    var heatOfVaporization: Float {
        return floatForKey(ELEMENT_HEAT_OF_VAPORIZATION)
    }
    
    var ionizationPotentialFirst: Float {
        return floatForKey(ELEMENT_IONIZATION_POTENTIAL_FIRST)
    }
    
    var ionizationPotentialSecond: Float {
        return floatForKey(ELEMENT_IONIZATION_POTENTIAL_SECOND)
    }
    
    var ionizationPotentialThird: Float {
        return floatForKey(ELEMENT_IONIZATION_POTENTIAL_THIRD)
    }
    
    var molarHeatCapacity: Float {
        return floatForKey(ELEMENT_MOLAR_HEAT_CAPACITY)
    }
    
    var molarVolume: Float {
        return floatForKey(ELEMENT_MOLAR_VOLUME)
    }
    
    var specificHeatCapacity: Float {
        return floatForKey(ELEMENT_SPECIFIC_HEAT_CAPACITY)
    }
    
    var valenceElectronPotential: Float {
        return floatForKey(ELEMENT_VALENCE_ELECTRON_POTENTIAL)
    }
    
}
