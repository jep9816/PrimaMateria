//
//  XTRGraphViewController.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 4/22/16.
//  Copyright ©2018 xTrensa. All rights reserved.
//

struct GraphAttribute {
    static let name = "attributeName"
    static let title = "title"
    static let majorTickMarks = "majorTickMarks"
    static let minorTickMarks = "minorTickMarks"
    static let maximumValue = "maximumValue"
    static let minimumValue = "minimumValue"
}

class XTRGraphViewController : UIViewController {
    
    @IBOutlet var hostingView : CPTGraphHostingView!
    @IBOutlet var button : UIBarButtonItem!
    
    var barChart : CPTXYGraph?
    var errorString : String?
    private var delegate : XTRGraphViewControllerDelegate = XTRGraphViewControllerDelegate()

    // MARK: - Initialization Methods
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SegueName.showGraphChoiceSegue {
            let dest = segue.destination
            let aFrame = CGRect(x: 0, y: 0, width: 298, height: 668)

            dest.view.frame = aFrame
            dest.preferredContentSize = CGSize(width: 298, height: 668)
        }
    }

    // MARK: - Internal Methods
    
    func creatBarChart() {
        barChart = CPTXYGraph(frame: CGRect.zero)
        barChart!.apply(CPTTheme(named: CPTThemeName.slateTheme))
        
        hostingView.hostedGraph = barChart
        
        barChart!.plotAreaFrame!.masksToBorder = false
        barChart!.paddingLeft = 100.0
        barChart!.paddingTop = 10.0
        barChart!.paddingRight = 0.0
        barChart!.paddingBottom = 80.0
        barChart!.delegate = delegate
    }
    
    func createXAxis(_ axisSet: CPTXYAxisSet, majorTickStyle: CPTLineStyle, minorTickStyle: CPTLineStyle) {
        let x = axisSet.xAxis!
        let customTickLocations = [1, 10, 20, 30,  40, 50, 60, 70, 80, 90, 100, 110]
        let xAxisLabels = ["1", "10", "20", "30", "40", "50", "60", "70", "80", "90", "100", "110"]
        var customLabels : [CPTAxisLabel] = []
        let textStyle = CPTMutableTextStyle.init()
        
        textStyle.color = CPTColor.black()
        textStyle.fontName = "Verdana-Bold"
        textStyle.fontSize = 18.0
        textStyle.textAlignment = CPTTextAlignment.center
        
        x.axisLineStyle = nil
        x.minorTicksPerInterval = 10
        x.majorTickLineStyle = majorTickStyle
        x.minorTickLineStyle = minorTickStyle
        x.majorIntervalLength = 1
        x.majorGridLineStyle = minorTickStyle
        x.orthogonalPosition = 0
        x.title = "Atomic Number"
        x.titleLocation = XTRDataSource.sharedInstance().elementCount() / 2 as NSNumber?
        x.titleOffset = 30.0
        x.titleTextStyle = textStyle
        
        // Define some custom labels for the data elements
        x.labelRotation = CGFloat.pi / 4.0
        x.labelingPolicy = CPTAxisLabelingPolicy.none
        
        for index in 0..<customTickLocations.count {
            let tickLocation = customTickLocations[index]
            let labelValue = xAxisLabels[index]
            let newLabel = CPTAxisLabel.init(text: labelValue, textStyle: x.labelTextStyle)
            newLabel.tickLocation = NSNumber(value: tickLocation)
            newLabel.offset = x.labelOffset + x.majorTickLength
            newLabel.rotation = CGFloat.pi / 4.0
            customLabels.append(newLabel)
        }
        
        let aSet = NSSet(array: customLabels as [AnyObject])
        x.axisLabels =  aSet as? Set<CPTAxisLabel>
    }
    
    func createYAxis(_ axisSet: CPTXYAxisSet, minorTicks: Float, majorTickStyle: CPTLineStyle, minorTickStyle: CPTLineStyle, majorTicks: Float, dict: [String : AnyObject], maxValue: Float, minValue: Float) {
        let y = axisSet.yAxis!
        let title = dict[GraphAttribute.title] as? String
        let textStyle = CPTMutableTextStyle.init()
        
        textStyle.color = CPTColor.black()
        textStyle.fontName = "Verdana-Bold"
        textStyle.fontSize = 18.0
        textStyle.textAlignment = CPTTextAlignment.center
        
        y.axisLineStyle = nil
        y.minorTicksPerInterval = UInt(minorTicks)
        y.majorTickLineStyle = majorTickStyle
        y.minorTickLineStyle = minorTickStyle
        y.majorIntervalLength = NSNumber(value: majorTicks)
        y.majorGridLineStyle = minorTickStyle
        y.orthogonalPosition = 0
        y.title = title
        y.titleOffset = 65.0
        y.titleLocation = NSNumber(value: maxValue / 2.0)
        y.labelingOrigin = NSNumber(value: minValue)
        y.titleTextStyle = textStyle
    }
    
    func element(_ anElement: XTRElement, anIdentifier: String) -> NSNumber {
        let aValue : NSNumber? = anElement.value(forKeyPath: anIdentifier) as? NSNumber
        return (aValue != nil) ? aValue! : 0
    }
        
    func showGraphForChoiceAtIndex(_ anIndex: UInt) {
        let dict = XTRDataSource.sharedInstance().graphPropertyList?[Int(anIndex)]
        let minValue = dict?[GraphAttribute.minimumValue] as! Float
        let maxValue = dict?[GraphAttribute.maximumValue] as! Float
        let majorTicks = dict?[GraphAttribute.majorTickMarks] as! Float
        let minorTicks = dict?[GraphAttribute.minorTickMarks] as! Float
        let majorTickStyle = CPTMutableLineStyle.init()
        let minorTickStyle = CPTMutableLineStyle.init()
        let length = XTRDataSource.sharedInstance().elementCount() + 1
        
        creatBarChart()
        
        let plotSpace = barChart!.defaultPlotSpace as! CPTXYPlotSpace
        let axisSet = barChart!.axisSet as! CPTXYAxisSet
        let barPlot = XTRBarPlot.tubularBarPlot(with: CPTColor.white(), horizontalBars: false)
        
        plotSpace.yRange = CPTPlotRange.init(location: NSNumber(value: Float(minValue)), length: NSNumber(value: Float(maxValue)))
        plotSpace.xRange = CPTPlotRange.init(location: 0.0, length: NSNumber(value: length))
        majorTickStyle.lineWidth = 2.0
        majorTickStyle.lineColor = CPTColor.darkGray()
        
        minorTickStyle.lineWidth = 1.0
        minorTickStyle.lineColor = CPTColor.darkGray()
        
        createXAxis(axisSet, majorTickStyle: majorTickStyle, minorTickStyle: minorTickStyle)
        createYAxis(axisSet, minorTicks: minorTicks, majorTickStyle: majorTickStyle, minorTickStyle: minorTickStyle, majorTicks: majorTicks, dict: dict!, maxValue: maxValue, minValue: minValue)
        
        barPlot.element = XTRDataSource.sharedInstance().elementAtIndex(Int(anIndex))
        barPlot.delegate = delegate
        barPlot.barWidth = 1.0
        barPlot.baseValue = 0
        barPlot.dataSource = delegate
        barPlot.barOffset = 0.0
        barPlot.identifier = dict?[GraphAttribute.name] as! String as (NSCoding & NSCopying & NSObjectProtocol)?
        barPlot.barCornerRadius = 0.0
        
        barChart?.add(barPlot, to: plotSpace)
    }
    
    func dataForResource(_ aResourceName: String, type: String, directory: String) -> Data {
        return try! Data(contentsOf: URL(fileURLWithPath: Bundle(for: classForCoder).path(forResource: aResourceName, ofType: type, inDirectory: directory)!))
    }
    
    // MARK: - Action Methods
        
    // MARK: - Notification Methods
    
    @objc func graphSelected(_ notification: Notification) {
        let object = notification.object as! NSNumber
        
        dismiss(animated: true, completion: nil)
        showGraphForChoiceAtIndex(UInt(object.intValue))
    }
        
    // MARK: - View Management Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(XTRGraphViewController.graphSelected(_:)), name: .graphSelectedNotification, object: nil)
        
        showGraphForChoiceAtIndex(0)
        navigationController?.navigationBar.prefersLargeTitles = true
        delegate.closure = { [weak self] (index: Int) -> Void in
            XTRPropertiesStore.viewTitle = (self?.title)!
            XTRPropertiesStore.atomicNumber = index
            self?.performSegue(withIdentifier: SegueName.showInspectorFromGraphView, sender: self)
        }
    }
    
    override var shouldAutorotate : Bool {
        return false
    }
    
    override var supportedInterfaceOrientations : UIInterfaceOrientationMask {
        return .landscape
    }
    
    // MARK: - Memory Management Methods
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: .graphSelectedNotification, object: nil)
        button = nil
        hostingView = nil
    }
    
}
