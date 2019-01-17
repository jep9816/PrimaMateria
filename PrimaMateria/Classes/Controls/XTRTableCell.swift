//
//  XTRTableCell.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 4/14/16.
//  Copyright © 2018 xTrensa. All rights reserved.
//

import UIKit

class XTRTableCell: UITableViewCell {
    
    private var columns: [Int]
    
    // MARK: - Initialization Methods
    
    required init?(coder aDecoder: NSCoder) {
        columns = []
        super.init(coder: aDecoder)!
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        columns = []
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    // MARK: - Internal Methods
    
    func addColumn(_ position: Int) {
        columns.append(position)
    }
    
    func setup() {
        backgroundColor = UIColor.black
        contentView.backgroundColor = UIColor.black
        
        if !columns.isEmpty {
            let ctx = UIGraphicsGetCurrentContext()!
            
            ctx.setStrokeColor(XTRColorFactoryClassic.grayColor.cgColor)
            ctx.setLineWidth(0.25)
            
            for column in columns {
                ctx.move(to: CGPoint(x: column, y: 0))
                ctx.addLine(to: CGPoint(x: column, y: Int(bounds.size.height)))
            }
            
            ctx.strokePath()
        }
    }
    
}
