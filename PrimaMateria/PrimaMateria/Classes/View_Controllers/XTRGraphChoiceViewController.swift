//
//  XTRGraphChoiceViewController.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 4/15/16.
//  Copyright ©2018 xTrensa. All rights reserved.
//

class XTRGraphChoiceViewController : UIViewController {
    
    // MARK: - Initialization Methods
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    // MARK: - Internal Methods
    
    // MARK: - Action Methods
    
    @IBAction func chooseGraph(_ sender: UIButton) {
        NotificationCenter.default.post(name: .graphSelectedNotification, object: sender.tag)
    }
    
    // MARK: - View Management Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = XTRColorFactory.popupArrowColor
    }
    
    override var shouldAutorotate : Bool {
        return false
    }
    
    override var supportedInterfaceOrientations : UIInterfaceOrientationMask {
        return .landscape
    }
    
    // MARK: - Memory Management Methods
    
}
