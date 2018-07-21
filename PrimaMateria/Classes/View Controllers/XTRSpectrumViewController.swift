//
//  XTRSpectrumViewController.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 4/17/16.
//  Copyright © 2018 xTrensa. All rights reserved.
//

import CorePlot
import RxSwift

enum XTRSpectrumViewControllerConfig {
    static let kAirWavelength = "airWavelength"
    static let kIntensity = "intensity"
    static let kSpectrum = "spectrum"
    static let kISpectrum = "I"
    static let kIISpectrum = "II"
    static let kIIISpectrum = "III"
    static let kIVSpectrum = "IV"
    static let kVSpectrum = "V"
}

class XTRSpectrumViewController: XTRSwapableViewController {
    
    @IBOutlet var hostingView: CPTGraphHostingView!
    @IBOutlet var swapView: UIView!
    
    var barChart: CPTXYGraph?
    var lineSpectraArray: Variable<[XTRSpectraModel]>?
    var tableView: UITableView?
    let customTickLocations = [4000, 4500, 5000, 5500, 6000, 6500, 7000, 7500]

    private var delegate: XTRSpectrumViewControllerDelegate? = XTRSpectrumViewControllerDelegate()

    // MARK: - Initialization Methods
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    // MARK: - Internal Methods
    
    func airWavelengthValue(_ anAirWavelength: Float, anIdentifier: String, aSpectrum: String) -> Float {
        return aSpectrum.hasSuffix("\(anIdentifier)") ? anAirWavelength: 0
    }
    
    func addSpectrumPlotWithIdentifier(_ anIdentifier: String, aColor: CPTColor) -> CPTBarPlot {
        let barPlot = CPTBarPlot.tubularBarPlot(with: aColor, horizontalBars: false)
        barPlot.barWidth = 20.0
        barPlot.baseValue = 1
        barPlot.dataSource = delegate
        barPlot.barOffset = 0.0
        barPlot.identifier = anIdentifier as (NSCoding & NSCopying & NSObjectProtocol)?
        return barPlot
    }
    
    func intensityValue(_ anIntensity: Float, anIdentifier: String, aSpectrum: String) -> Float {
        return aSpectrum.hasSuffix("\(anIdentifier)") ? anIntensity: 0
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
        var labelLocation = 0
        var customLabels: [AnyObject?] = [AnyObject?](repeating: nil, count: customTickLocations.count)
        
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
            let newLabel = CPTAxisLabel.init(text: String("\(customTickLocations[labelLocation])"), textStyle: x.labelTextStyle)
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
        y.title = NSLocalizedString("intensity", comment: "")
        y.titleOffset = 50.0
        y.titleLocation = 500.0
        
        var barPlot = addSpectrumPlotWithIdentifier(XTRSpectrumViewControllerConfig.kISpectrum, aColor: CPTColor.red())
        
        barChart!.add(barPlot, to: plotSpace)
        
        barPlot = addSpectrumPlotWithIdentifier(XTRSpectrumViewControllerConfig.kIISpectrum, aColor: CPTColor.blue())
        barChart!.add(barPlot, to: plotSpace)
        
        barPlot = addSpectrumPlotWithIdentifier(XTRSpectrumViewControllerConfig.kIIISpectrum, aColor: CPTColor.green())
        barChart!.add(barPlot, to: plotSpace)
        
        barPlot = addSpectrumPlotWithIdentifier(XTRSpectrumViewControllerConfig.kIVSpectrum, aColor: CPTColor.cyan())
        barChart!.add(barPlot, to: plotSpace)
        
        barPlot = addSpectrumPlotWithIdentifier(XTRSpectrumViewControllerConfig.kVSpectrum, aColor: CPTColor.magenta())
        barChart!.add(barPlot, to: plotSpace)
    }
    
    // MARK: - Action Methods
    
    override func setupUI(element: XTRElementModel) {
        super .setupUI(element: element)
        
        title = NSLocalizedString("spectrum", comment: "")
        
        if tableView != nil {
            tableView!.removeFromSuperview()
            tableView = nil
        }
        
        tableView = UITableView(frame: swapView.frame, style: .plain)
        tableView!.alwaysBounceVertical = false
        tableView!.alwaysBounceHorizontal = false
        tableView!.dataSource = delegate
        tableView!.delegate = delegate
        tableView!.separatorStyle = .none
        tableView!.backgroundColor = UIColor.black
        tableView!.backgroundView = UIView(frame: swapView.frame)
        tableView!.backgroundView!.backgroundColor = UIColor.black
        tableView!.isOpaque = false
        tableView!.rowHeight = 34.0
        tableView!.allowsSelection = false
        view.addSubview(tableView!)
        lineSpectraArray = element.lineSpectra
        tableView!.reloadData()
        setupBarChart()
    }
    
    // MARK: - View Management Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegate?.controller = self
        swapView.removeFromSuperview()
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscape
    }
    
    // MARK: - Memory Management Methods
    
    deinit {
        tableView = nil
        hostingView = nil
        swapView = nil
    }
    
}
