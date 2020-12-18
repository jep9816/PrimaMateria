//
//  XTRLocalizedLabel.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 6/29/18.
//  Copyright ©2020 xTrensa. All rights reserved.
//

import UIKit

@IBDesignable
class XTRLocalizedLabel: UILabel {
    
    private var _isTitleLabel: Bool = false
    
    @IBInspectable var isTitleLabel: Bool {
        set {
            _isTitleLabel = newValue
        }
        get {
            return _isTitleLabel
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        if let text = text {
            if isTitleLabel {
                self.text = " \(NSLocalizedString(text, comment: "")):"
            } else {
                self.text = NSLocalizedString(text, comment: "")
            }
        }
    }
}
