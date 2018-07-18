//
//  XTRGraphViewControllerDelegate.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 6/21/18.
//  Copyright © 2018 xTrensa. All rights reserved.
//

import CorePlot

/*class XTRGraphViewControllerDelegate: NSObject, CPTPlotDataSource, CPTBarPlotDelegate {
    
    var controller: XTRGraphViewController?
    
        @objc func dataForResource(_ aResourceName: String, type: String, directory: String) -> Data {
            var data: Data = Data()
            
            do {
                data = try Data(contentsOf: URL(fileURLWithPath: Bundle(for: classForCoder).path(forResource: aResourceName, ofType: type, inDirectory: directory)!))
            } catch {
            }
            
            return data
        }
    
    // MARK: - Plot Data Source Methods
    
    func numberOfRecords(for plot: CPTPlot) -> UInt {
        return UInt(XTRDataSource.sharedInstance().elementCount())
    }
    
    func number(for plot: CPTPlot, field fieldEnum: UInt, record idx: UInt) -> Any? {
        var num: NSNumber = 0
        
        if plot.isKind(of: CPTBarPlot.classForCoder()) {
            let element = XTRDataSource.sharedInstance().elementAtIndex(Int(idx))
            let identifier = plot.identifier as! String
            
            switch fieldEnum {
            case 0:
                num = NSNumber(value: idx + 1)
            case 1:
                switch identifier {
                case ELEMENT_ATOMIC_MASS :
                    num = NSNumber(value: element.atomicMass)
                case ELEMENT_ATOMIC_RADIUS :
                    num = NSNumber(value: element.atomicRadius)
                case ELEMENT_BOILING_POINT :
                    num = NSNumber(value: element.boilingPoint)
                case ELEMENT_COEFFICIENT_OF_LINEAL_THERMAL_EXPANSION :
                    num = NSNumber(value: element.coeffOfLinealThermExpansScaled)
                case ELEMENT_COVALENT_RADIUS :
                    num = NSNumber(value: element.covalentRadius)
                case ELEMENT_CROSS_SECTION :
                    num = NSNumber(value: element.crossSection)
                case ELEMENT_DENSITY :
                    num = NSNumber(value: element.density)
                case ELEMENT_ELASTIC_MODULUS_BULK :
                    num = NSNumber(value: element.elasticModulusBulk)
                case ELEMENT_ELASTIC_MODULUS_RIGIDITY :
                    num = NSNumber(value: element.elasticModulusRigidity)
                case ELEMENT_ELASTIC_MODULUS_YOUNGS :
                    num = NSNumber(value: element.elasticModulusYoungs)
                case ELEMENT_ELECTRO_CHEMICAL_EQUIVALENT :
                    num = NSNumber(value: element.electroChemicalEquivalent)
                case ELEMENT_ELECTRO_NEGATIVITY :
                    num = NSNumber(value: element.electroNegativity)
                case ELEMENT_ELECTRON_WORK_FUNCTION :
                    num = NSNumber(value: element.electronWorkFunction)
                case ELEMENT_MELTING_POINT :
                    num = NSNumber(value: element.meltingPoint)
                case ELEMENT_ENTHALPY_OF_ATOMIZATION :
                    num = NSNumber(value: element.enthalpyOfAutomization)
                case ELEMENT_ENTHALPY_OF_FUSION :
                    num = NSNumber(value: element.enthalpyOfFusion)
                case ELEMENT_ENTHALPY_OF_VAPORIZATION :
                    num = NSNumber(value: element.enthalpyOfVaporization)
                case ELEMENT_IONIC_RADIUS :
                    num = NSNumber(value: element.ionicRadius)
                case ELEMENT_HARDNESS_SCALE_BRINELL :
                    num = NSNumber(value: element.hardnessScaleBrinell)
                case ELEMENT_HARDNESS_SCALE_MOHS :
                    num = NSNumber(value: element.hardnessScaleMohs)
                case ELEMENT_HARDNESS_SCALE_VICKERS :
                    num = NSNumber(value: element.hardnessScaleVickers)
                case ELEMENT_HEAT_OF_FUSION :
                    num = NSNumber(value: element.heatOfFusion)
                case ELEMENT_HEAT_OF_VAPORIZATION :
                    num = NSNumber(value: element.heatOfVaporization)
                case ELEMENT_IONIZATION_POTENTIAL_FIRST :
                    num = NSNumber(value: element.ionizationPotentialFirst)
                case ELEMENT_IONIZATION_POTENTIAL_SECOND :
                    num = NSNumber(value: element.ionizationPotentialSecond)
                case ELEMENT_IONIZATION_POTENTIAL_THIRD :
                    num = NSNumber(value: element.ionizationPotentialThird)
                case ELEMENT_MOLAR_HEAT_CAPACITY :
                    num = NSNumber(value: element.molarHeatCapacity)
                case ELEMENT_MOLAR_VOLUME :
                    num = NSNumber(value: element.molarVolume)
                case ELEMENT_SPECIFIC_HEAT_CAPACITY :
                    num = NSNumber(value: element.specificHeatCapacity)
                case ELEMENT_VALENCE_ELECTRON_POTENTIAL :
                    num = NSNumber(value: element.valenceElectronPotential)
                default :
                    num = 0
                }
            default:
                num = 0
            }
        }
        
        return num
    }
    
    func barPlot(_ plot: CPTBarPlot, barWasSelectedAtRecord index: UInt) {
        controller?.showElementPanelForElementAtIndex(Int(index))
    }
    
    func barFillForBarPlot(_ barPlot: CPTBarPlot, recordIndex: UInt) -> CPTFill {
        let element = XTRDataSource.sharedInstance().elementAtIndex(Int(recordIndex))
        return CPTFill(color: CPTColor(cgColor: element.seriesColor.cgColor))
    }
}*/
