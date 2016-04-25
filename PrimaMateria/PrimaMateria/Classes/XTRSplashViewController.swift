//
//  XTRSplashViewController.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 4/14/16.
//  Copyright © 2016 xTrensa. All rights reserved.
//

@objc class XTRSplashViewController : UIViewController {
    @IBOutlet weak var appNameLabel: UILabel!
    @IBOutlet weak var versionLabel : UILabel!
    @IBOutlet weak var cpyRightLabel : UILabel!
    @IBOutlet weak var wrapperView : UIView!
    
    // MARK: - Initialization Methods
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    // MARK: - Internal Methods
    
    func wait() {
        NSThread.sleepForTimeInterval(5.0);
        self.view.removeFromSuperview()
    }
    
    // MARK: - View Management Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.appNameLabel!.text = XTRVersionChecker.appNameString();
        self.versionLabel!.text = XTRVersionChecker.appVersionString();
        self.cpyRightLabel!.text = XTRVersionChecker.copywriteString();
        self.wrapperView!.layer.cornerRadius = 5;
        NSThread.detachNewThreadSelector(#selector(XTRSplashViewController.wait), toTarget: self, withObject: nil)
    }
    
    override func shouldAutorotate() -> Bool {
        return true
    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return [UIInterfaceOrientationMask.LandscapeLeft, UIInterfaceOrientationMask.LandscapeRight]
    }

    // MARK: - Memory Management Methods
    
    deinit {
        self.appNameLabel = nil
        self.versionLabel = nil
        self.cpyRightLabel = nil
        self.wrapperView = nil
    }
}
