//
//  XTRNuclidesIsotopesViewControllerDelegate.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 6/21/18.
//  Copyright © 2018 xTrensa. All rights reserved.
//

import UIKit
import RxSwift

class NuclidesIsotopesModel: NSObject {
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
            
            tableCellLabel(model: NuclidesIsotopesModel(xPos: 0, yPos: 0, width: 63, height: 32, property: model.nuclideSymbol, columnPosition: 1, modulus: modulus, cell: cell!))
            tableCellLabel(model: NuclidesIsotopesModel(xPos: 64, yPos: 0, width: 41, height: 32, property: model.zpValue, columnPosition: 2, modulus: modulus, cell: cell!))
            tableCellLabel(model: NuclidesIsotopesModel(xPos: 106, yPos: 0, width: 41, height: 32, property: model.nnValue, columnPosition: 3, modulus: modulus, cell: cell!))
            tableCellLabel(model: NuclidesIsotopesModel(xPos: 148, yPos: 0, width: 124, height: 32, property: model.isotopicMass, columnPosition: 4, modulus: modulus, cell: cell!))
            tableCellLabel(model: NuclidesIsotopesModel(xPos: 273, yPos: 0, width: 131, height: 32, property: model.halfLife, columnPosition: 5, modulus: modulus, cell: cell!))
            tableCellLabel(model: NuclidesIsotopesModel(xPos: 405, yPos: 0, width: 118, height: 32, property: model.decayModes, columnPosition: 6, modulus: modulus, cell: cell!))
            tableCellLabel(model: NuclidesIsotopesModel(xPos: 524, yPos: 0, width: 122, height: 32, property: model.decayEnergy, columnPosition: 7, modulus: modulus, cell: cell!))
            tableCellLabel(model: NuclidesIsotopesModel(xPos: 647, yPos: 0, width: 78, height: 32, property: model.daughterIsotopes, columnPosition: 8, modulus: modulus, cell: cell!))
            tableCellLabel(model: NuclidesIsotopesModel(xPos: 726, yPos: 0, width: 60, height: 32, property: model.nuclearSpin, columnPosition: 9, modulus: modulus, cell: cell!))
            tableCellLabel(model: NuclidesIsotopesModel(xPos: 787, yPos: 0, width: 118, height: 32, property: model.isotopicComposition, columnPosition: 10, modulus: modulus, cell: cell!))
            tableCellLabel(model: NuclidesIsotopesModel(xPos: 906, yPos: 0, width: 118, height: 32, property: model.naturalRangeVariation, columnPosition: 11, modulus: modulus, cell: cell!))
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

    func tableCellLabel(model: NuclidesIsotopesModel) {
        let label = UILabel(frame: CGRect(x: model.xPos, y: model.yPos, width: model.width, height: model.height))
        
        label.backgroundColor = (model.modulus == 0) ? UIColor.white: XTRColorFactory.rowColor
        label.font = UIFont.systemFont(ofSize: 14.0)
        label.textAlignment = .center
        label.textColor = UIColor.black
        label.text = model.property
        label.adjustsFontSizeToFitWidth = true
        
        model.cell.backgroundView?.backgroundColor = UIColor.black
        model.cell.contentView.backgroundColor = UIColor.black
        model.cell.addColumn(model.columnPosition)
        model.cell.contentView.addSubview(label)
    }
}
