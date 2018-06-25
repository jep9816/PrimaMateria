//
//  XTRMainViewController.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 4/15/16.
//  Copyright © 2018 xTrensa. All rights reserved.
//

class XTRMainViewController : UITabBarController {
    
    // MARK: - Initialization Methods
    
    private var controllerDelegate : XTRMainViewControllerDelegate = XTRMainViewControllerDelegate()

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    // MARK: - Internal Methods
    
    func customizeTabBarItems() {
        let rect = tabBar.frame
        let newSize = CGSize(width: 120, height: rect.size.height)
        let selectionImage = UIImage.imageFromColor(UIColor.lightGray, andSize: newSize)
        let imageView = UIImageView(image: selectionImage)
        
        UIGraphicsBeginImageContextWithOptions(imageView.bounds.size, false, UIScreen.main.scale)
        
        UIBezierPath(roundedRect: imageView.bounds, cornerRadius: 8.0).addClip()
        
        selectionImage.draw(in: imageView.bounds)
        
        tabBar.selectionIndicatorImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
    }
    
    func showSplash() {
        let defaultState = XTRPropertiesStore.splashScreenState
        
        if defaultState {
            let splashViewController : XTRSplashViewController = XTRAppDelegate.storyboard().instantiateViewController(withIdentifier: XTRSplashViewController.nameOfClass) as! XTRSplashViewController
            view.addSubview(splashViewController.view)
        }
    }
    
    // MARK: - Action Methods
    
    // MARK: - View Management Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showSplash()
        navigationController?.navigationBar.prefersLargeTitles = true
        
        delegate = controllerDelegate
    }
    
    override var shouldAutorotate : Bool {
        return false
    }
    
    override var supportedInterfaceOrientations : UIInterfaceOrientationMask {
        return .landscape
    }
    
    // MARK: - Memory Management Methods
    
}
