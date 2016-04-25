//
//  DynoTableHeaderButton.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 4/14/16.
//  Copyright © 2016 xTrensa. All rights reserved.
//

@objc class DynoTableHeaderButton : GeneralButton {
    var imageLayer : CALayer?
    var descentingImageView : UIImage?
    var ascendingImageView : UIImage?
    var toggle : Bool = false
        
    // MARK: - Initialization Methods
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(DynoTableHeaderButton.tableHeaderCellSelected(_:)), name: NOTIFICATION_TABLE_HEADER_SELECTED, object: nil)
        self.toggle = false
        self.ascendingImageView = UIImage.init(named: "AscendingArrow.png")
        self.descentingImageView = UIImage.init(named: "DescendingArrow.png")
        self.imageLayer = CALayer.init()
        self.layer.addSublayer(self.imageLayer!)
        self.backgroundColor = UIColor.lightGrayColor()
    }
    
    // MARK: - Notification Methods
    
    func tableHeaderCellSelected(aNotification: NSNotification) {
        self.imageLayer!.contents = nil
    }

    // MARK: - Internal Methods

    func toggleButtonState(aFlag: Bool) {
        NSNotificationCenter.defaultCenter().postNotificationName(NOTIFICATION_TABLE_HEADER_SELECTED, object: nil)
        CATransaction.begin()
        CATransaction.setAnimationDuration(0.0)
        self.imageLayer!.frame = (aFlag) ? CGRectMake((self.frame.size.width/2) - 6, 2, 12, 12) : CGRectMake((self.frame.size.width/2) - 6, 30, 12, 12)
        self.imageLayer!.contents = (aFlag) ? self.ascendingImageView!.CGImage : self.descentingImageView!.CGImage
        CATransaction.commit()
        self.toggle = aFlag
    }
    
    func toggleState() -> Bool {
        self.toggleButtonState(!self.toggle)
        return self.toggle
    }
    
    override func createLayer() {
        self.layer.masksToBounds = true
        self.layer.borderWidth = 1.0
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
}
