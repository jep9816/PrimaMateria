//
//  XTRSpectrumViewController.m
//  PrimaMateria
//
//  Created by Jerry Porter on 11/21/11.
//  Copyright 2016 xTrensa. All rights reserved.
//

#import "PrimaMateria.h"

static NSString *kAirWavelength = @"airWavelength";
static NSString *kIntensity = @"intensity";
static NSString *kSpectrum = @"spectrum";
static NSString *kISpectrum = @"I";
static NSString *kIISpectrum = @"II";
static NSString *kIIISpectrum = @"III";
static NSString *kIVSpectrum = @"IV";
static NSString *kVSpectrum = @"V";

@interface XTRSpectrumViewController ()
- (CPTBarPlot *) addSpectrumPlotWithIdentifier: (NSString *) anIdentifier andColor: (CPTColor *) aColor;
- (NSNumber *) airWavelengthValue: (NSNumber *) anAirWavelength withIdentifier: (NSString *) anIdentifier andSpectrum: (NSString *) aSpectrum;
- (NSNumber *) intensityValue: (NSNumber *) anIntensity withIdentifier: (NSString *) anIdentifier andSpectrum: (NSString *) aSpectrum;
- (UILabel *) tableCellLabelWithXPos: (float) xPos YPos: (float) yPos width: (float) aWidth height: (float) aHeight property: (NSObject *) aProperty columnPosition: (int) aColumnPosition modulus: (int) aModulus forCell: (DynoTableCell *) cell;
- (void)setupBarChart;
@end

@implementation XTRSpectrumViewController

#pragma mark Private Methods

- (NSNumber *) airWavelengthValue: (NSNumber *) anAirWavelength withIdentifier: (NSString *) anIdentifier andSpectrum: (NSString *) aSpectrum {
    return [aSpectrum hasSuffix:[NSString stringWithFormat: @" %@", anIdentifier]] ? anAirWavelength : @0;
}

- (CPTBarPlot *) addSpectrumPlotWithIdentifier: (NSString *) anIdentifier andColor: (CPTColor *) aColor {
    CPTBarPlot *barPlot = [CPTBarPlot tubularBarPlotWithColor: aColor horizontalBars: NO];
    barPlot.barWidth = @20.0f;
    barPlot.baseValue = @1;
    barPlot.dataSource = self;
    barPlot.barOffset = @0.0f;
    barPlot.identifier = anIdentifier;
    return barPlot;
}

- (NSNumber *) intensityValue: (NSNumber *) anIntensity withIdentifier: (NSString *) anIdentifier andSpectrum: (NSString *) aSpectrum {
    return [aSpectrum hasSuffix:[NSString stringWithFormat: @" %@", anIdentifier]] ? anIntensity : @0;
}

- (void)setupBarChart {
    // Create barChart from theme
    self.barChart = [[CPTXYGraph alloc] initWithFrame: CGRectZero];
    [self.barChart applyTheme: [CPTTheme themeNamed: kCPTSlateTheme]];
    self.hostingView.hostedGraph = self.barChart;
    self.barChart.plotAreaFrame.masksToBorder = NO;

    self.barChart.paddingLeft = 100.0;
    self.barChart.paddingTop = 10.0;
    self.barChart.paddingRight = 5.0;
    self.barChart.paddingBottom = 60.0;

    // Add plot space for horizontal bar charts
    CPTXYPlotSpace *plotSpace = (CPTXYPlotSpace *)self.barChart.defaultPlotSpace;
    plotSpace.yRange = [CPTPlotRange plotRangeWithLocation: @(0.0f) length: @(1000.0f)];
    plotSpace.xRange = [CPTPlotRange plotRangeWithLocation: @(4000.0f) length: @(3500.0f)];
    CPTMutableLineStyle *majorTickStyle = [CPTMutableLineStyle lineStyle];
    majorTickStyle.lineWidth = 2.0f;
    majorTickStyle.lineColor = [CPTColor greenColor];
    CPTMutableLineStyle *minorTickStyle = [CPTMutableLineStyle lineStyle];
    minorTickStyle.lineWidth = 1.0f;
    minorTickStyle.lineColor = [CPTColor greenColor];

    CPTXYAxisSet *axisSet = (CPTXYAxisSet *)self.barChart.axisSet;
    CPTXYAxis *x = axisSet.xAxis;
    x.axisLineStyle = nil;
    x.minorTicksPerInterval = 2;
    x.majorTickLineStyle = majorTickStyle;
    x.minorTickLineStyle = minorTickStyle;
    x.majorIntervalLength = @500;
    x.majorGridLineStyle = minorTickStyle;
    x.orthogonalPosition = @0;
    x.title = @"Wave Length Å";
    x.titleLocation = @(5750.0f);
    x.titleOffset = 40.0f;

    // Define some custom labels for the data elements
    x.labelRotation = M_PI / 4;
    x.labelingPolicy = CPTAxisLabelingPolicyNone;
    NSArray *customTickLocations = @[[NSDecimalNumber numberWithInt: 4000],
                                    [NSDecimalNumber numberWithInt: 4500],
                                    [NSDecimalNumber numberWithInt: 5000],
                                    [NSDecimalNumber numberWithInt: 5500],
                                    [NSDecimalNumber numberWithInt: 6000],
                                    [NSDecimalNumber numberWithInt: 6500],
                                    [NSDecimalNumber numberWithInt: 7000],
                                    [NSDecimalNumber numberWithInt: 7500]];
    NSArray *xAxisLabels = @[ @"4000", @"4500", @"5000", @"5500", @"6000", @"6500", @"7000",  @"7500"];
    NSUInteger labelLocation = 0;
    NSMutableArray *customLabels = [NSMutableArray arrayWithCapacity:xAxisLabels.count];
    for (NSNumber *tickLocation in customTickLocations) {
        CPTAxisLabel *newLabel = [[CPTAxisLabel alloc] initWithText:xAxisLabels[labelLocation++] textStyle: x.labelTextStyle];
        newLabel.tickLocation = tickLocation;
        newLabel.offset = x.labelOffset + x.majorTickLength;
        newLabel.rotation = M_PI / 4;
        [customLabels addObject: newLabel];
    }

    x.axisLabels =  [NSSet setWithArray: customLabels];

    CPTXYAxis *y = axisSet.yAxis;
    y.axisLineStyle = nil;
    y.minorTicksPerInterval = 3;
    y.majorTickLineStyle = majorTickStyle;
    y.minorTickLineStyle = minorTickStyle;
    y.majorIntervalLength = @100;
    y.majorGridLineStyle = minorTickStyle;
    y.orthogonalPosition = @4000;
    y.title = @"Intensity";
    y.titleOffset = 50.0f;
    y.titleLocation = @(500.0f);

    CPTBarPlot *barPlot = [self addSpectrumPlotWithIdentifier: kISpectrum andColor:[CPTColor redColor]];
    [self.barChart addPlot: barPlot toPlotSpace: plotSpace];

    barPlot = [self addSpectrumPlotWithIdentifier: kIISpectrum andColor:[CPTColor blueColor]];
    [self.barChart addPlot: barPlot toPlotSpace: plotSpace];

    barPlot = [self addSpectrumPlotWithIdentifier: kIIISpectrum andColor:[CPTColor greenColor]];
    [self.barChart addPlot: barPlot toPlotSpace: plotSpace];

    barPlot = [self addSpectrumPlotWithIdentifier: kIVSpectrum andColor:[CPTColor cyanColor]];
    [self.barChart addPlot: barPlot toPlotSpace: plotSpace];

    barPlot = [self addSpectrumPlotWithIdentifier: kVSpectrum andColor:[CPTColor magentaColor]];
    [self.barChart addPlot: barPlot toPlotSpace: plotSpace];
}

- (UILabel *) tableCellLabelWithXPos: (float) xPos YPos: (float) yPos width: (float) aWidth height: (float) aHeight property: (NSObject *) aProperty columnPosition: (int) aColumnPosition modulus: (int) aModulus forCell: (DynoTableCell *) cell {
    UILabel *label = [[UILabel alloc] initWithFrame: CGRectMake(xPos, yPos, aWidth, aHeight)];
    if (aModulus == 0)
        label.backgroundColor = UIColor.whiteColor;
    else
        label.backgroundColor = [UIColor colorWithHue: 219 / HSB_CONSTANT saturation: 0.1f brightness: 1.0f alpha: 1.0f];
    [cell addColumn: aColumnPosition];
    label.font = [UIFont systemFontOfSize:20.0];
    label.textAlignment =  NSTextAlignmentCenter;
    label.textColor = UIColor.blackColor;
    label.text = [NSString stringWithFormat: @" %@", aProperty];
    [cell.contentView addSubview: label];
    return label;
}

#pragma mark - Misc Methods

- (void)setupUI {
    if (self.element != nil) {
        if (self.tableView != nil) {
            [self.tableView removeFromSuperview];
            self.tableView = nil;
        }
        self.tableView = [[UITableView alloc] initWithFrame:self.swapView.frame style: UITableViewStylePlain];
        self.tableView.alwaysBounceVertical = NO;
        self.tableView.alwaysBounceHorizontal = NO;
        self.tableView.dataSource = self;
        self.tableView.delegate = self;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.tableView.backgroundColor = UIColor.blackColor;
        self.tableView.rowHeight = 34.0f;
        [self.view addSubview: self.tableView];
        self.lineSpectraArray = (self.element).lineSpectra;
        [self.tableView reloadData];
    }
    [self setupBarChart];
}

#pragma mark - UITableView DataSource Methods

- (UITableViewCell *) tableView: (UITableView *) aTableView cellForRowAtIndexPath: (NSIndexPath *) indexPath {
    NSInteger row = indexPath.row;
    NSString *MyIdentifier = [NSString stringWithFormat: @"Column %i", row];
    DynoTableCell *cell = (DynoTableCell *)[aTableView dequeueReusableCellWithIdentifier: MyIdentifier];
    if (cell == nil) {
        NSInteger modulus = row % 2;
        NSDictionary *dict = self.lineSpectraArray[row];
        cell = [[DynoTableCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier: MyIdentifier];
        [self tableCellLabelWithXPos: 0.0f   YPos: 0.0f width: 119.0f  height: 32.0f property:[dict valueForKey: kAirWavelength] columnPosition: 1 modulus: modulus forCell: cell];
        [self tableCellLabelWithXPos: 120.0f  YPos: 0.0f width: 119.0f height: 32.0f property:[dict valueForKey: kIntensity] columnPosition: 2 modulus: modulus forCell: cell];
        [self tableCellLabelWithXPos: 240.0f YPos: 0.0f width: 118.0f height: 32.0f property:[dict valueForKey: kSpectrum] columnPosition: 3 modulus: modulus forCell: cell];
    }
    return cell;
}

- (NSInteger) numberOfSectionsInTableView: (UITableView *) aTableView {
    return 1;
}

- (NSInteger) tableView: (UITableView *) aTableView numberOfRowsInSection: (NSInteger) section {
    return self.element.lineSpectra.count;
}

#pragma mark - Plot Data Source Methods

- (NSUInteger) numberOfRecordsForPlot: (CPTPlot *) plot {
    return self.lineSpectraArray.count;
}

- (NSNumber *) numberForPlot: (CPTPlot *) plot field: (NSUInteger) fieldEnum recordIndex: (NSUInteger) index  {
    NSNumber *num = nil;
    if ([plot isKindOfClass:[CPTBarPlot class]]) {
        NSDictionary *anItem = self.lineSpectraArray[index];
        NSNumber *airWavelength = [anItem valueForKey: kAirWavelength];
        NSNumber *intensity = [anItem valueForKey: kIntensity];
        NSString *spectrum = [anItem valueForKey: kSpectrum];
        NSString *identifier = (NSString *)plot.identifier;

        switch (fieldEnum) {
            case 0:
                num = [self airWavelengthValue: airWavelength withIdentifier: identifier andSpectrum: spectrum];
                break;

            case 1:
                num = [self intensityValue: intensity withIdentifier: identifier andSpectrum: spectrum];
                break;
        }
    }
    return num;
}

- (CPTFill *) barFillForBarPlot: (CPTBarPlot *) barPlot recordIndex: (NSInteger) index {
    return nil;
}

#pragma mark - View Management Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.swapView removeFromSuperview];
}

- (BOOL) shouldAutorotateToInterfaceOrientation: (UIInterfaceOrientation) interfaceOrientation {
    return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

#pragma mark - Memory Management Methods

- (void)dealloc {
    self.tableView.delegate = nil;
    self.tableView = nil;
    self.swapView = nil;
    self.hostingView = nil;
}

@end
