//
//  XTRHomeViewController.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 6/11/21.
//  Copyright © 2021 Jerry Porter. All rights reserved.
//

import UIKit

class XTRHomeViewController: UITabBarController {

    // MARK: - Initialization Methods

    private var controllerDelegate: XTRHomeViewControllerDelegate? = XTRHomeViewControllerDelegate()

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    // MARK: - Internal Methods

    func showSplash() {
        if XTRPropertiesStore.splashScreenState {
            let splashViewController: XTRSplashViewController = XTRSplashViewController.loadFromNib()
            view.frame = UIScreen.main.bounds
            splashViewController.view.frame = UIScreen.main.bounds
            view.addSubview(splashViewController.view)
        }
    }

    // MARK: - Action Methods

    // MARK: - View Management Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        let periodicTableViewController = XTRPeriodicTableViewController.loadFromNib()
        let elementListViewController = XTRElementListViewController.loadFromNib()
        let graphsViewController = XTRGraphViewController.loadFromNib()
        let preferencesViewController = XTRPreferencesViewController.loadFromNib()
        let infoViewController = XTRInfoViewController.loadFromNib()

        createTab(viewController: periodicTableViewController, tabTitle: "periodicTable", imageName: "Tab01")
        createTab(viewController: elementListViewController, tabTitle: "elementList", imageName: "Tab02")
        createTab(viewController: graphsViewController, tabTitle: "graphs", imageName: "Tab03")
        createTab(viewController: preferencesViewController, tabTitle: "preferences", imageName: "Tab04")
        createTab(viewController: infoViewController, tabTitle: "info", imageName: "Tab05")

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

    // MARK: - Private Methods
    
    private func createTab(viewController: UIViewController, tabTitle: String, imageName: String) {
        let tabItem = UITabBarItem()
        
        tabItem.title = NSLocalizedString(tabTitle, comment: "")
        tabItem.image = UIImage(named: imageName)

        viewController.tabBarItem = tabItem
    }

    private func createViewController(storyBoardName: String, withIdentifier: String, tabTitle: String, imageName: String) -> UIViewController {
        let viewController = UIStoryboard(name: storyBoardName, bundle: nil).instantiateViewController(withIdentifier: withIdentifier)
        let tabItem = UITabBarItem()
        
        tabItem.title = NSLocalizedString(tabTitle, comment: "")
        tabItem.image = UIImage(named: imageName)

        viewController.tabBarItem = tabItem

        return viewController
    }
    
}
