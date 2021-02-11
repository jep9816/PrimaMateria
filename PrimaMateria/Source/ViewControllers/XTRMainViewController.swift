//
//  XTRMainViewController.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 4/15/16.
//  Copyright ©2021 xTrensa. All rights reserved.
//

import Foundation
import UIKit

class XTRMainViewController: UITabBarController {
    
    // MARK: - Initialization Methods
    
    private var controllerDelegate: XTRMainViewControllerDelegate? = XTRMainViewControllerDelegate()

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    // MARK: - Internal Methods
    
    func showSplash() {        
        if XTRPropertiesStore.splashScreenState {
            let splashViewController: XTRSplashViewController = XTRAppDelegate.storyboard().instantiateViewController(withIdentifier: XTRSplashViewController.nameOfClass) as! XTRSplashViewController
            view.addSubview(splashViewController.view)
        }
    }
    
    // MARK: - Action Methods
    
    // MARK: - View Management Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showSplash()
        navigationController?.navigationBar.prefersLargeTitles = true
        viewControllers![0].title = NSLocalizedString("periodicTable", comment: "")
        viewControllers![1].title = NSLocalizedString("elementList", comment: "")
        viewControllers![2].title = NSLocalizedString("graphs", comment: "")
        viewControllers![3].title = NSLocalizedString("preferences", comment: "")
        viewControllers![4].title = NSLocalizedString("info", comment: "")

        delegate = controllerDelegate
        UIImageView.gradientView(frame: tabBar.bounds, destinationView: tabBar)
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscape
    }
    
    // MARK: - Memory Management Methods
    
}
