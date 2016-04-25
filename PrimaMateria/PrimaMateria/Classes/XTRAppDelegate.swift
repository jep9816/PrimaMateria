//
//  XTRAppDelegate.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 4/20/16.
//  Copyright © 2016 xTrensa. All rights reserved.
//

@objc class XTRAppDelegate : UIResponder, UIApplicationDelegate {
    var window : UIWindow?
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject : AnyObject]?) -> Bool {
        XTRAppDelegate.applyStyle()
        let fontFamiles : NSArray = UIFont.familyNames()
        print("%@", fontFamiles);
        let fontNames : NSArray = UIFont.fontNamesForFamilyName("Verdana")
        print("%@", fontNames);
        return true
    }
    
    class func storyboard() -> UIStoryboard {
        return UIStoryboard.init(name: MAIN_STORY_BOARD, bundle: nil)
    }
    
    class func applyStyle() {
        let navigationBarAppearance : UINavigationBar = UINavigationBar.appearance()
        let toolBarAppearance : UIToolbar = UIToolbar.appearance()
        let tabBarAppearance : UITabBar = UITabBar.appearance()
        let tabBarItemAppearance : UITabBarItem = UITabBarItem.appearance()
        let segmentedControlBarAppearance : UISegmentedControl = UISegmentedControl.appearance()
        let switchAppearance : UISwitch = UISwitch.appearance()
        
        let navigationBarTextAttributes: [String: AnyObject]? = [
            NSForegroundColorAttributeName: UIColor.whiteColor(),
            NSFontAttributeName: UIFont.boldSystemFontOfSize(20)
        ]
        
        let tabBarNormalItemTextAttributes: [String: AnyObject]? = [
            NSForegroundColorAttributeName: UIColor.whiteColor(),
            NSFontAttributeName: UIFont.boldSystemFontOfSize(14)
        ]
        
        let tabBarSelectedItemTextAttributes: [String: AnyObject]? = [
            NSForegroundColorAttributeName: UIColor.init(hexString: "333333"),
            NSFontAttributeName: UIFont.boldSystemFontOfSize(14)
        ]
        
        let segmentedControlTextAttributes: [String: AnyObject]? = [
            NSForegroundColorAttributeName: UIColor.whiteColor(),
            NSFontAttributeName: UIFont.systemFontOfSize(13)
        ]
        
        navigationBarAppearance.titleTextAttributes = navigationBarTextAttributes
        navigationBarAppearance.tintColor = UIColor.init(hexString: "eeeeee")
        
        toolBarAppearance.tintColor = UIColor.init(hexString: "eeeeee")
        
        tabBarItemAppearance.setTitleTextAttributes(tabBarNormalItemTextAttributes, forState: UIControlState.Normal)
        tabBarItemAppearance.setTitleTextAttributes(tabBarSelectedItemTextAttributes, forState: UIControlState.Selected)
        
        tabBarAppearance.tintColor = UIColor.init(hexString: "333333")
        tabBarAppearance.backgroundColor = UIColor.init(hexString: "999999")
        
        segmentedControlBarAppearance.setTitleTextAttributes(segmentedControlTextAttributes, forState: UIControlState.Normal)
        
        switchAppearance.onTintColor = UIColor.init(hexString: "666666")
    }
    
    
    func application(application: UIApplication, supportedInterfaceOrientationsForWindow window: UIWindow?) -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.Landscape
    }
}
