//
//  XTRSpectrumViewController.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 4/17/16.
//  Copyright ©2021 xTrensa. All rights reserved.
//

import CorePlot
import RxSwift
import RxCocoa

enum XTRSpectrumViewProperty {
    //static let kAirWavelength = "airWavelength"
    //static let kIntensity = "intensity"
    //static let kSpectrum = "spectrum"
    static let kISpectrum = "I"
    static let kIISpectrum = "II"
    static let kIIISpectrum = "III"
    static let kIVSpectrum = "IV"
    static let kVSpectrum = "V"
}

struct XTRSpectrumViewControllerConfig {
    static let name = "attributeName"
    static let title = "title"
    static let majorTickMarks = "majorTickMarks"
    static let minorTickMarks = "minorTickMarks"
    static let maximumValue = "maximumValue"
    static let minimumValue = "minimumValue"
    static let customTickLocations: [Int] = [4000, 4500, 5000, 5500, 6000, 6500, 7000, 7500]
}

class XTRSpectrumViewController: XTRSwapableViewController {

    @IBOutlet var hostingView: CPTGraphHostingView!
    @IBOutlet var tableView: UITableView!

    var barChart: CPTXYGraph?
    var lineSpectraArray: BehaviorRelay<[XTRSpectraModel]>?

    private var delegate: XTRSpectrumViewControllerDelegate? = XTRSpectrumViewControllerDelegate()

    // MARK: - Initialization Methods

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
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

    fileprivate func setupXAxis(_ x: CPTXYAxis, _ majorTickStyle: CPTMutableLineStyle, _ minorTickStyle: CPTMutableLineStyle) {
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
        x.labelRotation = CGFloat.pi / 4.0
        x.labelingPolicy = CPTAxisLabelingPolicy.none
    }

    fileprivate func setupYAxsis(_ y: CPTXYAxis, _ majorTickStyle: CPTMutableLineStyle, _ minorTickStyle: CPTMutableLineStyle) {
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
    }

    fileprivate func setupBarPlot(_ plotSpace: CPTXYPlotSpace) {
        var barPlot = addSpectrumPlotWithIdentifier(XTRSpectrumViewProperty.kISpectrum, aColor: CPTColor.red())

        barChart!.add(barPlot, to: plotSpace)

        barPlot = addSpectrumPlotWithIdentifier(XTRSpectrumViewProperty.kIISpectrum, aColor: CPTColor.blue())
        barChart!.add(barPlot, to: plotSpace)

        barPlot = addSpectrumPlotWithIdentifier(XTRSpectrumViewProperty.kIIISpectrum, aColor: CPTColor.green())
        barChart!.add(barPlot, to: plotSpace)

        barPlot = addSpectrumPlotWithIdentifier(XTRSpectrumViewProperty.kIVSpectrum, aColor: CPTColor.cyan())
        barChart!.add(barPlot, to: plotSpace)

        barPlot = addSpectrumPlotWithIdentifier(XTRSpectrumViewProperty.kVSpectrum, aColor: CPTColor.magenta())
        barChart!.add(barPlot, to: plotSpace)
    }

    func setupBarChart() {
        barChart = CPTXYGraph.init(frame: CGRect.zero)
        hostingView.hostedGraph = barChart

        barChart!.plotAreaFrame!.masksToBorder = false
        barChart!.apply(CPTTheme(named: CPTThemeName.slateTheme))
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
        var customLabels: [CPTAxisLabel] = [CPTAxisLabel]()

        plotSpace.yRange = CPTPlotRange(location: 0.0, length: 1000.0)
        plotSpace.xRange = CPTPlotRange(location: 4000.0, length: 3500.0)

        majorTickStyle.lineWidth = 2.0
        majorTickStyle.lineColor = CPTColor.green()
        minorTickStyle.lineWidth = 1.0
        minorTickStyle.lineColor = CPTColor.green()

        setupXAxis(x, majorTickStyle, minorTickStyle)

        for index in 0..<XTRSpectrumViewControllerConfig.customTickLocations.count {
            labelLocation += labelLocation
            let newLabel = CPTAxisLabel(text: String("\(XTRSpectrumViewControllerConfig.customTickLocations[labelLocation])"), textStyle: x.labelTextStyle)

            newLabel.tickLocation = NSNumber(value: XTRSpectrumViewControllerConfig.customTickLocations[index])
            newLabel.offset = x.labelOffset + x.majorTickLength
            newLabel.rotation = CGFloat.pi / 4.0
            customLabels.append(newLabel)
        }

        x.axisLabels = NSSet(array: customLabels) as? Set<CPTAxisLabel>

        setupYAxsis(y, majorTickStyle, minorTickStyle)

        setupBarPlot(plotSpace)
    }

    // MARK: - Action Methods

    override func setupUIForAnimation(element: XTRElementModel) {
        super.setupUIForAnimation(element: element)

        setupTableView(element: element)
        setupBarChart()
    }

    override func setupUI(element: XTRElementModel) {
        super .setupUI(element: element)

        setupTableView(element: element)
        setupBarChart()
    }

    func setupTableView(element: XTRElementModel) {
        lineSpectraArray = element.lineSpectraModels

        setupRx()
    }

    func setupRx() {
        tableView?.dataSource = nil
        lineSpectraArray?.bind(to: (tableView?.rx.items(cellIdentifier: XTR_TABLE_CELL_IDENTIFIER, cellType: XTRTableCell.self))!) { [weak self] (row, element, cell) in
            let modulus = row % 2

            self?.delegate?.createTableCellLabel(model: XTRTableViewCellViewModel(xPos: 0, yPos: 0, width: 124, height: 32, property: element.airWavelength, columnPosition: 1, modulus: modulus, cell: cell))
            self?.delegate?.createTableCellLabel(model: XTRTableViewCellViewModel(xPos: 125, yPos: 0, width: 115, height: 32, property: element.intensity, columnPosition: 2, modulus: modulus, cell: cell))
            self?.delegate?.createTableCellLabel(model: XTRTableViewCellViewModel(xPos: 241, yPos: 0, width: 117, height: 32, property: element.spectrum, columnPosition: 3, modulus: modulus, cell: cell))
            }
            .disposed(by: disposeBag)
    }

    // MARK: - View Management Methods

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.alwaysBounceVertical = false
        tableView.alwaysBounceHorizontal = false
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor.black
        tableView.isOpaque = false
        tableView.rowHeight = 34.0
        tableView.allowsSelection = false
        tableView.register(XTRTableCell.self, forCellReuseIdentifier: XTR_TABLE_CELL_IDENTIFIER)

        delegate?.controller = self
     }

    override var shouldAutorotate: Bool {
        return false
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscape
    }

    // MARK: - Memory Management Methods

    deinit {
        hostingView = nil
        tableView = nil
    }

}
