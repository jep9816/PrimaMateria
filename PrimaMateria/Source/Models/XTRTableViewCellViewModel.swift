//
//  XTRTableViewCellViewModel.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 7/18/18.
//  Copyright ©2023 xTrensa. All rights reserved.
//

import Foundation

class XTRTableViewCellViewModel: NSObject {
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
