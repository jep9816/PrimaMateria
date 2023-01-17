//
//  XTRLocalizedLabel.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 6/29/18.
//  Copyright ©2023 xTrensa. All rights reserved.
//

import UIKit

@IBDesignable
class XTRLocalizedLabel: UILabel {
    
    private var _isTitleLabel: Bool = false
    
    @IBInspectable var isTitleLabel: Bool {
        get {
            return _isTitleLabel
        }
        set {
            _isTitleLabel = newValue
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
