//
//  XTRTableLabel.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 4/14/16.
//  Copyright © 2019 xTrensa. All rights reserved.
//

import UIKit

class XTRTableLabel: UILabel {
    
    private var edgeInsets: UIEdgeInsets
    
    // MARK: - Initialization Methods
    
    init(frame: CGRect, backgroundColor: UIColor) {
        edgeInsets =  UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        super.init(frame: frame)
        self.backgroundColor = backgroundColor
    }
    
    required init?(coder aDecoder: NSCoder) {
        edgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        super.init(coder: aDecoder)!
    }
    
    // MARK: - View Management Methods

    override func draw(_ rect: CGRect) {
        super.drawText(in: rect.inset(by: edgeInsets))
    }
    
}
