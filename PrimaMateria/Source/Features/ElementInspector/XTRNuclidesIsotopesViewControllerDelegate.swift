//
//  XTRNuclidesIsotopesViewControllerDelegate.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 6/21/18.
//  Copyright ©2023 xTrensa. All rights reserved.
//

import UIKit
import RxSwift

class XTRNuclidesIsotopesViewControllerDelegate: NSObject {

    weak var controller: XTRNuclidesIsotopesViewController?

    // MARK: - Internal Methods

    func createTableCellLabel(model: XTRTableViewCellViewModel) {
        let label = UILabel(frame: CGRect(x: model.xPos, y: model.yPos, width: model.width, height: model.height))

        label.backgroundColor = (model.modulus == 0) ? UIColor.white: XTRColorFactory.rowColor
        label.font = XTRFontFactory.systemFont14
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
