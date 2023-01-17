//
//  XTRElementButton.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 4/14/16.
//  Copyright ©2023 xTrensa. All rights reserved.
//

import UIKit
import Combine

class XTRElementButton: XTRGeneralButton {
    
    let pub = NotificationCenter.default.publisher(for: .colorSelectedNotification)
    var subscription: AnyCancellable!
    
    // MARK: - Initialization Methods
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        subscription = pub.sink { _ in
            self.setupColors()
            self.setNeedsDisplay()
        }
        
        backgroundColor = UIColor.clear
        setTitleColor(XTRDataSource.sharedInstance.element(index: tag).standardConditionColor, for: UIControl.State())
    }
    
    // MARK: - Internal Methods
    
    override func setupColors() {
        let backgroundColor = XTRDataSource.sharedInstance.element(index: tag).seriesColor
        let selectedImage = UIImage.imageFromColor(backgroundColor.inverseColor(), andSize: frame.size)
        
        setBackgroundImage(UIImage.imageFromColor(backgroundColor, andSize: frame.size), for: UIControl.State())
        setBackgroundImage(selectedImage, for: .highlighted)
        setBackgroundImage(selectedImage, for: .selected)
    }
    
    // MARK: - Memory Management Methods
    
    deinit {
        subscription.cancel()
    }
    
}
