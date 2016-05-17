//
//  GeneralButton.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 4/14/16.
//  Copyright © 2016 xTrensa. All rights reserved.
//

@objc class GeneralButton : UIButton {
    var highColor : UIColor
    var lowColor : UIColor
    
    // MARK: - Initialization Methods
    
    required init?(coder aDecoder: NSCoder) {
        highColor = UIColor.whiteColor()
        lowColor = UIColor.whiteColor()
        super.init(coder:aDecoder)!
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.titleLabel!.textAlignment = NSTextAlignment.Center
        self.backgroundColor = UIColor(hexString: "cccccc")
        self.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        self.createLayer()
    }
    
    // MARK: - Internal Methods
    
    func setupColors() {
    }
    
    func createLayer() {
        self.layer.cornerRadius = 8.0
        self.layer.masksToBounds = true
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.darkGrayColor().CGColor
        self.setupColors()
    }
}
