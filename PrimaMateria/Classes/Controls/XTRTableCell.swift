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
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
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
        let counter = columns.count
        
        if counter > 0 {
            let ctx = UIGraphicsGetCurrentContext()!
            
            ctx.setStrokeColor(XTRColorFactoryClassic.grayColor.cgColor)
            ctx.setLineWidth(0.25)
            
            for index in 0...counter {
                let xPos = CGFloat(columns[index])
                ctx.move(to: CGPoint(x: xPos, y: 0))
                ctx.addLine(to: CGPoint(x: xPos, y: bounds.size.height))
            }
            
            ctx.strokePath()
        }
    }
    
}
