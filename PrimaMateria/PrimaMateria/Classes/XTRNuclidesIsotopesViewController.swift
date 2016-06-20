//
//  XTRNuclidesIsotopesViewController.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 4/20/16.
//  Copyright © 2016 xTrensa. All rights reserved.
//

@objc class XTRNuclidesIsotopesViewController : XTRSwapableViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet var headerView : UIView!
    @IBOutlet var swapView: UIView!
    
    private var nuclidesAndIsotopesArray : NSArray?
    private var tableView : UITableView?
    
    // MARK: - Initialization Methods
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    // MARK: - Internal Methods
    
    func tableCellLabelWithXPos(xPos: CGFloat, yPos: CGFloat, aWidth: CGFloat, aHeight: CGFloat, property: String, columnPosition: UInt, aModulus: UInt, cell: DynoTableCell) -> UILabel {
        
        let label : UILabel = UILabel.init(frame: CGRectMake(xPos, yPos, aWidth, aHeight))
        
        if (aModulus == 0) {
            label.backgroundColor = UIColor.whiteColor()
        } else {
            label.backgroundColor = UIColor(hue: CGFloat(219 / HSB_CONSTANT), saturation: 0.1, brightness: 1.0, alpha: 1.0)
        }
        
        cell.backgroundView?.backgroundColor = UIColor.blackColor()
        cell.contentView.backgroundColor = UIColor.blackColor()
        cell.addColumn(CGFloat(columnPosition))
        label.font = UIFont.systemFontOfSize(20.0)
        label.textAlignment = NSTextAlignment.Center
        label.textColor = UIColor.blackColor()
        label.text = String.init(format: " %@", property)
        cell.contentView.addSubview(label)
        return label
    }
    
    // MARK: - Misc Methods
    
    override func setupUI() {
        if (self.element != nil) {
            if (self.tableView != nil) {
                self.tableView!.removeFromSuperview()
                self.tableView = nil
            }
            
            self.tableView = UITableView(frame: self.swapView.frame, style: UITableViewStyle.Plain)
            self.tableView!.alwaysBounceVertical = false
            self.tableView!.alwaysBounceHorizontal = false
            self.tableView!.dataSource = self
            self.tableView!.delegate = self
            self.tableView!.separatorStyle = UITableViewCellSeparatorStyle.None
            self.tableView!.allowsSelection = false
            self.tableView!.backgroundColor = UIColor.blackColor()
            self.tableView!.backgroundView = UIView.init(frame: self.swapView.frame)
            self.tableView!.backgroundView!.backgroundColor = UIColor.blackColor()
            self.tableView!.opaque = false
            self.view.addSubview(self.tableView!)
            self.nuclidesAndIsotopesArray = self.element!.nuclidesAndIsotopes()
            self.tableView!.reloadData()
        }
    }
    
    // MARK: - Action Methods
    
    // MARK:- UITableView DataSource Methods
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let row : UInt = UInt(indexPath.row)
        let MyIdentifier : String  = String.init(format: "Column %i", row)
        
        var cell : DynoTableCell? = tableView.dequeueReusableCellWithIdentifier(MyIdentifier) as? DynoTableCell
        
        if (cell == nil) {
            let modulus : Int  = Int(row % 2)
            let dict : NSDictionary = self.nuclidesAndIsotopesArray!.objectAtIndex(Int(row)) as! NSDictionary
            let nuclide : String? = dict.valueForKey("nuclide") as? String
            let atomicMass : String? = dict.valueForKey(ELEMENT_ATOMIC_MASS) as? String
            let nn : String? = dict.valueForKey("nn") as? String
            let abun : String? = dict.valueForKey("abun") as? String
            let spin : String? = dict.valueForKey("spin") as? String
            let halfLife : String? = dict.valueForKey("halfLife") as? String
            let dm : String? = dict.valueForKey("dm") as? String
            let dt : String? = dict.valueForKey("dt") as? String
            let br : String? = dict.valueForKey("br") as? String
            let decayEnergy : String? = dict.valueForKey("decayEnergy") as? String

            cell = DynoTableCell(style: UITableViewCellStyle.Default, reuseIdentifier: MyIdentifier)
            
            self.tableCellLabelWithXPos(0, yPos: 0, aWidth: 103, aHeight: 32, property: (nuclide != nil) ? nuclide! : STRING_EMPTY, columnPosition: 1, aModulus: UInt(modulus), cell: cell!)
            
            self.tableCellLabelWithXPos(104, yPos: 0, aWidth: 103, aHeight: 32, property: (atomicMass != nil) ? atomicMass! : STRING_EMPTY, columnPosition: 2, aModulus: UInt(modulus), cell: cell!)
            
            self.tableCellLabelWithXPos(208, yPos: 0, aWidth: 101, aHeight: 32, property: (nn != nil) ? nn! : STRING_EMPTY, columnPosition: 3, aModulus: UInt(modulus), cell: cell!)
            
            self.tableCellLabelWithXPos(310, yPos: 0, aWidth: 101, aHeight: 32, property: (abun != nil) ? abun! : STRING_EMPTY, columnPosition: 4, aModulus: UInt(modulus), cell: cell!)
            
            self.tableCellLabelWithXPos(412, yPos: 0, aWidth: 101, aHeight: 32, property: (spin != nil) ? spin! : STRING_EMPTY, columnPosition: 5, aModulus: UInt(modulus), cell: cell!)
            
            self.tableCellLabelWithXPos(514, yPos: 0, aWidth: 101, aHeight: 32, property: (halfLife != nil) ? halfLife! : STRING_EMPTY, columnPosition: 6, aModulus: UInt(modulus), cell: cell!)
            
            self.tableCellLabelWithXPos(616, yPos: 0, aWidth: 101, aHeight: 32, property: (dm != nil) ? dm! : STRING_EMPTY, columnPosition: 7, aModulus: UInt(modulus), cell: cell!)
            
            self.tableCellLabelWithXPos(718, yPos: 0, aWidth: 101, aHeight: 32, property: (dt != nil) ? dt! : STRING_EMPTY, columnPosition: 8, aModulus: UInt(modulus), cell: cell!)
            
            self.tableCellLabelWithXPos(820, yPos: 0, aWidth: 101, aHeight: 32, property: (br != nil) ? br! : STRING_EMPTY, columnPosition: 9, aModulus: UInt(modulus), cell: cell!)
            
            self.tableCellLabelWithXPos(922, yPos: 0, aWidth: 102, aHeight: 32, property: (decayEnergy != nil) ? decayEnergy! : STRING_EMPTY, columnPosition: 10, aModulus: UInt(modulus), cell: cell!)
        }
        return cell!
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.element!.nuclidesAndIsotopes()!.count
    }
    
    func tableView(aTableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 34
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
        self.headerView = nil
        self.swapView = nil
    }
}
