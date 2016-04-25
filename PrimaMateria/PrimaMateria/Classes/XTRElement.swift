//
//  XTRElement.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 4/15/16.
//  Copyright © 2016 xTrensa. All rights reserved.
//

@objc class XTRElement : NSObject {
    
    var elementDictionary : NSMutableDictionary? = nil
    
    private func floatForKey(aKey: String) -> NSNumber {
        let aValue : String = self.valueForKey(aKey) as! String
        var result : CGFloat? = 0
        if let doubleValue = Double(aValue) {
            result = CGFloat(doubleValue)
        }
        return result!
    }
    
    override func valueForKey(aKey: String) -> AnyObject {
        if (aKey == ELEMENT_KSHELL_ELECTRONS) {
            return self.kShellElectrons()
        } else if (aKey == ELEMENT_LSHELL_ELECTRONS) {
            return self.lShellElectrons()
        } else if (aKey == ELEMENT_MSHELL_ELECTRONS) {
            return self.mShellElectrons()
        } else if (aKey == ELEMENT_NSHELL_ELECTRONS) {
            return self.nShellElectrons()
        } else if (aKey == ELEMENT_OSHELL_ELECTRONS) {
            return self.oShellElectrons()
        } else if (aKey == ELEMENT_PSHELL_ELECTRONS) {
            return self.pShellElectrons()
        } else if (aKey == ELEMENT_QSHELL_ELECTRONS) {
            return self.qShellElectrons()
        } else if (aKey == ELEMENT_ATOMIC_MASS_AGGREGATE) {
            return self.atomicMassAggregate()!
        } else {
            let aValue = self.elementDictionary!.valueForKey(aKey)
            return (aValue != nil) ? aValue! : ""
        }
    }
    
    override func setValue(value: AnyObject?, forKeyPath keyPath: String) {
        self.elementDictionary![keyPath] = value
    }
        
    func atomicNumber() -> NSNumber {
        let aValue : NSNumber? = self.valueForKey(ELEMENT_ATOMIC_NUMBER) as? NSNumber
        return aValue!
    }
    
    func atomicRadius() -> NSNumber {
        return self.floatForKey(ELEMENT_ATOMIC_RADIUS)
    }
    
    func atomicMass() -> NSNumber {
        return self.floatForKey(ELEMENT_ATOMIC_MASS)
    }
    
    func atomicVolume() -> NSNumber {
        return self.floatForKey(ELEMENT_ATOMIC_VOLUME)
    }
    
    func boilingPoint() -> NSNumber {
        return self.floatForKey(ELEMENT_BOILING_POINT)
    }
    
    func covalentRadius() -> NSNumber {
        return self.floatForKey(ELEMENT_COVALENT_RADIUS)
    }
    
    func coefficientOfLinealThermalExpansion() -> NSNumber {
        return self.floatForKey(ELEMENT_COEFFICIENT_OF_LINEAL_THERMAL_EXPANSION)
    }
    
    func density() -> NSNumber {
        return self.floatForKey(ELEMENT_DENSITY)
    }
    
    func descr() -> String? {
        return self.valueForKey(ELEMENT_DESCR) as? String
    }
    
    func electronConfiguration() -> NSDictionary? {
        return self.valueForKey(ELEMENT_ELECTRON_CONFIGURATION) as? NSDictionary
    }
    
    func group() -> NSNumber? {
        let aValue : String? = self.valueForKey(ELEMENT_GROUP) as? String
        return (aValue == STRING_EMPTY) ? 0 : Int(aValue!)
    }
    
    func meltingPoint() -> NSNumber {
        return self.floatForKey(ELEMENT_MELTING_POINT)
    }
    
    func name() -> String? {
        return self.valueForKey(ELEMENT_NAME) as? String
    }
    
    func nuclidesAndIsotopes() -> NSArray? {
        return self.valueForKey(ELEMENT_NUCLIDESANDISOTOPES) as? NSArray
    }
    
    func period() -> NSNumber? {
        let aValue : String = self.valueForKey(ELEMENT_PERIOD) as! String
        return Int(aValue)
    }
    
    func series() -> String? {
        return self.valueForKey(ELEMENT_SERIES) as? String
    }
    
    func symbol() -> String? {
        return self.valueForKey(ELEMENT_SYMBOL) as? String
    }
    
    func lineSpectra() -> NSArray? {
        return self.valueForKey(ELEMENT_LINE_SPECTRA) as? NSArray
    }
    
    func vaporPressure() -> NSDictionary? {
        return self.valueForKey(ELEMENT_VAPOR_PRESSURE) as? NSDictionary
    }
    
    func elasticModulusBulk() -> NSNumber {
        return self.floatForKey(ELEMENT_ELASTIC_MODULUS_BULK)
    }
    
    func elasticModulusRigidity() -> NSNumber {
        return self.floatForKey(ELEMENT_ELASTIC_MODULUS_RIGIDITY)
    }
    
    func elasticModulusYoungs() -> NSNumber {
        return self.floatForKey(ELEMENT_ELASTIC_MODULUS_YOUNGS)
    }
    
    func electroChemicalEquivalent() -> NSNumber {
        return self.floatForKey(ELEMENT_ELECTRO_CHEMICAL_EQUIVALENT)
    }
    
    func crossSection() -> NSNumber {
        return self.floatForKey(ELEMENT_CROSS_SECTION)
    }
    
    func electroNegativity() -> NSNumber {
        return self.floatForKey(ELEMENT_ELECTRO_NEGATIVITY)
    }
    
    func electronWorkFunction() -> NSNumber {
        return self.floatForKey(ELEMENT_ELECTRON_WORK_FUNCTION)
    }
    
    func enthalpyOfAutomization() -> NSNumber {
        return self.floatForKey(ELEMENT_ENTHALPY_OF_ATOMIZATION)
    }
    
    func enthalpyOfFusion() -> NSNumber {
        return self.floatForKey(ELEMENT_ENTHALPY_OF_FUSION)
    }
    
    func enthalpyOfVaporization() -> NSNumber {
        return self.floatForKey(ELEMENT_ENTHALPY_OF_VAPORIZATION)
    }
    
    func ionicRadius() -> NSNumber {
        return self.floatForKey(ELEMENT_IONIC_RADIUS)
    }
    
    func hardnessScaleBrinell() -> NSNumber {
        return self.floatForKey(ELEMENT_HARDNESS_SCALE_BRINELL)
    }
    
    func hardnessScaleMohs() -> NSNumber {
        return self.floatForKey(ELEMENT_HARDNESS_SCALE_MOHS)
    }
    
    func hardnessScaleVickers() -> NSNumber {
        return self.floatForKey(ELEMENT_HARDNESS_SCALE_VICKERS)
    }
    
    func heatOfFusion() -> NSNumber {
        return self.floatForKey(ELEMENT_HEAT_OF_FUSION)
    }
    
    func heatOfVaporization() -> NSNumber? {
        return self.floatForKey(ELEMENT_HEAT_OF_VAPORIZATION)
    }
    
    func ionizationPotentialFirst() -> NSNumber {
        return self.floatForKey(ELEMENT_IONIZATION_POTENTIAL_FIRST)
    }
    
    func ionizationPotentialSecond() -> NSNumber {
        return self.floatForKey(ELEMENT_IONIZATION_POTENTIAL_SECOND)
    }
    
    func ionizationPotentialThird() -> NSNumber {
        return self.floatForKey(ELEMENT_IONIZATION_POTENTIAL_THIRD)
    }
    
    func molarHeatCapacity() -> NSNumber {
        return self.floatForKey(ELEMENT_MOLAR_HEAT_CAPACITY)
    }
    
    func molarVolume() -> NSNumber {
        return self.floatForKey(ELEMENT_MOLAR_VOLUME)
    }
    
    func specificHeatCapacity() -> NSNumber {
        return self.floatForKey(ELEMENT_SPECIFIC_HEAT_CAPACITY)
    }
    
    func valenceElectronPotential() -> NSNumber {
        return self.floatForKey(ELEMENT_VALENCE_ELECTRON_POTENTIAL)
    }
}
