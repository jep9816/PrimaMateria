//
//  XTRElementTableViewCell.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 4/15/16.
//  Copyright ©2018 xTrensa. All rights reserved.
//

class XTRElementTableViewCell : UITableViewCell {
    
    var atomicNumberLabel : XTRTableLabel!
    var symbolLabel : XTRTableLabel!
    var nameLabel : XTRTableLabel!
    var atomicMassLabel : XTRTableLabel!
    var boilingPointLabel : XTRTableLabel!
    var meltingPointLabel : XTRTableLabel!
    var densityLabel : XTRTableLabel!
    var seriesLabel : XTRTableLabel!
    var periodLabel : XTRTableLabel!
    var groupLabel : XTRTableLabel!
    var element : XTRElement!
    
    // MARK: - Initialization Methods
    
    required override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    func setupWithElement(_ anElement: XTRElement) {
        element = anElement
        backgroundColor = UIColor.black
        contentView.backgroundColor = UIColor.darkGray
        
        atomicNumberLabel = XTRTableLabel(frame: CGRect(x: 0, y: 1, width: 85, height: 42), backgroundColor: element.seriesColor)
        contentView.addSubview(atomicNumberLabel)
        
        symbolLabel = XTRTableLabel(frame: CGRect(x: 86, y: 1, width: 95, height: 42), backgroundColor: element.seriesColor)
        contentView.addSubview(symbolLabel)
        
        nameLabel = XTRTableLabel(frame: CGRect(x: 182, y: 1, width: 125, height: 42), backgroundColor: element.seriesColor)
        contentView.addSubview(nameLabel)
        
        atomicMassLabel = XTRTableLabel(frame: CGRect(x: 308, y: 1, width: 105, height: 42), backgroundColor: element.seriesColor)
        contentView.addSubview(atomicMassLabel)
        
        boilingPointLabel = XTRTableLabel(frame: CGRect(x: 414, y: 1, width: 105, height: 42), backgroundColor: element.seriesColor)
        contentView.addSubview(boilingPointLabel)
        
        meltingPointLabel = XTRTableLabel(frame: CGRect(x: 520, y: 1, width: 105, height: 42), backgroundColor: element.seriesColor)
        contentView.addSubview(meltingPointLabel)
        
        densityLabel = XTRTableLabel(frame: CGRect(x: 626, y: 1, width: 105, height: 42), backgroundColor: element.seriesColor)
        contentView.addSubview(densityLabel)
        
        seriesLabel = XTRTableLabel(frame: CGRect(x: 732, y: 1, width: 150, height: 42), backgroundColor: element.seriesColor)
        contentView.addSubview(seriesLabel)
        
        periodLabel = XTRTableLabel(frame: CGRect(x: 883, y: 1, width: 72, height: 42), backgroundColor: element.seriesColor)
        contentView.addSubview(periodLabel)
        
        groupLabel = XTRTableLabel(frame: CGRect(x: 956, y: 1, width: 68, height: 42), backgroundColor: element.seriesColor)
        contentView.addSubview(groupLabel)
        
        modifyCellProperties()
        NotificationCenter.default.addObserver(self, selector: #selector(XTRElementTableViewCell.colorChanged(_:)), name: .seriesColorChangedNotification, object: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - Notification Methods
    
    @objc func colorChanged(_ aNotification: Notification) {
        setupColors()
        setNeedsDisplay()
    }
    
    // MARK: - Internal Methods
    
    func modifyLabel(_ aLabel: XTRTableLabel, withStandardConditionColor: UIColor, seriesColor: UIColor) {
        aLabel.font = UIFont.systemFont(ofSize: 16.0)
        aLabel.textColor = withStandardConditionColor
        aLabel.backgroundColor = seriesColor
        aLabel.autoresizingMask = [UIViewAutoresizing.flexibleRightMargin, UIViewAutoresizing.flexibleHeight]
    }
    
    func modifyCellProperties() {
        let seriesColor = element.seriesColor
        let selectedColor = seriesColor.inverseColor()
        
        selectedBackgroundView = UIImageView(image: UIImage.imageFromColor(selectedColor, andSize: frame.size))
        
        modifyLabel(atomicNumberLabel, withStandardConditionColor: element.standardConditionColor, seriesColor: element.seriesColor)
        atomicNumberLabel.text = String(element.atomicNumber)
        atomicNumberLabel.textAlignment = .right
        
        modifyLabel(symbolLabel, withStandardConditionColor: element.standardConditionColor, seriesColor: element.seriesColor)
        symbolLabel.font = UIFont.systemFont(ofSize: 26.0)
        symbolLabel.text = String(format: "%@", element.symbol!)
        symbolLabel.textAlignment = .center
        
        modifyLabel(nameLabel, withStandardConditionColor: element.standardConditionColor, seriesColor: element.seriesColor)
        nameLabel.text = String(format: "%@", element.name!)
        nameLabel.textAlignment = .left
        
        modifyLabel(atomicMassLabel, withStandardConditionColor: element.standardConditionColor, seriesColor: element.seriesColor)
        atomicMassLabel.text = element.value(forKeyPath: ELEMENT_ATOMIC_MASS) as? String
        atomicMassLabel.textAlignment = .right
        
        modifyLabel(boilingPointLabel, withStandardConditionColor: element.standardConditionColor, seriesColor: element.seriesColor)
        boilingPointLabel.text = element.value(forKeyPath: ELEMENT_BOILING_POINT) as? String
        boilingPointLabel.textAlignment = .right
        
        modifyLabel(meltingPointLabel, withStandardConditionColor: element.standardConditionColor, seriesColor: element.seriesColor)
        meltingPointLabel.text = element.value(forKeyPath: ELEMENT_MELTING_POINT) as? String
        meltingPointLabel.textAlignment = .right
        
        modifyLabel(densityLabel, withStandardConditionColor: element.standardConditionColor, seriesColor: element.seriesColor)
        densityLabel.text = element.value(forKeyPath: ELEMENT_DENSITY) as? String
        densityLabel.textAlignment = .right
        
        modifyLabel(seriesLabel, withStandardConditionColor: element.standardConditionColor, seriesColor: element.seriesColor)
        seriesLabel.text = String(format: "%@", element.series!)
        seriesLabel.textAlignment = .left
        
        modifyLabel(periodLabel, withStandardConditionColor: element.standardConditionColor, seriesColor: element.seriesColor)
        periodLabel.text = String(format: "%@", element.period!)
        periodLabel.textAlignment = .right
        
        modifyLabel(groupLabel, withStandardConditionColor: element.standardConditionColor, seriesColor: element.seriesColor)

        let aGroup = element.group!
        groupLabel.text = (aGroup != 0) ? String(format: "%d", aGroup) : STRING_EMPTY
        groupLabel.textAlignment = .right
    }
    
    func setupColors() {
        let aSeriesColor = element.seriesColor
        
        atomicNumberLabel.backgroundColor = aSeriesColor
        symbolLabel.backgroundColor = aSeriesColor
        nameLabel.backgroundColor = aSeriesColor
        atomicMassLabel.backgroundColor = aSeriesColor
        boilingPointLabel.backgroundColor = aSeriesColor
        meltingPointLabel.backgroundColor = aSeriesColor
        densityLabel.backgroundColor = aSeriesColor
        seriesLabel.backgroundColor = aSeriesColor
        periodLabel.backgroundColor = aSeriesColor
        groupLabel.backgroundColor = aSeriesColor
    }
    
    // MARK: - Memory Management Methods
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: .seriesColorChangedNotification, object: nil)
    }
    
}
