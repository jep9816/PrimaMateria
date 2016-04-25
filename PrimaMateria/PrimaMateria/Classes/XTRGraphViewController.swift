//
//  XTRGraphViewController.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 4/22/16.
//  Copyright © 2016 xTrensa. All rights reserved.
//

@objc class XTRGraphViewController : UIViewController, CPTPlotDataSource, CPTBarPlotDelegate {
    @IBOutlet weak var hostingView : CPTGraphHostingView!
    @IBOutlet weak var button : UIBarButtonItem!
    
    var barChart : CPTXYGraph?
    var errorString : String?
    
    static let ATTRIBUTE_NAME : String = "attributeName"
    static let TITLE : String = "title"
    static let MAJOR_TICK_MARKS : String = "majorTickMarks"
    static let MINOR_TICK_MARKS : String = "minorTickMarks"
    static let MAXIMUM_VALUE : String = "maximumValue"
    static let MINIMUM_VALUE : String = "minimumValue"
    
    // MARK: - Initialization Methods
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    // MARK: - Internal Methods
    
    func creatBarChart() {
        self.barChart = CPTXYGraph(frame: CGRectZero)
        self.barChart!.applyTheme(CPTTheme(named: kCPTSlateTheme))
        
        self.hostingView.hostedGraph = self.barChart
        
        self.barChart!.plotAreaFrame!.masksToBorder = false
        self.barChart!.paddingLeft = 100.0
        self.barChart!.paddingTop = 10.0
        self.barChart!.paddingRight = 0.0
        self.barChart!.paddingBottom = 80.0
        self.barChart!.delegate = self
    }
    
    func createXAxis(axisSet :CPTXYAxisSet, majorTickStyle: CPTLineStyle,  minorTickStyle: CPTLineStyle) {
        let x : CPTXYAxis = axisSet.xAxis!
        let customTickLocations: NSArray = [1, 10, 20, 30,  40, 50, 60, 70, 80, 90, 100, 110]
        let xAxisLabels : NSArray = ["1", "10", "20", "30", "40", "50", "60", "70", "80", "90", "100", "110"]
        let customLabels : NSMutableArray = []
        let textStyle : CPTMutableTextStyle = CPTMutableTextStyle.init()
        
        textStyle.color = CPTColor.blackColor()
        textStyle.fontName = "Verdana-Bold"
        textStyle.fontSize = 18.0
        textStyle.textAlignment = CPTTextAlignment.Center

        x.axisLineStyle = nil
        x.minorTicksPerInterval = 10
        x.majorTickLineStyle = majorTickStyle
        x.minorTickLineStyle = minorTickStyle
        x.majorIntervalLength = 1
        x.majorGridLineStyle = minorTickStyle
        x.orthogonalPosition = 0
        x.title = "Atomic Number"
        x.titleLocation = Int(XTRDataSource.sharedInstance().elementCount() / 2)
        x.titleOffset = 30.0
        x.titleTextStyle = textStyle

        // Define some custom labels for the data elements
        x.labelRotation = (CGFloat)(M_PI / 4)
        x.labelingPolicy = CPTAxisLabelingPolicy.None
        
        for index in 0...customTickLocations.count - 1 {
            let tickLocation : NSNumber = customTickLocations.objectAtIndex(index) as! NSNumber
            let labelValue : String = xAxisLabels.objectAtIndex(Int(index)) as! String
            let newLabel : CPTAxisLabel = CPTAxisLabel.init(text: labelValue, textStyle: x.labelTextStyle)
            newLabel.tickLocation = tickLocation
            newLabel.offset = x.labelOffset + x.majorTickLength
            newLabel.rotation = (CGFloat)(M_PI / 4)
            customLabels[index] = newLabel
        }
        let aSet = NSSet.init(array: customLabels as [AnyObject])
        x.axisLabels =  aSet as? Set<CPTAxisLabel>
    }
    
    func createYAxis(axisSet: CPTXYAxisSet, minorTicks: CGFloat, majorTickStyle: CPTLineStyle, minorTickStyle: CPTLineStyle, majorTicks: CGFloat, dict: NSDictionary, maxValue: CGFloat, minValue: CGFloat) {
        let y : CPTXYAxis = axisSet.yAxis!
        let title : String = (dict.objectForKey(XTRGraphViewController.TITLE) as? String)!
        let textStyle : CPTMutableTextStyle = CPTMutableTextStyle.init()
        
        textStyle.color = CPTColor.blackColor()
        textStyle.fontName = "Verdana-Bold"
        textStyle.fontSize = 18.0
        textStyle.textAlignment = CPTTextAlignment.Center

        y.axisLineStyle = nil
        y.minorTicksPerInterval = UInt(minorTicks)
        y.majorTickLineStyle = majorTickStyle
        y.minorTickLineStyle = minorTickStyle
        y.majorIntervalLength = UInt(majorTicks)
        y.majorGridLineStyle = minorTickStyle
        y.orthogonalPosition = 0
        y.title = title
        y.titleOffset = 65.0
        y.titleLocation = (maxValue / 2)
        y.labelingOrigin = minValue
        y.titleTextStyle = textStyle
    }
    
    func element(anElement: XTRElement, anIdentifier: String) -> NSNumber {
        let aValue : NSNumber? = anElement.valueForKey(anIdentifier) as? NSNumber
        return (aValue != nil) ? aValue! : 0
    }
    
    func showElementPanelForElementAtIndex(anIndex: Int) {
        XTRPropertiesStore.storeViewTitle(self.title)
        XTRPropertiesStore.storeAtomicNumber(anIndex)
        self.performSegueWithIdentifier(SHOW_INSPECTOR_FROM_GRAPH_VIEW, sender: self)
    }
    
    func showGraphForChoiceAtIndex(anIndex: UInt) {
        let dict : NSDictionary = XTRDataSource.sharedInstance().graphPropertyList!.objectAtIndex(Int(anIndex)) as! NSDictionary
        let minValue : CGFloat  = dict.objectForKey(XTRGraphViewController.MINIMUM_VALUE) as! CGFloat
        let maxValue : CGFloat  = dict.objectForKey(XTRGraphViewController.MAXIMUM_VALUE) as! CGFloat
        let majorTicks : CGFloat  = dict.objectForKey(XTRGraphViewController.MAJOR_TICK_MARKS) as! CGFloat
        let minorTicks : CGFloat  = dict.objectForKey(XTRGraphViewController.MINOR_TICK_MARKS) as! CGFloat
        let majorTickStyle : CPTMutableLineStyle = CPTMutableLineStyle.init()
        let minorTickStyle : CPTMutableLineStyle = CPTMutableLineStyle.init()
        let length : Int = Int(XTRDataSource.sharedInstance().elementCount() + 1)

        self.creatBarChart()

        let plotSpace : CPTXYPlotSpace = self.barChart!.defaultPlotSpace as! CPTXYPlotSpace
        let axisSet : CPTXYAxisSet = self.barChart!.axisSet as! CPTXYAxisSet
        let barPlot : XTRBarPlot = XTRBarPlot.tubularBarPlotWithColor(CPTColor.whiteColor(), horizontalBars: false)
        
        plotSpace.yRange = CPTPlotRange.init(location: minValue, length: maxValue)
        plotSpace.xRange = CPTPlotRange.init(location: 0.0, length: length)
        majorTickStyle.lineWidth = 2.0
        majorTickStyle.lineColor = CPTColor.darkGrayColor()
        
        minorTickStyle.lineWidth = 1.0
        minorTickStyle.lineColor = CPTColor.darkGrayColor()
        
        self.createXAxis(axisSet, majorTickStyle: majorTickStyle, minorTickStyle: minorTickStyle)
        self.createYAxis(axisSet, minorTicks: minorTicks, majorTickStyle: majorTickStyle, minorTickStyle: minorTickStyle, majorTicks: majorTicks, dict: dict, maxValue: maxValue, minValue: minValue)
        
        barPlot.element = XTRDataSource.sharedInstance().elementAtIndex(anIndex)
        barPlot.delegate = self
        barPlot.barWidth = 1.0
        barPlot.baseValue = 0
        barPlot.dataSource = self
        barPlot.barOffset = 0.0
        barPlot.identifier = dict.objectForKey(XTRGraphViewController.ATTRIBUTE_NAME) as! String
        barPlot.barCornerRadius = 0.0
        
        self.barChart?.addPlot(barPlot, toPlotSpace: plotSpace)
    }
    
    func dataForResource(aResourceName: String, type: String, directory: String) -> NSData {
        return NSData.init(contentsOfFile: NSBundle(forClass: self.classForCoder).pathForResource(aResourceName, ofType: type, inDirectory: directory)!)!
    }
    
    // MARK: - Action Methods
    
    @IBAction func toolbarItemTapped(sender: UIBarButtonItem) {
        let content : XTRGraphChoiceViewController = XTRAppDelegate.storyboard().instantiateViewControllerWithIdentifier("XTRGraphChoiceViewController") as! XTRGraphChoiceViewController
        let contentSize : CGSize  = CGSizeMake(294, 664)
        
        content.modalPresentationStyle = UIModalPresentationStyle.Popover
        content.popoverPresentationController!.barButtonItem = sender
        content.popoverPresentationController!.backgroundColor = XTRColorFactory.popupArrowColor()
        content.preferredContentSize = contentSize
        
        self.presentViewController(content, animated: true, completion: nil)
    }
    
    // MARK: - Notification Methods
    
    func graphSelected(notification: NSNotification) {
        let object : NSNumber = notification.object as! NSNumber
        
        self.dismissViewControllerAnimated(true, completion: nil)
        self.showGraphForChoiceAtIndex(UInt(object))
    }
    
    // MARK: - Plot Data Source Methods
    
    func numberOfRecordsForPlot(plot: CPTPlot) -> UInt {
        return UInt(XTRDataSource.sharedInstance().elementCount())
    }
    
    func numberForPlot(plot: CPTPlot, field fieldEnum: UInt, recordIndex idx: UInt) -> AnyObject? {
        var num : NSNumber? = 0
        
        if (plot.isKindOfClass(CPTBarPlot.classForCoder())) {
            let element : XTRElement = XTRDataSource.sharedInstance().elementAtIndex(idx)
            let identifier : String = plot.identifier as! String
            
            switch (fieldEnum){
            case 0:
                num = UInt(idx + 1)
                break
                
            case 1:
                if (identifier == ELEMENT_ATOMIC_MASS) {
                    num = element.atomicMass()
                } else if (identifier == ELEMENT_ATOMIC_RADIUS) {
                    num = element.atomicRadius()
                } else if (identifier == ELEMENT_BOILING_POINT) {
                    num = element.boilingPoint()
                } else if (identifier == ELEMENT_COEFFICIENT_OF_LINEAL_THERMAL_EXPANSION) {
                    num = element.coefficientOfLinealThermalExpansionScaled()
                } else if (identifier == ELEMENT_COVALENT_RADIUS) {
                    num = element.covalentRadius()
                } else if (identifier == ELEMENT_CROSS_SECTION) {
                    num = element.crossSection()
                } else if (identifier == ELEMENT_DENSITY) {
                    num = element.density()
                } else if (identifier == ELEMENT_ELASTIC_MODULUS_BULK) {
                    num = element.elasticModulusBulk()
                } else if (identifier == ELEMENT_ELASTIC_MODULUS_RIGIDITY) {
                    num = element.elasticModulusRigidity()
                } else if (identifier == ELEMENT_ELASTIC_MODULUS_YOUNGS) {
                    num = element.elasticModulusYoungs()
                } else if (identifier == ELEMENT_ELECTRO_CHEMICAL_EQUIVALENT) {
                    num = element.electroChemicalEquivalent()
                } else if (identifier == ELEMENT_ELECTRO_NEGATIVITY) {
                    num = element.electroNegativity()
                } else if (identifier == ELEMENT_ELECTRON_WORK_FUNCTION) {
                    num = element.electronWorkFunction()
                } else if (identifier == ELEMENT_MELTING_POINT) {
                    num = element.meltingPoint()
                } else if (identifier == ELEMENT_ENTHALPY_OF_ATOMIZATION) {
                    num = element.enthalpyOfAutomization()
                } else if (identifier == ELEMENT_ENTHALPY_OF_FUSION) {
                    num = element.enthalpyOfFusion()
                } else if (identifier == ELEMENT_ENTHALPY_OF_VAPORIZATION) {
                    num = element.enthalpyOfVaporization()
                } else if (identifier == ELEMENT_IONIC_RADIUS) {
                    num = element.ionicRadius()
                } else if (identifier == ELEMENT_HARDNESS_SCALE_BRINELL) {
                    num = element.hardnessScaleBrinell()
                } else if (identifier == ELEMENT_HARDNESS_SCALE_MOHS) {
                    num = element.hardnessScaleMohs()
                } else if (identifier == ELEMENT_HARDNESS_SCALE_VICKERS) {
                    num = element.hardnessScaleVickers()
                } else if (identifier == ELEMENT_HEAT_OF_FUSION) {
                    num = element.heatOfFusion()
                } else if (identifier == ELEMENT_HEAT_OF_VAPORIZATION) {
                    num = element.heatOfVaporization()
                } else if (identifier == ELEMENT_IONIZATION_POTENTIAL_FIRST) {
                    num = element.ionizationPotentialFirst()
                } else if (identifier == ELEMENT_IONIZATION_POTENTIAL_SECOND) {
                    num = element.ionizationPotentialSecond()
                } else if (identifier == ELEMENT_IONIZATION_POTENTIAL_THIRD) {
                    num = element.ionizationPotentialThird()
                } else if (identifier == ELEMENT_MOLAR_HEAT_CAPACITY) {
                    num = element.molarHeatCapacity()
                } else if (identifier == ELEMENT_MOLAR_VOLUME) {
                    num = element.molarVolume()
                } else if (identifier == ELEMENT_SPECIFIC_HEAT_CAPACITY) {
                    num = element.specificHeatCapacity()
                } else if (identifier == ELEMENT_VALENCE_ELECTRON_POTENTIAL) {
                    num = element.valenceElectronPotential()
                } else {
                    num = 0
                }
                break
            default:
                num = 0
                break
            }
        }
        
        return num
    }
    
    func barPlot(plot: CPTBarPlot, barWasSelectedAtRecordIndex index: UInt) {
        self.showElementPanelForElementAtIndex(Int(index))
    }
    
    func barFillForBarPlot(barPlot: CPTBarPlot, recordIndex: UInt) -> CPTFill {
        let element : XTRElement = XTRDataSource.sharedInstance().elementAtIndex(recordIndex)
        return CPTFill.init(color: CPTColor(CGColor: element.seriesColor().CGColor))
    }
    
    // MARK: - View Management Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(XTRGraphViewController.graphSelected(_:)), name: NOTIFICATION_GRAPH_SELECTED, object: nil)
        self.showGraphForChoiceAtIndex(0)
    }
    
    override func shouldAutorotate() -> Bool {
        return true
    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return [UIInterfaceOrientationMask.LandscapeLeft, UIInterfaceOrientationMask.LandscapeRight]
    }
    
    // MARK: - Memory Management Methods
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: NOTIFICATION_GRAPH_SELECTED, object: nil)
        self.button = nil
        self.hostingView = nil
    }
}
