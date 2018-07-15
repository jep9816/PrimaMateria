//
//  XTRBarPlot.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 4/14/16.
//  Copyright © 2018 xTrensa. All rights reserved.
//

import CorePlot

class XTRBarPlot : CPTBarPlot {
    
    var element: XTRElementModel!
    
    // MARK: - Initialization Methods

    override init(frame:CGRect) {
        super.init(frame:frame)
        
        NotificationCenter.default.addObserver(self, selector: #selector(colorChanged(_:)), name: .seriesColorChangedNotification, object: nil)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)!
        
        NotificationCenter.default.addObserver(self, selector: #selector(colorChanged(_:)), name: .seriesColorChangedNotification, object: nil)
    }
    
    // MARK: - Notification Methods

    @objc func colorChanged(_ aNotification: Notification) {
        fill = CPTFill(color:CPTColor(cgColor:element.seriesColor.cgColor))
        reloadBarFills()
    }

    // MARK: - Internal Methods

    override class func tubularBarPlot(with color: CPTColor, horizontalBars horizontal: Bool) -> XTRBarPlot {
        let barPlot = XTRBarPlot(frame: CGRect.zero)
        let barLineStyle = CPTMutableLineStyle()
        let fillGradient = CPTGradient(beginning: color, ending: CPTColor.black())

        fillGradient.angle = horizontal ? -90.0 : 0.0

        barLineStyle.lineWidth = 1.0
        barLineStyle.lineColor = CPTColor.black()
        barPlot.lineStyle = barLineStyle
        barPlot.barsAreHorizontal = horizontal
        barPlot.barWidth = 0.8
        barPlot.barCornerRadius = 2.0
        barPlot.fill = CPTFill(gradient: fillGradient)
        barPlot.barWidthsAreInViewCoordinates = false
        return barPlot
    }

    // MARK: - Memory Management Methods

    deinit {
        NotificationCenter.default.removeObserver(self, name: .seriesColorChangedNotification, object: nil)
    }
    
}
