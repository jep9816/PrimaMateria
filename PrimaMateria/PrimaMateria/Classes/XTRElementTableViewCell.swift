//
//  XTRElementTableViewCell.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 4/15/16.
//  Copyright © 2016 xTrensa. All rights reserved.
//

@objc class XTRElementTableViewCell : UITableViewCell {
    var atomicNumberLabel : DynoTableLabel!
    var symbolLabel : DynoTableLabel!
    var nameLabel : DynoTableLabel!
    var atomicMassLabel : DynoTableLabel!
    var boilingPointLabel : DynoTableLabel!
    var meltingPointLabel : DynoTableLabel!
    var densityLabel : DynoTableLabel!
    var seriesLabel : DynoTableLabel!
    var periodLabel : DynoTableLabel!
    var groupLabel : DynoTableLabel!
    var element : XTRElement!
    
    // MARK: - Initialization Methods
    
    required override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    func setupWithElement(element: XTRElement) {
        self.element = element
        self.backgroundColor = UIColor.blackColor()
        self.contentView.backgroundColor = UIColor.darkGrayColor()
        
        self.atomicNumberLabel = DynoTableLabel.init(frame: CGRectMake(0, 1, 85, 42), andColor: self.element.seriesColor())
        self.contentView.addSubview(self.atomicNumberLabel)
        
        self.symbolLabel = DynoTableLabel.init(frame: CGRectMake(86, 1, 95, 42), andColor: self.element.seriesColor())
        self.contentView.addSubview(self.symbolLabel)
        
        self.nameLabel = DynoTableLabel.init(frame: CGRectMake(182, 1, 125, 42), andColor: self.element.seriesColor())
        self.contentView.addSubview(self.nameLabel)
        
        self.atomicMassLabel = DynoTableLabel.init(frame: CGRectMake(308, 1, 105, 42), andColor: self.element.seriesColor())
        self.contentView.addSubview(self.atomicMassLabel)
        
        self.boilingPointLabel = DynoTableLabel.init(frame: CGRectMake(414, 1, 105, 42), andColor: self.element.seriesColor())
        self.contentView.addSubview(self.boilingPointLabel)
        
        self.meltingPointLabel = DynoTableLabel.init(frame: CGRectMake(520, 1, 105, 42), andColor: self.element.seriesColor())
        self.contentView.addSubview(self.meltingPointLabel)
        
        self.densityLabel = DynoTableLabel.init(frame: CGRectMake(626, 1, 105, 42), andColor: self.element.seriesColor())
        self.contentView.addSubview(self.densityLabel)
        
        self.seriesLabel = DynoTableLabel.init(frame: CGRectMake(732, 1, 150, 42), andColor: self.element.seriesColor())
        self.contentView.addSubview(self.seriesLabel)
        
        self.periodLabel = DynoTableLabel.init(frame: CGRectMake(883, 1, 72, 42), andColor: self.element.seriesColor())
        self.contentView.addSubview(self.periodLabel)
        
        self.groupLabel = DynoTableLabel.init(frame: CGRectMake(956, 1, 68, 42), andColor: self.element.seriesColor())
        self.contentView.addSubview(self.groupLabel)
        
        self.modifyCellProperties()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(XTRElementTableViewCell.colorChanged(_:)), name: NOTIFICATION_SERIES_COLOR_CHANGED, object: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - Notification Methods
    
    func colorChanged(aNotification: NSNotification) {
        self.setupColors()
        self.setNeedsDisplay()
    }
    
    // MARK: - Internal Methods
    
    func modifyLabel(aLabel: DynoTableLabel, withStandardConditionColor: UIColor, seriesColor: UIColor) {
        aLabel.font = UIFont.systemFontOfSize(16.0)
        aLabel.textColor = withStandardConditionColor
        aLabel.backgroundColor = seriesColor
        aLabel.autoresizingMask = [UIViewAutoresizing.FlexibleRightMargin, UIViewAutoresizing.FlexibleHeight]
    }
    
    func modifyCellProperties() {
        let seriesColor : UIColor = self.element.seriesColor()
        let selectedColor : UIColor = seriesColor.inverseColor()
        
        self.selectedBackgroundView = UIImageView.init(image: UIImage.imageFromColor(selectedColor, andSize: self.frame.size))
        
        self.modifyLabel(self.atomicNumberLabel, withStandardConditionColor: self.element.standardConditionColor(), seriesColor: self.element.seriesColor())
        self.atomicNumberLabel.text = String.init(format: "%@", self.element.atomicNumber())
        self.atomicNumberLabel.textAlignment = NSTextAlignment.Right

        self.modifyLabel(self.symbolLabel, withStandardConditionColor: self.element.standardConditionColor(), seriesColor: self.element.seriesColor())
        self.symbolLabel.font = UIFont.systemFontOfSize(26.0)
        self.symbolLabel.text = String.init(format: "%@", self.element.symbol()!)
        self.symbolLabel.textAlignment = NSTextAlignment.Center
        
        self.modifyLabel(self.nameLabel, withStandardConditionColor: self.element.standardConditionColor(), seriesColor: self.element.seriesColor())
        self.nameLabel.text = String.init(format: "%@", self.element.name()!)
        self.nameLabel.textAlignment = NSTextAlignment.Left
        
        self.modifyLabel(self.atomicMassLabel, withStandardConditionColor: self.element.standardConditionColor(), seriesColor: self.element.seriesColor())
        self.atomicMassLabel.text = String.init(format: "%@", (self.element.atomicMass() == 0) ? STRING_EMPTY : self.element.atomicMass())
        self.atomicMassLabel.textAlignment = NSTextAlignment.Right
        
        self.modifyLabel(self.boilingPointLabel, withStandardConditionColor: self.element.standardConditionColor(), seriesColor: self.element.seriesColor())
        self.boilingPointLabel.text = String.init(format: "%@", (self.element.boilingPoint() == 0) ? STRING_EMPTY : self.element.boilingPoint())
        self.boilingPointLabel.textAlignment = NSTextAlignment.Right
        
        self.modifyLabel(self.meltingPointLabel, withStandardConditionColor: self.element.standardConditionColor(), seriesColor: self.element.seriesColor())
        self.meltingPointLabel.text = String.init(format: "%@", (self.element.meltingPoint() == 0) ? STRING_EMPTY : self.element.meltingPoint())
        self.meltingPointLabel.textAlignment = NSTextAlignment.Right
        
        self.modifyLabel(self.densityLabel, withStandardConditionColor: self.element.standardConditionColor(), seriesColor: self.element.seriesColor())
        self.densityLabel.text = String.init(format: "%@", (self.element.density() == 0) ? STRING_EMPTY : self.element.density())
        self.densityLabel.textAlignment = NSTextAlignment.Right

        self.modifyLabel(self.seriesLabel, withStandardConditionColor: self.element.standardConditionColor(), seriesColor: self.element.seriesColor())
        self.seriesLabel.text = String.init(format: "%@", self.element.series()!)
        self.seriesLabel.textAlignment = NSTextAlignment.Left
        
        self.modifyLabel(self.periodLabel, withStandardConditionColor: self.element.standardConditionColor(), seriesColor: self.element.seriesColor())
        self.periodLabel.text = String.init(format: "%@", self.element.period()!)
        self.periodLabel.textAlignment = NSTextAlignment.Right
        
        self.modifyLabel(self.groupLabel, withStandardConditionColor: self.element.standardConditionColor(), seriesColor: self.element.seriesColor())
        self.groupLabel.text = String.init(format: "%@", (self.element.group()! == 0) ? STRING_EMPTY : self.element.group()!)
        self.groupLabel.textAlignment = NSTextAlignment.Right
    }
    
    func setupColors() {
        let aSeriesColor : UIColor = self.element.seriesColor()
        
        self.atomicNumberLabel.backgroundColor = aSeriesColor
        self.symbolLabel.backgroundColor = aSeriesColor
        self.nameLabel.backgroundColor = aSeriesColor
        self.atomicMassLabel.backgroundColor = aSeriesColor
        self.boilingPointLabel.backgroundColor = aSeriesColor
        self.meltingPointLabel.backgroundColor = aSeriesColor
        self.densityLabel.backgroundColor = aSeriesColor
        self.seriesLabel.backgroundColor = aSeriesColor
        self.periodLabel.backgroundColor = aSeriesColor
        self.groupLabel.backgroundColor = aSeriesColor
    }
    
    // MARK: - Memory Management Methods

    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: NOTIFICATION_SERIES_COLOR_CHANGED, object: nil)
    }
}
