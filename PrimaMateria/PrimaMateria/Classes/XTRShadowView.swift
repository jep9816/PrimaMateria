//
//  XTRShadowView.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 4/14/16.
//  Copyright © 2016 xTrensa. All rights reserved.
//

@objc class XTRShadowView : UIImageView {
    
    // MARK: - Initialization Methods
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.createLayer()
    }
    
    // MARK: - Internal Methods

    func createLayer() {
        let superView : UIView = self.superview!
        let sublayer : CALayer = CALayer.init()
        sublayer.backgroundColor = UIColor.clearColor().CGColor
        sublayer.shadowOffset = CGSizeMake(5.0, 5.0)
        sublayer.shadowRadius = 10.0
        sublayer.shadowColor = UIColor.blackColor().CGColor
        sublayer.shadowOpacity = 1.0
        sublayer.frame = CGRectMake(self.frame.origin.x + 1, self.frame.origin.y + 1, self.frame.size.width - 2, self.frame.size.height - 2)
        sublayer.borderColor = UIColor.blackColor().CGColor
        sublayer.backgroundColor = UIColor.blackColor().CGColor
        sublayer.borderWidth = 1.0
        sublayer.cornerRadius = 10.0
        superView.layer.addSublayer(sublayer)
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 10.0
        self.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5).CGColor
        self.layer.borderWidth = 3.0
        self.opaque = false
        superView.bringSubviewToFront(self)
    }
}
