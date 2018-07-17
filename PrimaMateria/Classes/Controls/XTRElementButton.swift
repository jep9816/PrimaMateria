//
//  XTRElementButton.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 4/14/16.
//  Copyright © 2018 xTrensa. All rights reserved.
//

class XTRElementButton: XTRGeneralButton {
    
    // MARK: - Initialization Methods
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundColor = UIColor.clear
        setTitleColor(XTRDataSource.sharedInstance().elementAtIndex(tag).standardConditionColor, for: UIControlState())
        
        NotificationCenter.default.addObserver(self, selector: #selector(colorChanged(_:)), name: .seriesColorChangedNotification, object: nil)
    }
    
    // MARK: - Notification Methods
    
    @objc func colorChanged(_ aNotification: Notification) {
        setupColors()
        setNeedsDisplay()
    }
    
    // MARK: - Internal Methods

    override func setupColors() {
        let backgroundColor = XTRDataSource.sharedInstance().elementAtIndex(tag).seriesColor
        let selectedImage = UIImage.imageFromColor(backgroundColor.inverseColor(), andSize: frame.size)
        
        setBackgroundImage(UIImage.imageFromColor(backgroundColor, andSize: frame.size), for: UIControlState())
        setBackgroundImage(selectedImage, for: .highlighted)
        setBackgroundImage(selectedImage, for: .selected)
    }
    
    // MARK: - Memory Management Methods

    deinit {
        NotificationCenter.default.removeObserver(self, name: .seriesColorChangedNotification, object: nil)
    }
    
}
