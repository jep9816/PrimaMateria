//
//  XTRSplashViewController.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 4/14/16.
//  Copyright ©2021 xTrensa. All rights reserved.
//

import UIKit

class XTRSplashViewController: UIViewController {

    @IBOutlet var appNameLabel: UILabel!
    @IBOutlet var versionLabel: UILabel!
    @IBOutlet var cpyRightLabel: UILabel!
    @IBOutlet var wrapperView: UIView!
    @IBOutlet var shadowView: UIView!
    @IBOutlet var backgroundImageView: UIImageView!

    // MARK: - Initialization Methods

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }

    // MARK: - Internal Methods

    @objc func done() {
        view.removeFromSuperview()
    }

    @objc func wait() {
        Thread.sleep(forTimeInterval: 5.0)
        performSelector(onMainThread: #selector(XTRSplashViewController.done), with: nil, waitUntilDone: true)
    }

    // MARK: - View Management Methods

    override func viewDidLoad() {
        super.viewDidLoad()

        appNameLabel.text = Bundle.main.appNameString
        versionLabel.text = Bundle.main.appVersionString
        cpyRightLabel.text = Bundle.main.copywriteString
        
        wrapperView.cornerRadius = VIEW_CORNER_RADIUS
        
        //shadowView.center = wrapperView.center
        shadowView.backgroundColor = UIColor.gray
        shadowView.cornerRadius = VIEW_CORNER_RADIUS

        backgroundImageView.frame = UIScreen.main.bounds

        Thread.detachNewThreadSelector(#selector(XTRSplashViewController.wait), toTarget: self, with: nil)
    }

    override var shouldAutorotate: Bool {
        return false
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscape
    }

    // MARK: - Memory Management Methods

    deinit {
        appNameLabel = nil
        versionLabel = nil
        cpyRightLabel = nil
        wrapperView = nil
    }

}
