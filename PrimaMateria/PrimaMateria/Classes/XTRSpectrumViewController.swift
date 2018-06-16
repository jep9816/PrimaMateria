//
//  XTRSpectrumViewController.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 4/17/16.
//  Copyright ©2018 xTrensa. All rights reserved.
//

enum SpectrumAttribute {
    static let kAirWavelength = "airWavelength"
    static let kIntensity = "intensity"
    static let kSpectrum = "spectrum"
    static let kISpectrum = "I"
    static let kIISpectrum = "II"
    static let kIIISpectrum = "III"
    static let kIVSpectrum = "IV"
    static let kVSpectrum = "V"
}

class XTRSpectrumViewController : XTRSwapableViewController, UITableViewDelegate, UITableViewDataSource, CPTPlotDataSource {
    
    @IBOutlet var hostingView : CPTGraphHostingView!
    @IBOutlet var swapView : UIView!
    
    var barChart : CPTXYGraph?
    var lineSpectraArray : [[String : AnyObject]]?
    var tableView : UITableView?
    
    // MARK: - Initialization Methods
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    // MARK: - Internal Methods
    
    func airWavelengthValue(_ anAirWavelength: Float, anIdentifier: String, aSpectrum: String) -> Float {
        return aSpectrum.hasSuffix("\(anIdentifier)") ? anAirWavelength : 0
    }
    
    func addSpectrumPlotWithIdentifier(_ anIdentifier : String, aColor: CPTColor) -> CPTBarPlot {
        let barPlot = CPTBarPlot.tubularBarPlot(with: aColor, horizontalBars: false)
        barPlot.barWidth = 20.0
        barPlot.baseValue = 1
        barPlot.dataSource = self
        barPlot.barOffset = 0.0
        barPlot.identifier = anIdentifier as (NSCoding & NSCopying & NSObjectProtocol)?
        return barPlot
    }
    
    func intensityValue(_ anIntensity: Float, anIdentifier: String, aSpectrum: String) -> Float {
        return aSpectrum.hasSuffix("\(anIdentifier)") ? anIntensity : 0
    }
    
    func setupBarChart() {
        // Create barChart from theme
        barChart = CPTXYGraph.init(frame: CGRect.zero)
        barChart!.apply(CPTTheme(named: CPTThemeName.slateTheme))
        hostingView.hostedGraph = barChart
        barChart!.plotAreaFrame!.masksToBorder = false
        
        barChart!.paddingLeft = 100.0
        barChart!.paddingTop = 10.0
        barChart!.paddingRight = 5.0
        barChart!.paddingBottom = 60.0

        let plotSpace = barChart!.defaultPlotSpace as! CPTXYPlotSpace
        let majorTickStyle = CPTMutableLineStyle.init()
        let minorTickStyle = CPTMutableLineStyle.init()
        let axisSet = barChart!.axisSet as! CPTXYAxisSet
        let x = axisSet.xAxis!
        let y = axisSet.yAxis!
        let customTickLocations = [4000, 4500, 5000, 5500, 6000, 6500, 7000, 7500]
        let xAxisLabels = ["4000", "4500", "5000", "5500", "6000", "6500", "7000", "7500"]
        var labelLocation = 0
        var customLabels : [AnyObject?] = [AnyObject?](repeating: nil, count: xAxisLabels.count)
        
        // Add plot space for horizontal bar charts
        plotSpace.yRange = CPTPlotRange(location: 0.0, length: 1000.0)
        plotSpace.xRange = CPTPlotRange(location: 4000.0, length: 3500.0)
        
        majorTickStyle.lineWidth = 2.0
        majorTickStyle.lineColor = CPTColor.green()
        minorTickStyle.lineWidth = 1.0
        minorTickStyle.lineColor = CPTColor.green()
        
        x.axisLineStyle = nil
        x.minorTicksPerInterval = 2
        x.majorTickLineStyle = majorTickStyle
        x.minorTickLineStyle = minorTickStyle
        x.majorIntervalLength = 500
        x.majorGridLineStyle = minorTickStyle
        x.orthogonalPosition = 0
        x.title = "Wave Length Å"
        x.titleLocation = 5750.0
        x.titleOffset = 30.0
        
        // Define some custom labels for the data elements
        x.labelRotation = CGFloat.pi / 4.0
        x.labelingPolicy = CPTAxisLabelingPolicy.none
        
        for index in 0..<customTickLocations.count {
            labelLocation += labelLocation
            let newLabel = CPTAxisLabel.init(text: xAxisLabels[labelLocation], textStyle: x.labelTextStyle)
            let tickLocation = customTickLocations[index] as NSNumber
            newLabel.tickLocation = tickLocation
            newLabel.offset = x.labelOffset + x.majorTickLength
            newLabel.rotation = CGFloat.pi / 4.0
            customLabels.append(newLabel)
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
        
        var barPlot = addSpectrumPlotWithIdentifier(SpectrumAttribute.kISpectrum, aColor: CPTColor.red())
        
        barChart!.add(barPlot, to: plotSpace)
        
        barPlot = addSpectrumPlotWithIdentifier(SpectrumAttribute.kIISpectrum, aColor: CPTColor.blue())
        barChart!.add(barPlot, to: plotSpace)
        
        barPlot = addSpectrumPlotWithIdentifier(SpectrumAttribute.kIIISpectrum, aColor: CPTColor.green())
        barChart!.add(barPlot, to: plotSpace)
        
        barPlot = addSpectrumPlotWithIdentifier(SpectrumAttribute.kIVSpectrum, aColor: CPTColor.cyan())
        barChart!.add(barPlot, to: plotSpace)
        
        barPlot = addSpectrumPlotWithIdentifier(SpectrumAttribute.kVSpectrum, aColor: CPTColor.magenta())
        barChart!.add(barPlot, to: plotSpace)
    }
    
    func tableCellLabelWithXPos(_ xPos : CGFloat, YPos: CGFloat, width: CGFloat, height: CGFloat, property: String, columnPosition: Int, modulus: Int, cell: XTRTableCell) {
        let label = UILabel(frame: CGRect(x: xPos, y: YPos, width: width, height: height))
        
        label.backgroundColor = (modulus == 0) ? UIColor.white : XTRColorFactory.rowColor
        
        cell.backgroundView?.backgroundColor = UIColor.black
        cell.contentView.backgroundColor = UIColor.black
        cell.addColumn(columnPosition)
        label.font = UIFont.systemFont(ofSize: 20.0)
        label.textAlignment = .center
        label.textColor = UIColor.black
        label.text = " \(property)"
        cell.contentView.addSubview(label)
    }
    
    // MARK: - Action Methods
    
    override func setupUI() {
        if element != nil {
            if tableView != nil {
                tableView!.removeFromSuperview()
                tableView = nil
            }
            
            tableView = UITableView(frame: swapView.frame, style: .plain)
            tableView!.alwaysBounceVertical = false
            tableView!.alwaysBounceHorizontal = false
            tableView!.dataSource = self
            tableView!.delegate = self
            tableView!.separatorStyle = .none
            tableView!.backgroundColor = UIColor.black
            tableView!.backgroundView = UIView(frame: swapView.frame)
            tableView!.backgroundView!.backgroundColor = UIColor.black
            tableView!.isOpaque = false
            tableView!.rowHeight = 34.0
            tableView!.allowsSelection = false
            view.addSubview(tableView!)
            lineSpectraArray = element!.lineSpectra
            tableView!.reloadData()
        }
        setupBarChart()
    }
    
    // MARK: - Plot Data Source Methods
    
    func numberOfRecords(for plot: CPTPlot) -> UInt {
        return UInt(lineSpectraArray!.count)
    }
    
    func number(for plot: CPTPlot, field fieldEnum: UInt, record idx: UInt) -> Any? {
        var num : Float?
        
        if plot.isKind(of: CPTBarPlot.classForCoder()) {
            let dict = lineSpectraArray![Int(idx)]
            let airWavelength = Float(dict[SpectrumAttribute.kAirWavelength] as! String)!
            let intensity = Float(dict[SpectrumAttribute.kIntensity] as! String)!
            let spectrum = dict[SpectrumAttribute.kSpectrum] as! String
            let identifier = plot.identifier as! String
            
            switch (fieldEnum) {
            case 0:
                num = airWavelengthValue(airWavelength, anIdentifier: identifier, aSpectrum: spectrum)
            case 1:
                num = intensityValue(intensity, anIdentifier: identifier, aSpectrum: spectrum)
            default:
                num = 0
                break
            }
        }
        return num
    }
    
    func barFillForBarPlot(_ barPlot: CPTBarPlot, recordIndex: NSInteger) -> CPTFill? {
        return nil
    }
    
    // MARK: - View Management Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        swapView.removeFromSuperview()
    }
    
    override var shouldAutorotate : Bool {
        return false
    }
    
    override var supportedInterfaceOrientations : UIInterfaceOrientationMask {
        return .landscape
    }
    
    // MARK: - Memory Management Methods
    
    deinit {
        tableView!.delegate = nil
        tableView = nil
        hostingView = nil
        swapView = nil
    }
    
}

extension XTRSpectrumViewController { // UITableView DataSource Methods
    
    func tableView(_ aTableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        let MyIdentifier = "Column \(row)"
        
        var cell : XTRTableCell? = aTableView.dequeueReusableCell(withIdentifier: MyIdentifier) as? XTRTableCell
        
        if cell == nil {
            let modulus = row % 2
            let dict = lineSpectraArray![row]
            let airWavelength = dict[SpectrumAttribute.kAirWavelength] as! String
            let intensity = dict[SpectrumAttribute.kIntensity] as! String
            let spectrum = dict[SpectrumAttribute.kSpectrum] as! String
            
            cell = XTRTableCell(style: .default, reuseIdentifier: MyIdentifier)
            
            tableCellLabelWithXPos(0.0, YPos: 0.0, width: 124.0, height: 32.0, property: airWavelength, columnPosition: 1, modulus: modulus, cell: cell!)
            tableCellLabelWithXPos(125.0, YPos: 0.0, width: 115.0, height: 32.0, property: intensity, columnPosition: 2, modulus: modulus, cell: cell!)
            tableCellLabelWithXPos(241.0, YPos: 0.0, width: 117.0, height: 32.0, property: spectrum, columnPosition: 3, modulus: modulus, cell: cell!)
        }
        return cell!
    }
    
    func numberOfSections(in aTableView : UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return element!.lineSpectra!.count
    }

}
