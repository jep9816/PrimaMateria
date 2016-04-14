//
//  XTRBarPlot.m
//  PrimaMateria
//
//  Created by Jerry Porter on 4/14/16.
//  Copyright © 2016 xTrensa. All rights reserved.
//

@interface XTRBarPlot()

-(void)colorChanged: (NSNotification *)aNotification;

@end

@implementation XTRBarPlot

-(void)colorChanged: (NSNotification *)aNotification {
    self.fill = [CPTFill fillWithColor: [CPTColor colorWithCGColor: self.element.seriesColor.CGColor]];
    [self reloadBarFills];
}

-(instancetype)init {
    if(self = [super init]) {
        [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(colorChanged:) name: NOTIFICATION_SERIES_COLOR_CHANGED object: nil];
    }
    return self;
}

+(instancetype)tubularBarPlotWithColor: (CPTColor *)color horizontalBars: (BOOL)horizontal {
    XTRBarPlot *barPlot               = [[XTRBarPlot alloc] init];
    CPTMutableLineStyle *barLineStyle = [[CPTMutableLineStyle alloc] init];
    
    barLineStyle.lineWidth = CPTFloat(1.0);
    barLineStyle.lineColor = [CPTColor blackColor];
    
    barPlot.lineStyle         = barLineStyle;
    barPlot.barsAreHorizontal = horizontal;
    barPlot.barWidth          = @0.8;
    barPlot.barCornerRadius   = CPTFloat(2.0);
    
    CPTGradient *fillGradient = [CPTGradient gradientWithBeginningColor:color endingColor:[CPTColor blackColor]];
    fillGradient.angle = CPTFloat(horizontal ? -90.0 : 0.0);
    barPlot.fill       = [CPTFill fillWithGradient:fillGradient];
    
    barPlot.barWidthsAreInViewCoordinates = NO;
    
    return barPlot;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver: self name: NOTIFICATION_SERIES_COLOR_CHANGED object: nil];
}

@end
