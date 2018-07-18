//
//  XTRSpectrumViewControllerDelegate.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 6/21/18.
//  Copyright © 2018 xTrensa. All rights reserved.
//

import UIKit
import CorePlot

class SpectrumModel: NSObject {
    let xPos: Int
    let yPos: Int
    let width: Int
    let height: Int
    let property: String
    let columnPosition: Int
    let modulus: Int
    let cell: XTRTableCell
    
    init(xPos: Int, yPos: Int, width: Int, height: Int, property: String, columnPosition: Int, modulus: Int, cell: XTRTableCell) {
        self.xPos = xPos
        self.yPos = yPos
        self.width = width
        self.height = height
        self.property = property
        self.columnPosition = columnPosition
        self.modulus = modulus
        self.cell = cell
        super.init()
    }
}
class XTRSpectrumViewControllerDelegate: NSObject, UITableViewDelegate, UITableViewDataSource, CPTPlotDataSource {
    
    weak var controller: XTRSpectrumViewController?
    
    func toUint(signed: Int) -> UInt {
        
        let unsigned = signed >= 0 ?
            UInt(signed) :
            UInt(signed  - Int.min) + UInt(Int.max) + 1
        
        return unsigned
    }
    
    // MARK: - Plot Data Source Methodså
    
    func numberOfRecords(for plot: CPTPlot) -> UInt {
        return toUint(signed: controller!.lineSpectraArray!.value.count)
    }
    
    func number(for plot: CPTPlot, field fieldEnum: UInt, record idx: UInt) -> Any? {
        var num: Float?
        
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
                num = controller?.airWavelengthValue(airWavelength, anIdentifier: identifier, aSpectrum: spectrum!)
            case 1:
                num = controller?.intensityValue(intensity, anIdentifier: identifier, aSpectrum: spectrum!)
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

            tableCellLabel(model: SpectrumModel(xPos: 0, yPos: 0, width: 124, height: 32, property: airWavelength!, columnPosition: 1, modulus: modulus, cell: cell!))
            tableCellLabel(model: SpectrumModel(xPos: 125, yPos: 0, width: 115, height: 32, property: intensity!, columnPosition: 2, modulus: modulus, cell: cell!))
            tableCellLabel(model: SpectrumModel(xPos: 241, yPos: 0, width: 117, height: 32, property: spectrum!, columnPosition: 3, modulus: modulus, cell: cell!))
        }
        
        return cell!
    }
    
    func numberOfSections(in aTableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return controller!.element!.lineSpectra!.value.count
    }
    
    func tableCellLabel(model: SpectrumModel) {
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
