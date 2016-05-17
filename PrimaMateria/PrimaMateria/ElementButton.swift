//
//  ElementButton.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 4/14/16.
//  Copyright © 2016 xTrensa. All rights reserved.
//

@objc class ElementButton : GeneralButton {
    // MARK: - Initialization Methods
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let element : XTRElement = XTRDataSource.sharedInstance().elementAtIndex(UInt(self.tag))

        self.backgroundColor = UIColor.clearColor()
        self.setTitleColor(element.standardConditionColor(), forState: UIControlState.Normal)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ElementButton.colorChanged(_:)), name: NOTIFICATION_SERIES_COLOR_CHANGED, object: nil)
    }
    
    // MARK: - Notification Methods
    
    func colorChanged(aNotification: NSNotification) {
        self.setupColors()
        self.setNeedsDisplay()
    }
    
    // MARK: - Internal Methods

    override func setupColors() {
        let element : XTRElement = XTRDataSource.sharedInstance().elementAtIndex(UInt(self.tag))
        let backgroundColor : UIColor = element.seriesColor()
        let selectedColor : UIColor = backgroundColor.inverseColor()
        let backgroundImage : UIImage = UIImage.imageFromColor(backgroundColor, andSize: self.frame.size)
        let selectedImage : UIImage = UIImage.imageFromColor(selectedColor, andSize: self.frame.size)
        self.setBackgroundImage(backgroundImage, forState: UIControlState.Normal)
        self.setBackgroundImage(selectedImage, forState: UIControlState.Highlighted)
        self.setBackgroundImage(selectedImage, forState: UIControlState.Selected)
    }
    
    // MARK: - Memory Management Methods

    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: NOTIFICATION_SERIES_COLOR_CHANGED, object: nil)
    }
}
