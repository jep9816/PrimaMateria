//
//  XTRGeneralButton.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 4/14/16.
//  Copyright ©2018 xTrensa. All rights reserved.
//

class XTRGeneralButton : UIButton {
    
    private var highColor : UIColor = UIColor.white
    private var lowColor : UIColor = UIColor.white
    
    // MARK: - Initialization Methods
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)!
        
        highColor = UIColor.white
        lowColor = UIColor.white
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        titleLabel!.textAlignment = NSTextAlignment.center
        backgroundColor = UIColor.color(hexString: "cccccc")
        setTitleColor(UIColor.white, for: UIControlState())
        createLayer()
    }
    
    // MARK: - Internal Methods
    
    func setupColors() {
    }
    
    func createLayer() {
        layer.cornerRadius = 8.0
        layer.masksToBounds = true
        layer.borderWidth = 1.0
        layer.borderColor = UIColor.darkGray.cgColor
        setupColors()
    }
    
}
