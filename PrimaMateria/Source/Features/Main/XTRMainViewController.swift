//
//  XTRMainViewController.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 4/15/16.
//  Copyright ©2021 xTrensa. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI

class XTRMainViewController: UITabBarController {
    var splashViewController: UIViewController!

    // MARK: - Initialization Methods

    private var controllerDelegate: XTRMainViewControllerDelegate? = XTRMainViewControllerDelegate()

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }

    // MARK: - Internal Methods

    func showSplash() {
        if XTRPropertiesStore.splashScreenState {
            //print("showSplash")
            //let splashView = XTRSplashView(dismissAction: { self.wait() })
            //splashViewController = UIHostingController(rootView: splashView)
            let splashViewController: XTRSplashViewController = XTRSplashViewController.loadFromNib()
            
            view.frame = UIScreen.main.bounds
            splashViewController.view.frame = UIScreen.main.bounds
            view.addSubview(splashViewController.view)
            //splashViewController.view.removeFromSuperview()
        }
    }

    @objc func wait() {
        print("Hello before")
        Thread.sleep(forTimeInterval: 5.0)
        print("Hello after")

        view.willRemoveSubview(splashViewController.view)
        //splashViewController.view.removeFromSuperview()

        //performSelector(onMainThread: #selector(XTRSplashViewController.done), with: nil, waitUntilDone: true)
    }

    // MARK: - Action Methods

    // MARK: - View Management Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        let periodicTableViewController = XTRPeriodicTableViewController.loadFromNib()
        let elementListViewController = XTRElementListViewController.loadFromNib()
        let graphsViewController = XTRGraphViewController.loadFromNib()
        let preferencesViewController = XTRPreferencesViewController.loadFromNib()
        //let preferencesViewController = XTRPreferencesHostingController(rootView: XTRPreferencesView())
        let infoViewController = XTRInfoHostingController(rootView: XTRInfoView())

        createTab(viewController: periodicTableViewController, tabTitle: "periodicTable", imageName: "atom")
        createTab(viewController: elementListViewController, tabTitle: "elementList", imageName: "tablecells")
        createTab(viewController: graphsViewController, tabTitle: "graphs", imageName: "chart.bar.xaxis")
        createTab(viewController: preferencesViewController, tabTitle: "preferences", imageName: "gearshape.2.fill")
        createTab(viewController: infoViewController, tabTitle: "info", imageName: "info.circle.fill")

        self.viewControllers = [
            periodicTableViewController,
            elementListViewController,
            graphsViewController,
            preferencesViewController,
            infoViewController
        ]
        
        self.selectedViewController = periodicTableViewController

        showSplash()
        navigationController?.navigationBar.prefersLargeTitles = true

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

    // MARK: - Private Methods
    
    private func createTab(viewController: UIViewController, tabTitle: String, imageName: String) {
        let tabItem = UITabBarItem()
        
        tabItem.title = NSLocalizedString(tabTitle, comment: "")
        tabItem.image = UIImage(systemName: imageName, withConfiguration:
                                    UIImage.SymbolConfiguration(weight: .black))!.imageWithoutBaseline()

        viewController.tabBarItem = tabItem
    }
    
}
