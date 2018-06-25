//
//  XTRDividerLabel.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 4/14/16.
//  Copyright © 2018 xTrensa. All rights reserved.
//

class XTRDividerLabel : UILabel {
    
    var highColor : UIColor?
    var lowColor : UIColor?
    
    // MARK: - Initialization Methods
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)!
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        createLayer()
    }
    
    // MARK: - Internal Methods
    
    func createLayer() {
        layer.masksToBounds = true
        setupColors()
    }
    
    func setupColors() {
        textColor = UIColor.white
        setHigh_Color(UIColor.lightGray)
        setLow_Color(UIColor.gray)
    }
    
    func setHigh_Color(_ color: UIColor) {
        highColor = color
        layer.setNeedsDisplay()
    }
    
    func setLow_Color(_ color: UIColor) {
        lowColor = color
        layer.setNeedsDisplay()
    }
    
}
