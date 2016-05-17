//
//  DynoTableCell.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 4/14/16.
//  Copyright © 2016 xTrensa. All rights reserved.
//

@objc class DynoTableCell : UITableViewCell {
    private var columns : NSMutableArray
    
    // MARK: - Initialization Methods
    
    required init?(coder aDecoder: NSCoder) {
        self.columns = NSMutableArray.init(capacity: 5)
        super.init(coder:aDecoder)!
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setup()
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        self.columns = NSMutableArray.init(capacity: 5)
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    // MARK: - Internal Methods
    
    func addColumn(position: CGFloat) {
        columns.addObject(position)
    }
    
    func setup() {
        self.backgroundColor = UIColor.blackColor()
        self.contentView.backgroundColor = UIColor.blackColor()
        
        if(columns.count > 0) {
            let ctx : CGContextRef = UIGraphicsGetCurrentContext()!
            
            CGContextSetRGBStrokeColor(ctx, 0.5, 0.5, 0.5, 1.0)
            CGContextSetLineWidth(ctx, 0.25)
            
            for index in 0...columns.count {
                let f : CGFloat = CGFloat(columns[index] as! NSNumber)
                CGContextMoveToPoint(ctx, f, 0)
                CGContextAddLineToPoint(ctx, f, self.bounds.size.height)
            }
            CGContextStrokePath(ctx)
        }
    }
}
