//
//  XTRShadowView.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 4/14/16.
//  Copyright © 2018 xTrensa. All rights reserved.
//

class XTRShadowView: UIImageView {
    
    // MARK: - Initialization Methods
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        createLayer()
    }
    
    // MARK: - Internal Methods

    func createLayer() {
        let superView = superview!
        let sublayer = CALayer()
        
        sublayer.backgroundColor = UIColor.clear.cgColor
        sublayer.shadowOffset = CGSize(width: 5.0, height: 5.0)
        sublayer.shadowRadius = 10.0
        sublayer.shadowColor = UIColor.black.cgColor
        sublayer.shadowOpacity = 1.0
        sublayer.frame = CGRect(x: frame.origin.x + 1, y: frame.origin.y + 1, width: frame.size.width - 2, height: frame.size.height - 2)
        sublayer.borderColor = UIColor.black.cgColor
        sublayer.backgroundColor = UIColor.black.cgColor
        sublayer.borderWidth = 1.0
        sublayer.cornerRadius = 10.0
        
        superView.layer.addSublayer(sublayer)
        
        layer.masksToBounds = true
        layer.cornerRadius = 10.0
        layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5).cgColor
        layer.borderWidth = 3.0
        isOpaque = false
        
        superView.bringSubview(toFront: self)
    }
    
}
