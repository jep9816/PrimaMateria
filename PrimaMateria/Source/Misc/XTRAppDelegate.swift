//
//  XTRAppDelegate.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 4/20/16.
//  Copyright ©2021 xTrensa. All rights reserved.
//

import UIKit

class XTRAppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        UserDefaults.standard.setValue(false, forKey: "_UIConstraintBasedLayoutLogUnsatisfiable")

        LocaleManager.setup()
        LocaleManager.apply(locale: Locale(identifier: XTRPropertiesStore.currentLanguageCode))

        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        self.window = UIWindow()

        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    class func storyboard() -> UIStoryboard {
        return UIStoryboard(name: StoryBoardName.Main, bundle: nil)
    }

    var keyWindow: UIWindow? {
         return UIApplication.shared.windows.filter {$0.isKeyWindow}.first!
    }

}
