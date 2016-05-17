//
//  XTRBarPlot.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 4/14/16.
//  Copyright © 2016 xTrensa. All rights reserved.
//

@objc class XTRBarPlot : CPTBarPlot {
    var element: XTRElement!
    
    // MARK: - Initialization Methods

    override init(frame:CGRect) {
        super.init(frame:frame)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(XTRBarPlot.colorChanged(_:)), name: NOTIFICATION_SERIES_COLOR_CHANGED, object: nil)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(XTRBarPlot.colorChanged(_:)), name: NOTIFICATION_SERIES_COLOR_CHANGED, object: nil)
    }
    
    // MARK: - Notification Methods

    func colorChanged(aNotification: NSNotification) {
        self.fill = CPTFill(color:CPTColor(CGColor:element.seriesColor().CGColor))
        self.reloadBarFills();
    }

    // MARK: - Internal Methods

    override class func tubularBarPlotWithColor(color: CPTColor, horizontalBars horizontal: Bool) -> XTRBarPlot {
        let barPlot: XTRBarPlot = XTRBarPlot(frame: CGRectZero)
        let barLineStyle: CPTMutableLineStyle = CPTMutableLineStyle()
        let fillGradient: CPTGradient = CPTGradient(beginningColor: color, endingColor: CPTColor.blackColor())

        fillGradient.angle = horizontal ? -90.0 : 0.0

        barLineStyle.lineWidth = 1.0
        barLineStyle.lineColor = CPTColor.blackColor()
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
        NSNotificationCenter.defaultCenter().removeObserver(self, name: NOTIFICATION_SERIES_COLOR_CHANGED, object: nil)
    }
}
