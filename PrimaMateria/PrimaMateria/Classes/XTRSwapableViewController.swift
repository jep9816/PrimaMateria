//
//  XTRSwapableViewController.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 4/20/16.
//  Copyright © 2016 xTrensa. All rights reserved.
//

@objc class XTRSwapableViewController : UIViewController {
    var element : XTRElement?

    // MARK: - Initialization Methods
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }

    func setupUI() {
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