//
//  XTRSpectrumViewControllerDelegate.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 6/21/18.
//  Copyright © 2018 xTrensa. All rights reserved.
//

import UIKit

class XTRSpectrumViewControllerDelegate : NSObject, UITableViewDelegate, UITableViewDataSource, CPTPlotDataSource {
    
    weak var controller : XTRSpectrumViewController?
    
    func toUint(signed: Int) -> UInt {
        
        let unsigned = signed >= 0 ?
            UInt(signed) :
            UInt(signed  - Int.min) + UInt(Int.max) + 1
        
        return unsigned
    }
    
    // MARK: - Plot Data Source Methodså
    
    func numberOfRecords(for plot: CPTPlot) -> UInt {
        return toUint(signed: (controller?.lineSpectraArray!.count)!)
    }
    
    func number(for plot: CPTPlot, field fieldEnum: UInt, record idx: UInt) -> Any? {
        var num : Float?
        
        if plot.isKind(of: CPTBarPlot.classForCoder()) {
            let dict = controller?.lineSpectraArray![Int(idx)]
            let airWavelength = Float(dict![SpectrumAttribute.kAirWavelength] as! String)!
            let intensity = Float(dict![SpectrumAttribute.kIntensity] as! String)!
            let spectrum = dict![SpectrumAttribute.kSpectrum] as! String
            let identifier = plot.identifier as! String
            
            switch (fieldEnum) {
            case 0:
                num = controller?.airWavelengthValue(airWavelength, anIdentifier: identifier, aSpectrum: spectrum)
            case 1:
                num = controller?.intensityValue(intensity, anIdentifier: identifier, aSpectrum: spectrum)
            default:
                num = 0
                break
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
        
        var cell : XTRTableCell? = aTableView.dequeueReusableCell(withIdentifier: MyIdentifier) as? XTRTableCell
        
        if cell == nil {
            let modulus = row % 2
            let dict = controller?.lineSpectraArray![row]
            let airWavelength = dict![SpectrumAttribute.kAirWavelength] as! String
            let intensity = dict![SpectrumAttribute.kIntensity] as! String
            let spectrum = dict![SpectrumAttribute.kSpectrum] as! String
            
            cell = XTRTableCell(style: .default, reuseIdentifier: MyIdentifier)
            
            tableCellLabelWithXPos(0.0, YPos: 0.0, width: 124.0, height: 32.0, property: airWavelength, columnPosition: 1, modulus: modulus, cell: cell!)
            tableCellLabelWithXPos(125.0, YPos: 0.0, width: 115.0, height: 32.0, property: intensity, columnPosition: 2, modulus: modulus, cell: cell!)
            tableCellLabelWithXPos(241.0, YPos: 0.0, width: 117.0, height: 32.0, property: spectrum, columnPosition: 3, modulus: modulus, cell: cell!)
        }
        
        return cell!
    }
    
    func numberOfSections(in aTableView : UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (controller?.element!.lineSpectra!.count)!
    }
    
    func tableCellLabelWithXPos(_ xPos : CGFloat, YPos: CGFloat, width: CGFloat, height: CGFloat, property: String, columnPosition: Int, modulus: Int, cell: XTRTableCell) {
        let label = UILabel(frame: CGRect(x: xPos, y: YPos, width: width, height: height))
        
        label.backgroundColor = (modulus == 0) ? UIColor.white : XTRColorFactory.rowColor
        
        cell.backgroundView?.backgroundColor = UIColor.black
        cell.contentView.backgroundColor = UIColor.black
        cell.addColumn(columnPosition)
        label.font = UIFont.systemFont(ofSize: 20.0)
        label.textAlignment = .center
        label.textColor = UIColor.black
        label.text = " \(property)"
        cell.contentView.addSubview(label)
    }
    
}