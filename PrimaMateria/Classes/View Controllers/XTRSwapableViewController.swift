//
//  XTRSwapableViewController.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 4/20/16.
//  Copyright © 2018 xTrensa. All rights reserved.
//

import UIKit

protocol XTRSwapable {
    func setupUI()
}

class XTRSwapableViewController: UIViewController, XTRSwapable {
    
    var element: XTRElementModel?

    // MARK: - Initialization Methods
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }

    func setupUI() {
    }
    
    // MARK: - View Management Methods
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscape
    }
    
    // MARK: - Memory Management Methods
    
}
