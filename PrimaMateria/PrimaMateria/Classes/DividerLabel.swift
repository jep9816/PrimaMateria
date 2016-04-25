//
//  DividerLabel.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 4/14/16.
//  Copyright © 2016 xTrensa. All rights reserved.
//

@objc class DividerLabel : UILabel {
    var highColor : UIColor?
    var lowColor : UIColor?
    
    // MARK: - Initialization Methods
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)!
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.createLayer()
    }
    
    // MARK: - Internal Methods
    
    func createLayer() {
        self.layer.masksToBounds = true
        self.setupColors()
    }
    
    func setupColors() {
        self.textColor = UIColor.whiteColor()
        self.setHigh_Color(UIColor.lightGrayColor())
        self.setLow_Color(UIColor.grayColor())
    }
    
    func setHigh_Color(color: UIColor) {
        self.highColor = color
        self.layer.setNeedsDisplay()
    }
    
    func setLow_Color(color: UIColor) {
        self.lowColor = color
        self.layer.setNeedsDisplay()
    }
}
