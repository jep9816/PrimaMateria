//
//  XTRNuclidesIsotopesViewControllerDelegate.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 6/21/18.
//  Copyright © 2018 xTrensa. All rights reserved.
//

import UIKit
import RxSwift

class XTRNuclidesIsotopesViewControllerDelegate: NSObject, UITableViewDelegate, UITableViewDataSource {

    weak var controller: XTRNuclidesIsotopesViewController?

    // MARK: - UITableView DataSource Methods
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        let MyIdentifier = "Column \(row)"
        
        var cell: XTRTableCell? = tableView.dequeueReusableCell(withIdentifier: MyIdentifier) as? XTRTableCell
        
        if cell == nil {
            let modulus = row % 2
            let model: XTRIsotopeModel = (controller?.nuclidesAndIsotopesArray?.value[row])!

            cell = XTRTableCell(style: .default, reuseIdentifier: MyIdentifier)
            
            tableCellLabel(0, yPos: 0, aWidth: 63, aHeight: 32, property: model.nuclideSymbol, columnPosition: 1, aModulus: modulus, cell: cell!)
            tableCellLabel(64, yPos: 0, aWidth: 41, aHeight: 32, property: model.zpValue, columnPosition: 2, aModulus: modulus, cell: cell!)
            tableCellLabel(106, yPos: 0, aWidth: 41, aHeight: 32, property: model.nnValue, columnPosition: 3, aModulus: modulus, cell: cell!)
            tableCellLabel(148, yPos: 0, aWidth: 124, aHeight: 32, property: model.isotopicMass, columnPosition: 4, aModulus: modulus, cell: cell!)
            tableCellLabel(273, yPos: 0, aWidth: 131, aHeight: 32, property: model.halfLife, columnPosition: 5, aModulus: modulus, cell: cell!)
            tableCellLabel(405, yPos: 0, aWidth: 118, aHeight: 32, property: model.decayModes, columnPosition: 6, aModulus: modulus, cell: cell!)
            tableCellLabel(524, yPos: 0, aWidth: 122, aHeight: 32, property: model.decayEnergy, columnPosition: 7, aModulus: modulus, cell: cell!)
            tableCellLabel(647, yPos: 0, aWidth: 78, aHeight: 32, property: model.daughterIsotopes, columnPosition: 8, aModulus: modulus, cell: cell!)
            tableCellLabel(726, yPos: 0, aWidth: 60, aHeight: 32, property: model.nuclearSpin, columnPosition: 9, aModulus: modulus, cell: cell!)
            tableCellLabel(787, yPos: 0, aWidth: 118, aHeight: 32, property: model.isotopicComposition, columnPosition: 10, aModulus: modulus, cell: cell!)
            tableCellLabel(906, yPos: 0, aWidth: 118, aHeight: 32, property: model.naturalRangeVariation, columnPosition: 11, aModulus: modulus, cell: cell!)
        }
        
        return cell!
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (controller?.element!.nuclidesAndIsotopes!.value)!.count
    }
    
    func tableView(_ aTableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 34
    }
    
    // MARK: - Internal Methods

    func tableCellLabel(_ xPos: CGFloat, yPos: CGFloat, aWidth: CGFloat, aHeight: CGFloat, property: String, columnPosition: Int, aModulus: Int, cell: XTRTableCell) {
        let label = UILabel(frame: CGRect(x: xPos, y: yPos, width: aWidth, height: aHeight))
        
        label.backgroundColor = (aModulus == 0) ? UIColor.white: XTRColorFactory.rowColor
        label.font = UIFont.systemFont(ofSize: 14.0)
        label.textAlignment = .center
        label.textColor = UIColor.black
        label.text = property
        label.adjustsFontSizeToFitWidth = true
        
        cell.backgroundView?.backgroundColor = UIColor.black
        cell.contentView.backgroundColor = UIColor.black
        cell.addColumn(columnPosition)
        cell.contentView.addSubview(label)
    }
}
