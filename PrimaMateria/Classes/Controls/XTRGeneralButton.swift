//
//  XTRGeneralButton.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 4/14/16.
//  Copyright © 2018 xTrensa. All rights reserved.
//

import UIKit

class XTRLocalizedButton: UIButton {
    override func awakeFromNib() {
        super.awakeFromNib()

        for state in [UIControl.State.normal, UIControl.State.highlighted, UIControl.State.selected, UIControl.State.disabled] {
            if let title = title(for: state) {
                setTitle(NSLocalizedString(title, comment: ""), for: state)
            }
        }
    }
}

class XTRGeneralButton: XTRLocalizedButton {
    
    private var highColor = UIColor.white
    private var lowColor = UIColor.white
    
    // MARK: - Initialization Methods
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        
        highColor = UIColor.white
        lowColor = UIColor.white
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        titleLabel!.textAlignment = NSTextAlignment.center
        backgroundColor = XTRColorFactoryClassic.silverColor
        setTitleColor(UIColor.white, for: UIControl.State())
        createLayer()
    }
    
    // MARK: - Internal Methods
    
    func setupColors() {
    }
    
    func createLayer() {
        layer.cornerRadius = VIEW_CORNER_RADIUS
        layer.masksToBounds = true
        layer.borderWidth = 1.0
        layer.borderColor = UIColor.darkGray.cgColor
        setupColors()
    }
    
}
