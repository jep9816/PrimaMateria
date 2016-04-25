//
//  XTRGraphChoiceViewController.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 4/15/16.
//  Copyright © 2016 xTrensa. All rights reserved.
//

@objc class XTRGraphChoiceViewController : UIViewController {
    
    // MARK: - Initialization Methods
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    // MARK: - Internal Methods
    
    // MARK: - Action Methods
    
    @IBAction func chooseGraph(sender: UIButton) {
        NSNotificationCenter.defaultCenter().postNotificationName(NOTIFICATION_GRAPH_SELECTED, object: sender.tag)
    }
    
    // MARK: - View Management Methods
        
    override func shouldAutorotate() -> Bool {
        return true
    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return [UIInterfaceOrientationMask.LandscapeLeft, UIInterfaceOrientationMask.LandscapeRight]
    }
    
    // MARK: - Memory Management Methods
}
