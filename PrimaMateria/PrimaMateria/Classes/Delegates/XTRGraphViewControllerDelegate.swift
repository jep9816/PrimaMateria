//
//  File.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 6/21/18.
//  Copyright © 2018 xTrensa. All rights reserved.
//

class XTRGraphViewControllerDelegate : NSObject, CPTPlotDataSource, CPTBarPlotDelegate {

    var closure : (Int) -> Void? = { index in return }

    // MARK: - Plot Data Source Methods

    @objc func numberOfRecords(for plot: CPTPlot) -> UInt {
        return UInt(XTRDataSource.sharedInstance().elementCount())
    }
    
    @objc func number(for plot: CPTPlot, field fieldEnum: UInt, record idx: UInt) -> Any? {
        var num : NSNumber = 0
        
        if plot.isKind(of: CPTBarPlot.classForCoder()) {
            let element = XTRDataSource.sharedInstance().elementAtIndex(Int(idx))
            let identifier = plot.identifier as! String
            
            switch (fieldEnum) {
            case 0:
                num = NSNumber(value: idx + 1)
            case 1:
                if identifier == ELEMENT_ATOMIC_MASS {
                    num = NSNumber(value: element.atomicMass)
                } else if identifier == ELEMENT_ATOMIC_RADIUS {
                    num = NSNumber(value: element.atomicRadius)
                } else if identifier == ELEMENT_BOILING_POINT {
                    num = NSNumber(value: element.boilingPoint)
                } else if identifier == ELEMENT_COEFFICIENT_OF_LINEAL_THERMAL_EXPANSION {
                    num = NSNumber(value: element.coefficientOfLinealThermalExpansionScaled)
                } else if identifier == ELEMENT_COVALENT_RADIUS {
                    num = NSNumber(value: element.covalentRadius)
                } else if identifier == ELEMENT_CROSS_SECTION {
                    num = NSNumber(value: element.crossSection)
                } else if identifier == ELEMENT_DENSITY {
                    num = NSNumber(value: element.density)
                } else if identifier == ELEMENT_ELASTIC_MODULUS_BULK {
                    num = NSNumber(value: element.elasticModulusBulk)
                } else if identifier == ELEMENT_ELASTIC_MODULUS_RIGIDITY {
                    num = NSNumber(value: element.elasticModulusRigidity)
                } else if identifier == ELEMENT_ELASTIC_MODULUS_YOUNGS {
                    num = NSNumber(value: element.elasticModulusYoungs)
                } else if identifier == ELEMENT_ELECTRO_CHEMICAL_EQUIVALENT {
                    num = NSNumber(value: element.electroChemicalEquivalent)
                } else if identifier == ELEMENT_ELECTRO_NEGATIVITY {
                    num = NSNumber(value: element.electroNegativity)
                } else if identifier == ELEMENT_ELECTRON_WORK_FUNCTION {
                    num = NSNumber(value: element.electronWorkFunction)
                } else if identifier == ELEMENT_MELTING_POINT {
                    num = NSNumber(value: element.meltingPoint)
                } else if identifier == ELEMENT_ENTHALPY_OF_ATOMIZATION {
                    num = NSNumber(value: element.enthalpyOfAutomization)
                } else if identifier == ELEMENT_ENTHALPY_OF_FUSION {
                    num = NSNumber(value: element.enthalpyOfFusion)
                } else if identifier == ELEMENT_ENTHALPY_OF_VAPORIZATION {
                    num = NSNumber(value: element.enthalpyOfVaporization)
                } else if identifier == ELEMENT_IONIC_RADIUS {
                    num = NSNumber(value: element.ionicRadius)
                } else if identifier == ELEMENT_HARDNESS_SCALE_BRINELL {
                    num = NSNumber(value: element.hardnessScaleBrinell)
                } else if identifier == ELEMENT_HARDNESS_SCALE_MOHS {
                    num = NSNumber(value: element.hardnessScaleMohs)
                } else if identifier == ELEMENT_HARDNESS_SCALE_VICKERS {
                    num = NSNumber(value: element.hardnessScaleVickers)
                } else if identifier == ELEMENT_HEAT_OF_FUSION {
                    num = NSNumber(value: element.heatOfFusion)
                } else if identifier == ELEMENT_HEAT_OF_VAPORIZATION {
                    num = NSNumber(value: element.heatOfVaporization)
                } else if identifier == ELEMENT_IONIZATION_POTENTIAL_FIRST {
                    num = NSNumber(value: element.ionizationPotentialFirst)
                } else if identifier == ELEMENT_IONIZATION_POTENTIAL_SECOND {
                    num = NSNumber(value: element.ionizationPotentialSecond)
                } else if identifier == ELEMENT_IONIZATION_POTENTIAL_THIRD {
                    num = NSNumber(value: element.ionizationPotentialThird)
                } else if identifier == ELEMENT_MOLAR_HEAT_CAPACITY {
                    num = NSNumber(value: element.molarHeatCapacity)
                } else if identifier == ELEMENT_MOLAR_VOLUME {
                    num = NSNumber(value: element.molarVolume)
                } else if identifier == ELEMENT_SPECIFIC_HEAT_CAPACITY {
                    num = NSNumber(value: element.specificHeatCapacity)
                } else if identifier == ELEMENT_VALENCE_ELECTRON_POTENTIAL {
                    num = NSNumber(value: element.valenceElectronPotential)
                } else {
                    num = 0
                }
            default:
                num = 0
                break
            }
        }
        
        return num
    }
    
    @objc func barPlot(_ plot: CPTBarPlot, barWasSelectedAtRecord index: UInt) {
        self.closure(Int(index))
    }
    
    @objc func barFillForBarPlot(_ barPlot: CPTBarPlot, recordIndex: UInt) -> CPTFill {
        let element = XTRDataSource.sharedInstance().elementAtIndex(Int(recordIndex))
        return CPTFill(color: CPTColor(cgColor: element.seriesColor.cgColor))
    }

}

