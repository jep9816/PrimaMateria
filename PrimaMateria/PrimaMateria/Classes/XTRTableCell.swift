//
//  XTRTableCell.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 4/14/16.
//  Copyright ©2018 xTrensa. All rights reserved.
//

class XTRTableCell : UITableViewCell {
    
    private var columns : [Int]
    
    // MARK: - Initialization Methods
    
    required init?(coder aDecoder: NSCoder) {
        columns = []
        super.init(coder:aDecoder)!
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
        
        if columns.count > 0 {
            let ctx = UIGraphicsGetCurrentContext()!
            
            ctx.setStrokeColor(UIColor.color(hexString: "808080").cgColor)
            ctx.setLineWidth(0.25)
            
            for index in 0...columns.count {
                let f = CGFloat(columns[index])
                ctx.move(to: CGPoint(x: f, y: 0))
                ctx.addLine(to: CGPoint(x: f, y: bounds.size.height))
            }
            
            ctx.strokePath()
        }
    }
    
}
