//
//  XTRSpectrumViewController.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 4/17/16.
//  Copyright © 2016 xTrensa. All rights reserved.
//

private let kAirWavelength : String = "airWavelength"
private let kIntensity : String = "intensity"
private let kSpectrum : String = "spectrum"
private let kISpectrum : String = "I"
private let kIISpectrum : String = "II"
private let kIIISpectrum : String = "III"
private let kIVSpectrum : String = "IV"
private let kVSpectrum : String = "V"

@objc class XTRSpectrumViewController : XTRSwapableViewController, UITableViewDelegate, UITableViewDataSource, CPTPlotDataSource {
    
    @IBOutlet weak var hostingView : CPTGraphHostingView!
    @IBOutlet var swapView : UIView!
    
    var barChart : CPTXYGraph?
    var lineSpectraArray : NSArray?
    var tableView : UITableView?
    
    // MARK: - Initialization Methods
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    // MARK: - Internal Methods
    
    func airWavelengthValue(anAirWavelength: NSNumber, anIdentifier: String, aSpectrum: String) -> NSNumber {
        return aSpectrum.hasSuffix(String.init(format: " %@", anIdentifier)) ? anAirWavelength : 0
    }
    
    func addSpectrumPlotWithIdentifier(anIdentifier : String, aColor: CPTColor) -> CPTBarPlot {
        let barPlot : CPTBarPlot = CPTBarPlot.tubularBarPlotWithColor(aColor, horizontalBars: false)
        barPlot.barWidth = 20.0
        barPlot.baseValue = 1
        barPlot.dataSource = self
        barPlot.barOffset = 0.0
        barPlot.identifier = anIdentifier
        return barPlot
    }
    
    func intensityValue(anIntensity: NSNumber, anIdentifier: NSString, aSpectrum: String)  -> NSNumber {
        return aSpectrum.hasSuffix(String.init(format: " %@", anIdentifier)) ? anIntensity : 0
    }
    
    func setupBarChart() {
        // Create barChart from theme
        self.barChart = CPTXYGraph.init(frame: CGRectZero)
        self.barChart!.applyTheme(CPTTheme(named: kCPTSlateTheme))
        self.hostingView.hostedGraph = self.barChart
        self.barChart!.plotAreaFrame!.masksToBorder = false
        
        self.barChart!.paddingLeft = 100.0
        self.barChart!.paddingTop = 10.0
        self.barChart!.paddingRight = 5.0
        self.barChart!.paddingBottom = 60.0

        let plotSpace : CPTXYPlotSpace = self.barChart!.defaultPlotSpace as! CPTXYPlotSpace
        let majorTickStyle : CPTMutableLineStyle = CPTMutableLineStyle.init()
        let minorTickStyle : CPTMutableLineStyle = CPTMutableLineStyle.init()
        let axisSet : CPTXYAxisSet = self.barChart!.axisSet as! CPTXYAxisSet
        let x : CPTXYAxis = axisSet.xAxis!
        let y : CPTXYAxis = axisSet.yAxis!
        let customTickLocations : NSArray = [4000,  4500, 5000, 5500, 6000, 6500, 7000, 7500]
        let xAxisLabels : NSArray = ["4000", "4500", "5000", "5500", "6000", "6500", "7000",  "7500"]
        var labelLocation : Int = 0
        let customLabels : NSMutableArray! = NSMutableArray.init(capacity: xAxisLabels.count)
        
        // Add plot space for horizontal bar charts
        plotSpace.yRange = CPTPlotRange(location: 0.0, length: 1000.0)
        plotSpace.xRange = CPTPlotRange(location: 4000.0, length: 3500.0)
        
        majorTickStyle.lineWidth = 2.0
        majorTickStyle.lineColor = CPTColor.greenColor()
        minorTickStyle.lineWidth = 1.0
        minorTickStyle.lineColor = CPTColor.greenColor()
        
        x.axisLineStyle = nil
        x.minorTicksPerInterval = 2
        x.majorTickLineStyle = majorTickStyle
        x.minorTickLineStyle = minorTickStyle
        x.majorIntervalLength = 500
        x.majorGridLineStyle = minorTickStyle
        x.orthogonalPosition = 0
        x.title = "Wave Length Å"
        x.titleLocation = 5750.0
        x.titleOffset = 40.0
        
        // Define some custom labels for the data elements
        x.labelRotation = (CGFloat) (M_PI / 4)
        x.labelingPolicy = CPTAxisLabelingPolicy.None
        
        for index in 0..<customTickLocations.count {
            labelLocation += labelLocation
            let newLabel : CPTAxisLabel = CPTAxisLabel.init(text: xAxisLabels[labelLocation] as? String, textStyle: x.labelTextStyle)
            let tickLocation : NSNumber = customTickLocations.objectAtIndex(index) as! NSNumber
            newLabel.tickLocation = tickLocation
            newLabel.offset = x.labelOffset + x.majorTickLength
            newLabel.rotation = (CGFloat) (M_PI / 4)
            customLabels.addObject(newLabel)
        }
        
        x.axisLabels = NSSet(array: customLabels as [AnyObject]) as? Set<CPTAxisLabel>
        
        y.axisLineStyle = nil
        y.minorTicksPerInterval = 3
        y.majorTickLineStyle = majorTickStyle
        y.minorTickLineStyle = minorTickStyle
        y.majorIntervalLength = 100
        y.majorGridLineStyle = minorTickStyle
        y.orthogonalPosition = 4000
        y.title = "Intensity"
        y.titleOffset = 50.0
        y.titleLocation = 500.0
        
        var barPlot : CPTBarPlot = self.addSpectrumPlotWithIdentifier(kISpectrum, aColor: CPTColor.redColor())
        
        self.barChart!.addPlot(barPlot, toPlotSpace: plotSpace)
        
        barPlot = self.addSpectrumPlotWithIdentifier(kIISpectrum, aColor: CPTColor.blueColor())
        self.barChart!.addPlot(barPlot, toPlotSpace: plotSpace)
        
        barPlot = self.addSpectrumPlotWithIdentifier(kIIISpectrum, aColor: CPTColor.greenColor())
        self.barChart!.addPlot(barPlot, toPlotSpace: plotSpace)
        
        barPlot = self.addSpectrumPlotWithIdentifier(kIVSpectrum, aColor: CPTColor.cyanColor())
        self.barChart!.addPlot(barPlot, toPlotSpace: plotSpace)
        
        barPlot = self.addSpectrumPlotWithIdentifier(kVSpectrum, aColor: CPTColor.magentaColor())
        self.barChart!.addPlot(barPlot, toPlotSpace: plotSpace)
    }
    
    func tableCellLabelWithXPos(xPos : CGFloat, YPos: CGFloat, width: CGFloat, height: CGFloat, property: String, columnPosition: Int, modulus: Int, cell: DynoTableCell) -> UILabel {
        let label : UILabel = UILabel.init(frame: CGRectMake(xPos, YPos, width, height))
        
        if (modulus == 0) {
            label.backgroundColor = UIColor.whiteColor()
        } else {
            label.backgroundColor = UIColor(hue: CGFloat(219 / HSB_CONSTANT), saturation: 0.1, brightness: 1.0, alpha: 1.0)
        }
        
        cell.backgroundView?.backgroundColor = UIColor.blackColor()
        cell.contentView.backgroundColor = UIColor.blackColor()
        cell.addColumn(CGFloat(columnPosition))
        label.font = UIFont.systemFontOfSize(20.0)
        label.textAlignment =  NSTextAlignment.Center
        label.textColor = UIColor.blackColor()
        label.text = String.init(format: " %@", property)
        cell.contentView.addSubview(label)
        return label
    }
    
    // MARK: - Action Methods
    
    override func setupUI() {
        if (self.element != nil) {
            if (self.tableView != nil) {
                self.tableView!.removeFromSuperview()
                self.tableView = nil
            }
            self.tableView = UITableView.init(frame: self.swapView.frame, style: UITableViewStyle.Plain)
            self.tableView!.alwaysBounceVertical = false
            self.tableView!.alwaysBounceHorizontal = false
            self.tableView!.dataSource = self
            self.tableView!.delegate = self
            self.tableView!.separatorStyle = UITableViewCellSeparatorStyle.None
            self.tableView!.backgroundColor = UIColor.blackColor()
            self.tableView!.backgroundView = UIView.init(frame: self.swapView.frame)
            self.tableView!.backgroundView!.backgroundColor = UIColor.blackColor()
            self.tableView!.opaque = false
            self.tableView!.rowHeight = 34.0
            self.tableView?.allowsSelection = false
            self.view.addSubview(self.tableView!)
            self.lineSpectraArray = self.element!.lineSpectra()
            self.tableView!.reloadData()
        }
        self.setupBarChart()
    }
    
    // MARK: - UITableView DataSource Methods
    
    func tableView(aTableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let row : Int = indexPath.row
        let MyIdentifier : String = String.init(format: "Column %i", [row])
        
        var cell : DynoTableCell? = aTableView.dequeueReusableCellWithIdentifier(MyIdentifier) as? DynoTableCell
        
        if (cell == nil) {
            let modulus : Int = row % 2
            let dict : NSDictionary = self.lineSpectraArray![row] as! NSDictionary
            let airWavelength : String = dict.valueForKey(kAirWavelength) as! String
            let intensity : String = dict.valueForKey(kIntensity) as! String
            let spectrum : String = dict.valueForKey(kSpectrum) as! String
            
            cell = DynoTableCell.init(style: UITableViewCellStyle.Default, reuseIdentifier: MyIdentifier)
            
            self.tableCellLabelWithXPos(0.0, YPos: 0.0, width: 124.0, height: 32.0, property: airWavelength, columnPosition: 1, modulus: modulus, cell: cell!)
            self.tableCellLabelWithXPos(125.0, YPos: 0.0, width: 115.0, height: 32.0, property: intensity, columnPosition: 2, modulus: modulus, cell: cell!)
            self.tableCellLabelWithXPos(241.0, YPos: 0.0, width: 117.0, height: 32.0, property: spectrum, columnPosition: 3, modulus: modulus, cell: cell!)
        }
        return cell!
    }
    
    func numberOfSectionsInTableView(aTableView : UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return element!.lineSpectra()!.count
    }
    
    // MARK: - Plot Data Source Methods
    
    func numberOfRecordsForPlot(plot: CPTPlot) -> UInt {
        return UInt(self.lineSpectraArray!.count)
    }
    
    func numberForPlot(plot: CPTPlot, field fieldEnum: UInt, recordIndex idx: UInt) -> AnyObject? {
        var num : NSNumber?
        
        if (plot.isKindOfClass(CPTBarPlot.classForCoder())) {
            let anItem : NSDictionary = self.lineSpectraArray!.objectAtIndex(Int(idx)) as! NSDictionary
            var temp : String = anItem.valueForKey(kAirWavelength) as! String
            let airWavelength : NSNumber = Float(temp)!

            temp = anItem.valueForKey(kIntensity) as! String
            let intensity : NSNumber = Float(temp)!
            let spectrum : String = anItem.valueForKey(kSpectrum) as! String
            let identifier : String = plot.identifier as! String
            
            switch (fieldEnum) {
            case 0:
                num = self.airWavelengthValue(airWavelength, anIdentifier: identifier, aSpectrum: spectrum)
            case 1:
                num = self.intensityValue(intensity, anIdentifier: identifier, aSpectrum: spectrum)
            default:
                num = 0
                break
            }
        }
        return num
    }
    
    func barFillForBarPlot(barPlot: CPTBarPlot, recordIndex: NSInteger) -> CPTFill? {
        return nil
    }
    
    // MARK: - View Management Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.swapView.removeFromSuperview()
    }
    
    override func shouldAutorotate() -> Bool {
        return true
    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return [UIInterfaceOrientationMask.LandscapeLeft, UIInterfaceOrientationMask.LandscapeRight]
    }
    
    // MARK: - Memory Management Methods
    
    deinit {
        self.tableView!.delegate = nil
        self.tableView = nil
        self.hostingView = nil
        self.swapView = nil
    }
}
