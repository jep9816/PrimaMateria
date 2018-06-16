//
//  XTRAppDelegate.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 4/20/16.
//  Copyright ©2018 xTrensa. All rights reserved.
//

class XTRAppDelegate : UIResponder, UIApplicationDelegate {
    
    var window : UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        XTRAppDelegate.applyStyle()
        //        let fontFamiles : [Any] = UIFont.familyNames()
        //        print("%@", fontFamiles)
        //        let fontNames : [Any] = UIFont.fontNamesForFamilyName("Verdana")
        //        print("%@", fontNames)
        return true
    }
    
    class func storyboard() -> UIStoryboard {
        return UIStoryboard(name: MAIN_STORY_BOARD, bundle: nil)
    }
    
    class func applyStyle() {
        let navigationBarAppearance = UINavigationBar.appearance()
        let toolBarAppearance = UIToolbar.appearance()
        let tabBarAppearance = UITabBar.appearance()
        let tabBarItemAppearance = UITabBarItem.appearance()
        let segmentedControlBarAppearance = UISegmentedControl.appearance()
        let switchAppearance = UISwitch.appearance()
        
        let navigationBarTextAttributes: [NSAttributedStringKey: AnyObject]? = [
            NSAttributedStringKey.foregroundColor: UIColor.white,
            NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 20)
        ]
        
        let segmentedControlTextAttributes: [NSAttributedStringKey: AnyObject]?
        let tabBarNormalItemTextAttributes: [NSAttributedStringKey: AnyObject]?
        let tabBarSelectedItemTextAttributes: [NSAttributedStringKey: AnyObject]?
        
        if #available(iOS 11.0, *) {
            segmentedControlTextAttributes = [
                NSAttributedStringKey.foregroundColor: UIColor.color(hexString: "4093ff"),
                NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 13)
            ]
            tabBarNormalItemTextAttributes = [
                NSAttributedStringKey.foregroundColor: UIColor.white,
                NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 14)
            ]
            tabBarSelectedItemTextAttributes = [
                NSAttributedStringKey.foregroundColor: UIColor.color(hexString: "4093ff"),
                NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 14)
            ]
            tabBarAppearance.tintColor = UIColor.color(hexString: "4093ff")
        } else {
            segmentedControlTextAttributes = [
                NSAttributedStringKey.foregroundColor: UIColor.color(hexString: "666666"),
                NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 13)
            ]
            tabBarNormalItemTextAttributes = [
                NSAttributedStringKey.foregroundColor: UIColor.white,
                NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 12)
            ]
            tabBarSelectedItemTextAttributes = [
                NSAttributedStringKey.foregroundColor: UIColor.color(hexString: "333333"),
                NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 12)
            ]
            tabBarAppearance.tintColor = UIColor.color(hexString: "333333")
        }
        
        tabBarItemAppearance.setTitleTextAttributes(tabBarNormalItemTextAttributes, for: UIControlState())
        tabBarItemAppearance.setTitleTextAttributes(tabBarSelectedItemTextAttributes, for: .selected)
        
        tabBarAppearance.backgroundColor = UIColor.color(hexString: "999999")
        
        segmentedControlBarAppearance.setTitleTextAttributes(segmentedControlTextAttributes, for: .selected)
        
        navigationBarAppearance.titleTextAttributes = navigationBarTextAttributes
        navigationBarAppearance.tintColor = UIColor.color(hexString: "eeeeee")
        
        toolBarAppearance.tintColor = UIColor.color(hexString: "eeeeee")
        
        switchAppearance.onTintColor = UIColor.color(hexString: "666666")
    }
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return .landscape
    }
    
}
