//
//  XTRGraphViewController.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 4/22/16.
//  Copyright ©2017 xTrensa. All rights reserved.
//

import CorePlot

struct XTRGraphViewControllerConfig {
    static let name = "attributeName"
    static let title = "title"
    static let majorTickMarks = "majorTickMarks"
    static let minorTickMarks = "minorTickMarks"
    static let maximumValue = "maximumValue"
    static let minimumValue = "minimumValue"
    static let customTickLocations: [Int] = [1, 10, 20, 30, 40, 50, 60, 70, 80, 90, 100, 110]
    static let buttonSize = CGSize(width: 240.0, height: 60.0)
    static let popupContentSize = CGSize(width: (buttonSize.width + 6) * 3, height: (buttonSize.height + 4) * 10)
}

class XTRGraphViewController: UIViewController {

    @IBOutlet var barButtonItem: UIBarButtonItem!
    @IBOutlet var hostingView: CPTGraphHostingView!
    @IBOutlet var navigationBar: UINavigationBar!

    var barChart: CPTXYGraph?

    var delegate: XTRGraphViewControllerDelegate = XTRGraphViewControllerDelegate()
    var graphChoiceViewController: XTRGraphChoiceViewController!

    // MARK: - Initialization Methods

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }

    // MARK: - Action Methods

    @IBAction func showGraphChoice(_ sender: Any) {
        guard let popoverController = graphChoiceViewController.popoverPresentationController else { return }

        //XTRPropertiesStore.viewTitle = title!
        //XTRPropertiesStore.atomicNumber = sender.tag

        popoverController.barButtonItem = barButtonItem
        //popoverController.sourceRect = XTRPeriodicTableViewControllerConfig.buttonRect
        //popoverController.sourceView = sender
        popoverController.backgroundColor = XTRColorFactory.popupArrowColor

        present(graphChoiceViewController, animated: XTRPropertiesStore.showTransitionsState, completion: nil)
    }

    // MARK: - Internal Methods

    func setupPopUp() {
        graphChoiceViewController = XTRGraphChoiceViewController.loadFromNib()

        graphChoiceViewController.preferredContentSize = XTRGraphViewControllerConfig.popupContentSize
        graphChoiceViewController.modalPresentationStyle = .popover
    }

    func creatBarChart() {
        barChart = CPTXYGraph(frame: CGRect.zero)
        //barChart!.apply(CPTTheme(named: CPTThemeName.slateTheme))
        barChart?.backgroundColor = XTRAppearanceManager.manager.isClassicAppearance() ? XTRColorFactoryClassic.cotton.cgColor : XTRColorFactoryStandard.seamlessMetalTextureColor.cgColor

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
        var customLabels: [CPTAxisLabel] = []
        let textStyle = CPTMutableTextStyle()

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
        x.titleLocation = XTRDataSource.sharedInstance.elementCount() / 2 as NSNumber?
        x.titleOffset = 30.0
        x.titleTextStyle = textStyle

        // Define some custom labels for the data elements
        x.labelRotation = CGFloat.pi / 4.0
        x.labelingPolicy = CPTAxisLabelingPolicy.none

        for index in 0..<XTRGraphViewControllerConfig.customTickLocations.count {
            let tickLocation = XTRGraphViewControllerConfig.customTickLocations[index]
            let labelValue = String("\(XTRGraphViewControllerConfig.customTickLocations[index])")
            let newLabel = CPTAxisLabel.init(text: labelValue, textStyle: x.labelTextStyle)
            newLabel.tickLocation = NSNumber(value: tickLocation)
            newLabel.offset = x.labelOffset + x.majorTickLength
            newLabel.rotation = CGFloat.pi / 4.0
            customLabels.append(newLabel)
        }

        let aSet = NSSet(array: customLabels)
        x.axisLabels =  aSet as? Set<CPTAxisLabel>
    }

    // swiftlint:disable function_parameter_count
    func createYAxis(_ axisSet: CPTXYAxisSet, minorTicks: Float, majorTickStyle: CPTLineStyle, minorTickStyle: CPTLineStyle, majorTicks: Float, title: String, maxValue: Float, minValue: Float) {
        let y = axisSet.yAxis!
        let titleKey = title
        let title = NSLocalizedString(titleKey, comment: "")
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

//    func element(_ anElement: XTRElementModel, anIdentifier: String) -> NSNumber {
//        let aValue: NSNumber? = anElement.value(forKeyPath: anIdentifier) as? NSNumber
//        return (aValue != nil) ? aValue!: 0
//    }

    func showGraphForChoiceAtIndex(_ index: Int) {
        let model = XTRDataSource.sharedInstance.graphPropertyList[index]
        let minValue = model.minimumValue
        let maxValue = model.maximumValue
        let majorTicks = model.majorTickMarks
        let minorTicks = model.minorTickMarks
        let majorTickStyle = CPTMutableLineStyle.init()
        let minorTickStyle = CPTMutableLineStyle.init()
        let length = XTRDataSource.sharedInstance.elementCount() + 1

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
        createYAxis(axisSet, minorTicks: minorTicks, majorTickStyle: majorTickStyle, minorTickStyle: minorTickStyle, majorTicks: majorTicks, title: model.title, maxValue: maxValue, minValue: minValue)

        barPlot.element = XTRDataSource.sharedInstance.element(index: index)
        barPlot.delegate = delegate
        barPlot.barWidth = 1.0
        barPlot.baseValue = 0
        barPlot.dataSource = delegate
        barPlot.barOffset = 0.0
        barPlot.identifier = model.attributeName as (NSCoding & NSCopying & NSObjectProtocol)?
        barPlot.barCornerRadius = 0.0

        barChart?.add(barPlot, to: plotSpace)
    }

    // MARK: - Action Methods

    // MARK: - Notification Methods

    @objc func graphSelected(_ notification: Notification) {
        let object = notification.object as! NSNumber

        dismiss(animated: XTRPropertiesStore.showTransitionsState, completion: nil)
        showGraphForChoiceAtIndex(object.intValue)
    }

    // MARK: - View Management Methods

    override func viewDidLoad() {
        super.viewDidLoad()

        title = NSLocalizedString("graphs", comment: "")
        navigationBar.topItem?.title = title
        barButtonItem.title = NSLocalizedString("chooseGraph", comment: "")

        delegate.controller = self
        NotificationCenter.default.addObserver(self, selector: #selector(graphSelected(_:)), name: .graphSelectedNotification, object: nil)
        setupPopUp()
        showGraphForChoiceAtIndex(0)
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    override var shouldAutorotate: Bool {
        return false
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscape
    }

    // MARK: - Memory Management Methods

    deinit {
        NotificationCenter.default.removeObserver(self, name: .graphSelectedNotification, object: nil)
        barButtonItem = nil
        hostingView = nil
    }

}
