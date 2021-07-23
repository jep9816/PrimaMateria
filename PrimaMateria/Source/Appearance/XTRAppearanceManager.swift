//
//  XTRAppearanceManager.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 6/22/18.
//  Copyright ©2021 xTrensa. All rights reserved.
//

import Foundation
import UIKit

var _manager: XTRAppearanceManager!

class XTRAppearanceManager: NSObject {

    private var _window: UIWindow?
    private var _classicManager: XTRAppearanceManagerClassic!
    private var _standardManager: XTRAppearanceManagerStandard!

    override init() {
        super.init()
        _classicManager = XTRAppearanceManagerClassic()
        _standardManager = XTRAppearanceManagerStandard()

        NotificationCenter.default.addObserver(self, selector: #selector(changeAppearance(notification:)), name: .notificationAppearanceChanged, object: nil)
    }

    convenience init(window: UIWindow) {
        self.init()
        _window = window
        commonAppearance()
    }

    class var manager: XTRAppearanceManager {
        if _manager == nil {
            _manager = XTRAppearanceManager()
        }

        return _manager
    }

    func commonAppearance() {
        let switchAppearance = UISwitch.appearance()
        switchAppearance.onTintColor = XTRColorFactory.successGreen
        viewControllerBackgroundAppearance()
    }

    @objc func changeAppearance(notification: NSNotification) {
        if notification.object as! String == XTRAppearanceType.classic.name {
            classicAppearance()
        } else if notification.object as! String == XTRAppearanceType.standard.name {
            standardAppearance()
        }
        commonAppearance()
    }

    private func reset(appearanceName: String) {
        let currentview = _window?.rootViewController?.view
        let superview = currentview?.superview
        currentview?.removeFromSuperview()
        superview?.addSubview(currentview!)
        XTRPropertiesStore.appearanceName = appearanceName
        commonAppearance()
    }

    func classicAppearance() {
        _classicManager.appearance()
        reset(appearanceName: XTRAppearanceType.classic.name)
    }

    func standardAppearance() {
        _standardManager.appearance()
        reset(appearanceName: XTRAppearanceType.standard.name)
    }

    func applyAppearance() {
        if isClassicAppearance() {
            _classicManager.appearance()
        } else {
            _standardManager.appearance()
        }
    }

    func isClassicAppearance() -> Bool {
        return XTRPropertiesStore.appearanceName == XTRAppearanceType.classic.name
    }

    func isStandardAppearance() -> Bool {
        return XTRPropertiesStore.appearanceName == XTRAppearanceType.standard.name
    }

    func viewControllerBackgroundAppearance() {
        XTRBackgroundView.appearance().backgroundColor = XTRColorFactory.backgroundColor
    }

    deinit {
        NotificationCenter.default.removeObserver(self, name: .notificationAppearanceChanged, object: nil)
    }

}

extension UIViewController {

    func preferredStatusBarStyle() -> UIStatusBarStyle {
        if XTRAppearanceManager.manager.isClassicAppearance() {
            return .default
        } else {
            return .lightContent
        }
    }

}
