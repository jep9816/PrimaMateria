//
//  XTRTableLabel.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 4/14/16.
//  Copyright ©2023 xTrensa. All rights reserved.
//

import UIKit

class XTRTableLabel: UILabel {
    
    private var edgeInsets: UIEdgeInsets
    
    // MARK: - Initialization Methods
    
    init(frame: CGRect, backgroundColor: UIColor) {
        edgeInsets =  UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        super.init(frame: frame)
        self.backgroundColor = backgroundColor
        addLeftBorder()
        addRightBorder()
    }
    
    required init?(coder aDecoder: NSCoder) {
        edgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        super.init(coder: aDecoder)!
    }
    
    // MARK: - View Management Methods
    
    override func draw(_ rect: CGRect) {
        super.drawText(in: rect.inset(by: edgeInsets))
    }
    
    private func addLeftBorder() {
        let leftBorder: CALayer = CALayer()
        leftBorder.borderColor = UIColor.black.cgColor
        leftBorder.borderWidth = 1
        leftBorder.frame = CGRect(x: 0, y: 0, width: 1, height: self.frame.height)
        self.clipsToBounds = true
        self.layer.addSublayer(leftBorder)
    }
    
    private func addRightBorder() {
        let rightBorder: CALayer = CALayer()
        rightBorder.borderColor = UIColor.black.cgColor
        rightBorder.borderWidth = 1
        rightBorder.frame = CGRect(x: self.frame.width - 1, y: 0, width: 1, height: self.frame.height)
        self.clipsToBounds = true
        self.layer.addSublayer(rightBorder)
    }
}
