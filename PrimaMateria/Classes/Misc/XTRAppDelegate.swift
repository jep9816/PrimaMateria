//
//  XTRAppDelegate.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 4/20/16.
//  Copyright © 2019 xTrensa. All rights reserved.
//

import UIKit

class XTRAppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    private var appearanceManager: XTRAppearanceManager!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let notification = Notification(name: .notificationAppearanceChanged, object: XTRPropertiesStore.appearanceName, userInfo: nil)
        appearanceManager = XTRAppearanceManager.init(window: window!)
        appearanceManager.changeAppearance(notification: notification as NSNotification)
        
        UserDefaults.standard.setValue(false, forKey: "_UIConstraintBasedLayoutLogUnsatisfiable")

        LocaleManager.setup()
        
        if let language = UserDefaults.standard.string(forKey: "AppleLanguage") {
            LocaleManager.apply(locale: Locale(identifier: language))
        } else {
            UserDefaults.standard.set("en", forKey: "AppleLanguage")
            LocaleManager.apply(locale: Locale(identifier: "en"))
        }

        let languages = LocaleManager.availableLocalizations
        print("\(languages)")

        // JEP: Hack remove this
        //        let fontFamiles: [Any] = UIFont.familyNames()
        //        print("%@", fontFamiles)
        //        let fontNames: [Any] = UIFont.fontNamesForFamilyName("Verdana")
        //        print("%@", fonßtNames)
        
        return true
    }
    
    class func storyboard() -> UIStoryboard {
        return UIStoryboard(name: StoryBoardName.Main, bundle: nil)
    }
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return .landscape
    }
    
}
