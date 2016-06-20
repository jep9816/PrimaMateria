//
//  XTRElementBalloonViewController.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 4/15/16.
//  Copyright © 2016 xTrensa. All rights reserved.
//

@objc class XTRElementBalloonViewController : UIViewController {
    @IBOutlet var elementNameLabel : UILabel!
    @IBOutlet var atomicNumberLabel : UILabel!
    @IBOutlet var atomicMassLabel : UILabel!
    @IBOutlet var boilingPointLabel : UILabel!
    @IBOutlet var meltingPointLabel : UILabel!
    @IBOutlet var wrapperView : UIView!
    
    // MARK: - Initialization Methods
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    // MARK: - Internal Methods
    
    func setupUI() {
        let atomicNumber : NSNumber = XTRPropertiesStore.retreiveAtomicNumber()
        let element : XTRElement? = XTRDataSource.sharedInstance().elementAtIndex(UInt(atomicNumber.intValue))
        
        if (element != nil) {
            self.elementNameLabel.text = String.init(format: " %@", element!.name()!)
            self.elementNameLabel.textColor = element!.standardConditionColor()
            self.elementNameLabel.backgroundColor = element!.seriesColor()
            self.atomicNumberLabel.text = String.init(format: " %@", element!.atomicNumber().stringValue)
            self.atomicMassLabel.text = String.init(format: " %@", element!.atomicMassAggregate()!)
            self.boilingPointLabel.text = String.init(format: " %@", element!.boilingPointString())
            self.meltingPointLabel.text = String.init(format: " %@", element!.meltingPointString())
        }
    }
    
    // MARK: - Action Methods
    
    @IBAction func showDetails(sender: UIButton) {
        XTRPropertiesStore.storeViewTitle(PERIODIC_VIEW_TITLE)
        XTRPropertiesStore.storeAtomicNumber(XTRPropertiesStore.retreiveAtomicNumber())
        self.performSegueWithIdentifier(SHOW_INSPECTOR_FROM_ELEMENT_BALLOON, sender: sender)
    }
    
    
    // MARK: - View Management Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.wrapperView.layer.cornerRadius = 10.0
        self.wrapperView.clipsToBounds = true
    }
    
    override func viewWillAppear(animated: Bool)  {
        super.viewWillAppear(animated)
        self.setupUI()
    }
    
    override func shouldAutorotate() -> Bool {
        return true
    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return [UIInterfaceOrientationMask.LandscapeLeft, UIInterfaceOrientationMask.LandscapeRight]
    }
    
    // MARK: - Memory Management Methods
    
    deinit {
        self.elementNameLabel = nil
        self.atomicNumberLabel = nil
        self.atomicMassLabel = nil
        self.boilingPointLabel = nil
        self.meltingPointLabel = nil
        self.wrapperView = nil
    }
}
