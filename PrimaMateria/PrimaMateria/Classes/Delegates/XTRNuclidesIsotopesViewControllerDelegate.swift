//
//  XTRNuclidesIsotopesViewControllerDelegate.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 6/21/18.
//  Copyright © 2018 xTrensa. All rights reserved.
//

class XTRNuclidesIsotopesViewControllerDelegate : NSObject, UITableViewDelegate, UITableViewDataSource {

    weak var controller : XTRNuclidesIsotopesViewController?

    // MARK:- UITableView DataSource Methods
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        let MyIdentifier = "Column \(row)"
        
        var cell : XTRTableCell? = tableView.dequeueReusableCell(withIdentifier: MyIdentifier) as? XTRTableCell
        
        if cell == nil {
            let modulus = row % 2
            let dict : [String : AnyObject] = (controller?.nuclidesAndIsotopesArray![Int(row)])!
            let nuclideSymbol = dict[ELEMENT_NUCLIDE_SYMBOL] as? String
            let zp : String? = dict[ELEMENT_NUCLIDE_ZP] as? String
            let nn : String? = dict[ELEMENT_NUCLIDE_NN] as? String
            let isotopicMass : String? = dict[ELEMENT_ATOMIC_MASS] as? String
            let halfLife : String? = dict[ELEMENT_NUCLIDE_HALF_LIFE] as? String
            let decayModes : String? = dict[ELEMENT_NUCLIDE_DECAY_MODES] as? String
            let decayEnergy : String? = dict[ELEMENT_NUCLIDE_DECAY_ENERGY] as? String
            let daughterIsotopes : String? = dict[ELEMENT_NUCLIDE_DAUGHTER_ISOTOPES] as? String
            let nuclearSpin : String? = dict[ELEMENT_NUCLIDE_NUCLEAR_SPIN] as? String
            let isotopicComposition : String? = dict[ELEMENT_NUCLIDE_ISOTOPIC_COMPOSITION] as? String
            let naturalRangeVariation : String? = dict[ELEMENT_NUCLIDE_NATURAL_RANGE_VARIATION] as? String
            
            cell = XTRTableCell(style: .default, reuseIdentifier: MyIdentifier)
            
            tableCellLabelWithXPos(0, yPos: 0, aWidth: 63, aHeight: 32, property: (nuclideSymbol != nil) ? nuclideSymbol! : STRING_EMPTY, columnPosition: 1, aModulus: modulus, cell: cell!)
            
            tableCellLabelWithXPos(64, yPos: 0, aWidth: 41, aHeight: 32, property: (zp != nil) ? zp! : STRING_EMPTY, columnPosition: 2, aModulus: modulus, cell: cell!)
            
            tableCellLabelWithXPos(106, yPos: 0, aWidth: 41, aHeight: 32, property: (nn != nil) ? nn! : STRING_EMPTY, columnPosition: 3, aModulus: modulus, cell: cell!)
            
            tableCellLabelWithXPos(148, yPos: 0, aWidth: 124, aHeight: 32, property: (isotopicMass != nil) ? isotopicMass! : STRING_EMPTY, columnPosition: 4, aModulus: modulus, cell: cell!)
            
            tableCellLabelWithXPos(273, yPos: 0, aWidth: 131, aHeight: 32, property: (halfLife != nil) ? halfLife! : STRING_EMPTY, columnPosition: 5, aModulus: modulus, cell: cell!)
            
            tableCellLabelWithXPos(405, yPos: 0, aWidth: 118, aHeight: 32, property: (decayModes != nil) ? decayModes! : STRING_EMPTY, columnPosition: 6, aModulus: modulus, cell: cell!)
            
            tableCellLabelWithXPos(524, yPos: 0, aWidth: 122, aHeight: 32, property: (decayEnergy != nil) ? decayEnergy! : STRING_EMPTY, columnPosition: 7, aModulus: modulus, cell: cell!)
            
            tableCellLabelWithXPos(647, yPos: 0, aWidth: 78, aHeight: 32, property: (daughterIsotopes != nil) ? daughterIsotopes! : STRING_EMPTY, columnPosition: 8, aModulus: modulus, cell: cell!)
            
            tableCellLabelWithXPos(726, yPos: 0, aWidth: 60, aHeight: 32, property: (nuclearSpin != nil) ? nuclearSpin! : STRING_EMPTY, columnPosition: 9, aModulus: modulus, cell: cell!)
            
            tableCellLabelWithXPos(787, yPos: 0, aWidth: 118, aHeight: 32, property: (isotopicComposition != nil) ? isotopicComposition! : STRING_EMPTY, columnPosition: 10, aModulus: modulus, cell: cell!)
            
            tableCellLabelWithXPos(906, yPos: 0, aWidth: 118, aHeight: 32, property: (naturalRangeVariation != nil) ? naturalRangeVariation! : STRING_EMPTY, columnPosition: 11, aModulus: modulus, cell: cell!)
        }
        
        return cell!
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (controller?.element!.nuclidesAndIsotopes)!.count
    }
    
    func tableView(_ aTableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 34
    }
    
    // MARK: - Internal Methods

    func tableCellLabelWithXPos(_ xPos: CGFloat, yPos: CGFloat, aWidth: CGFloat, aHeight: CGFloat, property: String, columnPosition: Int, aModulus: Int, cell: XTRTableCell) {
        let label = UILabel(frame: CGRect(x: xPos, y: yPos, width: aWidth, height: aHeight))
        
        label.backgroundColor = (aModulus == 0) ? UIColor.white : XTRColorFactory.rowColor
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

