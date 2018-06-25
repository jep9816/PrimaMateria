//
//  XTRElementButton.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 4/14/16.
//  Copyright © 2018 xTrensa. All rights reserved.
//

class XTRElementButton : XTRGeneralButton {
    
    // MARK: - Initialization Methods
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let element = XTRDataSource.sharedInstance().elementAtIndex(tag)

        backgroundColor = UIColor.clear
        setTitleColor(element.standardConditionColor, for: UIControlState())
        
        NotificationCenter.default.addObserver(self, selector: #selector(XTRElementButton.colorChanged(_:)), name: .seriesColorChangedNotification, object: nil)
    }
    
    // MARK: - Notification Methods
    
    @objc func colorChanged(_ aNotification: Notification) {
        setupColors()
        setNeedsDisplay()
    }
    
    // MARK: - Internal Methods

    override func setupColors() {
        let element = XTRDataSource.sharedInstance().elementAtIndex(tag)
        let backgroundColor = element.seriesColor
        let selectedColor = backgroundColor.inverseColor()
        let backgroundImage = UIImage.imageFromColor(backgroundColor, andSize: frame.size)
        let selectedImage = UIImage.imageFromColor(selectedColor, andSize: frame.size)
        
        setBackgroundImage(backgroundImage, for: UIControlState())
        setBackgroundImage(selectedImage, for: .highlighted)
        setBackgroundImage(selectedImage, for: .selected)
    }
    
    // MARK: - Memory Management Methods

    deinit {
        NotificationCenter.default.removeObserver(self, name: .seriesColorChangedNotification, object: nil)
    }
    
}
