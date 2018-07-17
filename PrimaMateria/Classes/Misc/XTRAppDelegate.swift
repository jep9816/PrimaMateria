//
//  XTRAppDelegate.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 4/20/16.
//  Copyright © 2018 xTrensa. All rights reserved.
//

import UIKit

class XTRAppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    private var appearanceManager: XTRAppearanceManager!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        let notification = Notification(name: .notificationAppearanceChanged, object: XTRPropertiesStore.appearanceName, userInfo: nil)
        appearanceManager = XTRAppearanceManager.init(window: window!)
        appearanceManager.changeAppearance(notification: notification as NSNotification)

        //        let fontFamiles: [Any] = UIFont.familyNames()
        //        print("%@", fontFamiles)
        //        let fontNames: [Any] = UIFont.fontNamesForFamilyName("Verdana")
        //        print("%@", fonßtNames)
        
         return true
    }
    
    class func storyboard() -> UIStoryboard {
        return UIStoryboard(name: MAIN_STORY_BOARD, bundle: nil)
    }
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return .landscape
    }
    
}
