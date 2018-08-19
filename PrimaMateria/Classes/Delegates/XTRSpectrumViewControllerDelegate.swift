//
//  XTRSpectrumViewControllerDelegate.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 6/21/18.
//  Copyright © 2018 xTrensa. All rights reserved.
//

import UIKit
import CorePlot

class XTRSpectrumViewControllerDelegate: NSObject, UITableViewDelegate, UITableViewDataSource, CPTPlotDataSource {
    
    weak var controller: XTRSpectrumViewController?
        
    // MARK: - Plot Data Source Methodså
    
    func numberOfRecords(for plot: CPTPlot) -> UInt {
        return NSObject.toUint(signed: controller!.lineSpectraArray!.value.count)
    }
    
    func number(for plot: CPTPlot, field fieldEnum: UInt, record idx: UInt) -> Any? {
        var num: Float = 0
        
        if plot.isKind(of: CPTBarPlot.classForCoder()) {
            let model = controller?.lineSpectraArray!.value[Int(idx)]
            var airWavelength: Float = 0.0
            var intensity: Float = 0.0
            let spectrum = model?.spectrum
            let identifier = plot.identifier as! String

            if let value1 = model?.airWavelength {
                airWavelength = Float(value1)!
            }
            if let value2 = model?.intensity {
                intensity = Float(value2)!
            }

            switch fieldEnum {
            case 0:
                num = (controller?.airWavelengthValue(airWavelength, anIdentifier: identifier, aSpectrum: spectrum!))!
            case 1:
                num = (controller?.intensityValue(intensity, anIdentifier: identifier, aSpectrum: spectrum!))!
            default:
                num = 0
            }
        }
        return num
    }
    
    func barFillForBarPlot(_ barPlot: CPTBarPlot, recordIndex: NSInteger) -> CPTFill? {
        return nil
    }
    
    func tableView(_ aTableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        let MyIdentifier = "Column \(row)"
        
        var cell: XTRTableCell? = aTableView.dequeueReusableCell(withIdentifier: MyIdentifier) as? XTRTableCell
        
        if cell == nil {
            let modulus = row % 2
            let model = controller?.lineSpectraArray!.value[row]
            let airWavelength = model?.airWavelength
            let intensity = model?.intensity
            let spectrum = model?.spectrum
            
            cell = XTRTableCell(style: .default, reuseIdentifier: MyIdentifier)

            createTableCellLabel(model: XTRTableViewCellViewModel(xPos: 0, yPos: 0, width: 124, height: 32, property: airWavelength!, columnPosition: 1, modulus: modulus, cell: cell!))
            createTableCellLabel(model: XTRTableViewCellViewModel(xPos: 125, yPos: 0, width: 115, height: 32, property: intensity!, columnPosition: 2, modulus: modulus, cell: cell!))
            createTableCellLabel(model: XTRTableViewCellViewModel(xPos: 241, yPos: 0, width: 117, height: 32, property: spectrum!, columnPosition: 3, modulus: modulus, cell: cell!))
        }
        
        return cell!
    }
    
    func numberOfSections(in aTableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return controller!.element!.lineSpectraModels!.value.count
    }
    
    func createTableCellLabel(model: XTRTableViewCellViewModel) {
        let label = UILabel(frame: CGRect(x: model.xPos, y: model.yPos, width: model.width, height: model.height))
        
        label.backgroundColor = (model.modulus == 0) ? UIColor.white: XTRColorFactory.rowColor
        
        model.cell.backgroundView?.backgroundColor = UIColor.black
        model.cell.contentView.backgroundColor = UIColor.black
        model.cell.addColumn(model.columnPosition)
        label.font = UIFont.systemFont(ofSize: 20.0)
        label.textAlignment = .center
        label.textColor = UIColor.black
        label.text = " \(model.property)"
        model.cell.contentView.addSubview(label)
    }
    
}
