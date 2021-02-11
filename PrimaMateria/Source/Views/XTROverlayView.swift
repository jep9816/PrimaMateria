//
//  XTROverlayView.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 8/1/18.
//  Copyright ©2020 xTrensa. All rights reserved.
//

import UIKit

class XTROverlayView: UIView {
    
    // MARK: - Initialization Methods
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(white: 0.3, alpha: 0.6)
        //overlayView.borderWidth = 2
        //overlayView.borderColor = UIColor.red
        isHidden = true
        isUserInteractionEnabled = true

    }
    
}
