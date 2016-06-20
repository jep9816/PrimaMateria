//
//  XTRElementListViewController.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 4/15/16.
//  Copyright © 2016 xTrensa. All rights reserved.
//

@objc class XTRElementListViewController : UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet var atomicNumberButton : DynoTableHeaderButton!
    @IBOutlet var swapView: UIView!
    
    private var tableView : UITableView?
    private var _indexPath : NSIndexPath?
    
    // MARK: - Initialization Methods
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    // MARK: - Internal Methods
    
    private func showElementPanelForElementAtIndex(anIndex: UInt)  {
        XTRPropertiesStore.storeViewTitle(self.title)
        XTRPropertiesStore.storeAtomicNumber(anIndex)
        self.performSegueWithIdentifier(SHOW_INSPECTOR_FROM_ELEMENT_LIST, sender: self)
    }
    
    private func setupTableView() {
        self.tableView = UITableView.init(frame: swapView.frame, style: UITableViewStyle.Plain)
        self.tableView!.alwaysBounceVertical = false
        self.tableView!.alwaysBounceHorizontal = false
        self.tableView!.delegate = self
        self.tableView!.dataSource = self
        self.tableView!.separatorStyle = UITableViewCellSeparatorStyle.None
        self.tableView!.backgroundColor = UIColor.blackColor()
        self.tableView!.allowsSelection = true
        self.tableView!.allowsMultipleSelection = false
        self.tableView!.registerClass(XTRElementTableViewCell.classForCoder(), forCellReuseIdentifier: "XTRElementTableViewCell")
        self.view.addSubview(tableView!)
    }
    
    // MARK: - Action Methods
    
    @IBAction func sortTableView(sender: DynoTableHeaderButton) {
        let toggleState : Bool = sender.toggleState()
        
        if (self.tableView != nil) {
            self.tableView!.delegate = nil
            self.tableView!.dataSource = nil
            self.tableView!.removeFromSuperview()
            self.tableView = nil
        }
        
        XTRDataSource.sharedInstance().sortByColumnPosition(UInt(sender.tag), andOrdering: toggleState)
        self.setupTableView()
        self.tableView!.reloadData()
    }
    
    // MARK: - UITableView DataSource Methods
    
    func tableView(aTableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {        
        let cell : XTRElementTableViewCell? = aTableView.dequeueReusableCellWithIdentifier("XTRElementTableViewCell") as? XTRElementTableViewCell
        cell!.setupWithElement(XTRDataSource.sharedInstance().sortedElementAtIndex(UInt(indexPath.row)))
        
        return cell!
    }
    
    func numberOfSectionsInTableView(aTableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(aTableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return XTRDataSource.sharedInstance().sortedElementList!.count
    }
    
    // MARK: - UITableView Delegate Methods
    
    func tableView(aTableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let element : XTRElement = XTRDataSource.sharedInstance().sortedElementAtIndex(UInt(indexPath.row))
        let atomicNumber : NSNumber = element.atomicNumber()

        self._indexPath = indexPath
        aTableView.deselectRowAtIndexPath(indexPath, animated: true)
        self.showElementPanelForElementAtIndex(UInt(atomicNumber.integerValue - 1))
    }
    
    func tableView(aTableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 44
    }
    
    // MARK: - View Management Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.atomicNumberButton.toggleState()
        self.swapView.removeFromSuperview()
        self.setupTableView()
    }
    
    override func viewDidDisappear(animated: Bool) {
        if(self._indexPath != nil)  {
            self.tableView!.deselectRowAtIndexPath(self._indexPath!, animated: true)
        }
        super.viewDidDisappear(animated)
    }
    
    override func shouldAutorotate() -> Bool {
        return true
    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return [UIInterfaceOrientationMask.LandscapeLeft, UIInterfaceOrientationMask.LandscapeRight]
    }
    
    // MARK: - Memory Management Methods
    
    deinit {
        self.atomicNumberButton = nil
        self.swapView = nil
    }
}
