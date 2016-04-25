//
//  DynoTableLabel.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 4/14/16.
//  Copyright © 2016 xTrensa. All rights reserved.
//

@objc class DynoTableLabel : UILabel {
    private var edgeInsets : UIEdgeInsets?
    
    // MARK: - Initialization Methods
    
    init(frame: CGRect, andColor: UIColor) {
        super.init(frame:frame)
        edgeInsets = UIEdgeInsetsMake(0, 5, 0, 5)
        self.backgroundColor = andColor
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)!
    }
    
    // MARK: - View Management Methods

    override func drawRect(rect: CGRect) {
        super.drawTextInRect(UIEdgeInsetsInsetRect(rect, self.edgeInsets!))
    }
}
