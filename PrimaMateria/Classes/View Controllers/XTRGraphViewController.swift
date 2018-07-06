//
//  XTRGraphViewController.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 4/22/16.
//  Copyright ©2017 xTrensa. All rights reserved.
//

import CorePlot

struct GraphAttribute {
    static let name = "attributeName"
    static let title = "title"
    static let majorTickMarks = "majorTickMarks"
    static let minorTickMarks = "minorTickMarks"
    static let maximumValue = "maximumValue"
    static let minimumValue = "minimumValue"
}

class XTRGraphViewController : UIViewController, CPTPlotDataSource, CPTBarPlotDelegate {
    
    let customTickLocations = [1, 10, 20, 30,  40, 50, 60, 70, 80, 90, 100, 110]
    let xAxisLabels = ["1", "10", "20", "30", "40", "50", "60", "70", "80", "90", "100", "110"]

    @IBOutlet var barButtonItem : UIBarButtonItem!
    @IBOutlet var hostingView : CPTGraphHostingView!
    @IBOutlet var navigationBar: UINavigationBar!

    var barChart : CPTXYGraph?
    var errorString : String?
    
    //var delegate : XTRGraphViewControllerDelegate = XTRGraphViewControllerDelegate()
    
    // MARK: - Initialization Methods
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
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
        //barChart!.delegate = delegate
        barChart!.delegate = self
    }
    
    func createXAxis(_ axisSet :CPTXYAxisSet, majorTickStyle: CPTLineStyle,  minorTickStyle: CPTLineStyle) {
        let x = axisSet.xAxis!
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
        x.title = NSLocalizedString("atomicNumber", comment: "")
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
        let titleKey = dict[GraphAttribute.title] as? String
        let title = NSLocalizedString(titleKey!, comment: "")
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
    
    func element(_ anElement: XTRElementModel, anIdentifier: String) -> NSNumber {
        let aValue : NSNumber? = anElement.value(forKeyPath: anIdentifier) as? NSNumber
        return (aValue != nil) ? aValue! : 0
    }
    
    func showElementPanelForElementAtIndex(_ anIndex: Int) {
        XTRPropertiesStore.viewTitle = title!
        XTRPropertiesStore.atomicNumber = anIndex
        performSegue(withIdentifier: SegueName.showInspectorFromGraphView, sender: self)
    }
    
    func showGraphForChoiceAtIndex(_ anIndex: Int) {
        let dict = XTRDataSource.sharedInstance().graphPropertyList![anIndex]
        let minValue = dict[GraphAttribute.minimumValue] as! Float
        let maxValue = dict[GraphAttribute.maximumValue] as! Float
        let majorTicks = dict[GraphAttribute.majorTickMarks] as! Float
        let minorTicks = dict[GraphAttribute.minorTickMarks] as! Float
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
        createYAxis(axisSet, minorTicks: minorTicks, majorTickStyle: majorTickStyle, minorTickStyle: minorTickStyle, majorTicks: majorTicks, dict: dict, maxValue: maxValue, minValue: minValue)
        
        barPlot.element = XTRDataSource.sharedInstance().elementAtIndex(Int(anIndex))
        barPlot.delegate = self
        //barPlot.delegate = delegate
        barPlot.barWidth = 1.0
        barPlot.baseValue = 0
        barPlot.dataSource = self
        //barPlot.dataSource = delegate
        barPlot.barOffset = 0.0
        barPlot.identifier = dict[GraphAttribute.name] as! String as (NSCoding & NSCopying & NSObjectProtocol)?
        barPlot.barCornerRadius = 0.0
        
        barChart?.add(barPlot, to: plotSpace)
    }
    
    @objc func dataForResource(_ aResourceName: String, type: String, directory: String) -> Data {
        return try! Data(contentsOf: URL(fileURLWithPath: Bundle(for: classForCoder).path(forResource: aResourceName, ofType: type, inDirectory: directory)!))
    }
    
    // MARK: - Action Methods
    
    // MARK: - Notification Methods
    
    @objc func graphSelected(_ notification: Notification) {
        let object = notification.object as! NSNumber
        
        dismiss(animated: true, completion: nil)
        showGraphForChoiceAtIndex(object.intValue)
    }
    
    // MARK: - Plot Data Source Methods
    
    func numberOfRecords(for plot: CPTPlot) -> UInt {
        return UInt(XTRDataSource.sharedInstance().elementCount())
    }
    
    func number(for plot: CPTPlot, field fieldEnum: UInt, record idx: UInt) -> Any? {
        var num : NSNumber = 0
        
        if plot.isKind(of: CPTBarPlot.classForCoder()) {
            let element = XTRDataSource.sharedInstance().elementAtIndex(Int(idx))
            let identifier = plot.identifier as! String
            
            switch fieldEnum {
            case 0:
                num = NSNumber(value: idx + 1)
            case 1:
                switch identifier {
                case ELEMENT_ATOMIC_MASS :
                    num = NSNumber(value: element.atomicMass)
                case ELEMENT_ATOMIC_RADIUS :
                    num = NSNumber(value: element.atomicRadius)
                case ELEMENT_BOILING_POINT :
                    num = NSNumber(value: element.boilingPoint)
                case ELEMENT_COEFFICIENT_OF_LINEAL_THERMAL_EXPANSION :
                    num = NSNumber(value: element.coefficientOfLinealThermalExpansionScaled)
                case ELEMENT_COVALENT_RADIUS :
                    num = NSNumber(value: element.covalentRadius)
                case ELEMENT_CROSS_SECTION :
                    num = NSNumber(value: element.crossSection)
                case ELEMENT_DENSITY :
                    num = NSNumber(value: element.density)
                case ELEMENT_ELASTIC_MODULUS_BULK :
                    num = NSNumber(value: element.elasticModulusBulk)
                case ELEMENT_ELASTIC_MODULUS_RIGIDITY :
                    num = NSNumber(value: element.elasticModulusRigidity)
                case ELEMENT_ELASTIC_MODULUS_YOUNGS :
                    num = NSNumber(value: element.elasticModulusYoungs)
                case ELEMENT_ELECTRO_CHEMICAL_EQUIVALENT :
                    num = NSNumber(value: element.electroChemicalEquivalent)
                case ELEMENT_ELECTRO_NEGATIVITY :
                    num = NSNumber(value: element.electroNegativity)
                case ELEMENT_ELECTRON_WORK_FUNCTION :
                    num = NSNumber(value: element.electronWorkFunction)
                case ELEMENT_MELTING_POINT :
                    num = NSNumber(value: element.meltingPoint)
                case ELEMENT_ENTHALPY_OF_ATOMIZATION :
                    num = NSNumber(value: element.enthalpyOfAutomization)
                case ELEMENT_ENTHALPY_OF_FUSION :
                    num = NSNumber(value: element.enthalpyOfFusion)
                case ELEMENT_ENTHALPY_OF_VAPORIZATION :
                    num = NSNumber(value: element.enthalpyOfVaporization)
                case ELEMENT_IONIC_RADIUS :
                    num = NSNumber(value: element.ionicRadius)
                case ELEMENT_HARDNESS_SCALE_BRINELL :
                    num = NSNumber(value: element.hardnessScaleBrinell)
                case ELEMENT_HARDNESS_SCALE_MOHS :
                    num = NSNumber(value: element.hardnessScaleMohs)
                case ELEMENT_HARDNESS_SCALE_VICKERS :
                    num = NSNumber(value: element.hardnessScaleVickers)
                case ELEMENT_HEAT_OF_FUSION :
                    num = NSNumber(value: element.heatOfFusion)
                case ELEMENT_HEAT_OF_VAPORIZATION :
                    num = NSNumber(value: element.heatOfVaporization)
                case ELEMENT_IONIZATION_POTENTIAL_FIRST :
                    num = NSNumber(value: element.ionizationPotentialFirst)
                case ELEMENT_IONIZATION_POTENTIAL_SECOND :
                    num = NSNumber(value: element.ionizationPotentialSecond)
                case ELEMENT_IONIZATION_POTENTIAL_THIRD :
                    num = NSNumber(value: element.ionizationPotentialThird)
                case ELEMENT_MOLAR_HEAT_CAPACITY :
                    num = NSNumber(value: element.molarHeatCapacity)
                case ELEMENT_MOLAR_VOLUME :
                    num = NSNumber(value: element.molarVolume)
                case ELEMENT_SPECIFIC_HEAT_CAPACITY :
                    num = NSNumber(value: element.specificHeatCapacity)
                case ELEMENT_VALENCE_ELECTRON_POTENTIAL :
                    num = NSNumber(value: element.valenceElectronPotential)
                default :
                    num = 0
                }
            default:
                num = 0
            }
        }
        
        return num
    }
    
    func barPlot(_ plot: CPTBarPlot, barWasSelectedAtRecord index: UInt) {
        showElementPanelForElementAtIndex(Int(index))
    }
    
    @objc func barFillForBarPlot(_ barPlot: CPTBarPlot, recordIndex: UInt) -> CPTFill {
        let element = XTRDataSource.sharedInstance().elementAtIndex(Int(recordIndex))
        return CPTFill(color: CPTColor(cgColor: element.seriesColor.cgColor))
    }
    
    // MARK: - View Management Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = NSLocalizedString("graphs", comment: "")
        navigationBar.topItem?.title = NSLocalizedString("graphs", comment: "")
        barButtonItem.title = NSLocalizedString("chooseGraph", comment: "")

        //delegate.controller = self
        NotificationCenter.default.addObserver(self, selector: #selector(XTRGraphViewController.graphSelected(_:)), name: .graphSelectedNotification, object: nil)
        
        showGraphForChoiceAtIndex(0)
        navigationController?.navigationBar.prefersLargeTitles = true
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
        barButtonItem = nil
        hostingView = nil
    }
    
}
