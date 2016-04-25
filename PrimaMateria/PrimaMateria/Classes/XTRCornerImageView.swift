//
//  XTRCornerImageView.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 4/14/16.
//  Copyright © 2016 xTrensa. All rights reserved.
//

@objc class XTRCornerImageView : UIImageView {
    private var gradientLayer:  CAGradientLayer!
    
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
        self.gradientLayer = CAGradientLayer.init()
        self.gradientLayer.bounds = self.bounds
        self.gradientLayer.position = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2)
        self.layer.insertSublayer(self.gradientLayer, atIndex: 0)
        self.layer.cornerRadius = 10.0
        self.layer.masksToBounds = true
    }
}
