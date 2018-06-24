//
//  XTCAppearanceManagerDefault.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 6/22/18.
//  Copyright © 2018 xTrensa. All rights reserved.
//

class XTCAppearanceManagerClassic : NSObject {
    
    private static var __once: () = { _sharedInstance = XTCAppearanceManagerClassic() }()
    static var _sharedInstance : XTCAppearanceManagerClassic!

    struct Static {
        static var dispatchOnceToken = 0
    }
    
    class func sharedInstance() -> XTCAppearanceManagerClassic {
        _ = XTCAppearanceManagerClassic.__once
        return _sharedInstance
    }

    func applyStyle() {
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
        
        segmentedControlTextAttributes = [
            NSAttributedStringKey.foregroundColor: XTRColorFactory.dodgerBlueColor,
            NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 13)
        ]
        tabBarNormalItemTextAttributes = [
            NSAttributedStringKey.foregroundColor: UIColor.white,
            NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 14)
        ]
        tabBarSelectedItemTextAttributes = [
            NSAttributedStringKey.foregroundColor: XTRColorFactory.dodgerBlueColor,
            NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 14)
        ]
        
        tabBarAppearance.tintColor = XTRColorFactory.dodgerBlueColor
        
        tabBarItemAppearance.setTitleTextAttributes(tabBarNormalItemTextAttributes, for: UIControlState())
        tabBarItemAppearance.setTitleTextAttributes(tabBarSelectedItemTextAttributes, for: .selected)
        
        tabBarAppearance.backgroundColor = XTRColorFactory.dustyGrayColor
        
        segmentedControlBarAppearance.setTitleTextAttributes(segmentedControlTextAttributes, for: .selected)
        
        navigationBarAppearance.titleTextAttributes = navigationBarTextAttributes
        navigationBarAppearance.tintColor = XTRColorFactory.galleryColor
        
        toolBarAppearance.tintColor = XTRColorFactory.galleryColor
        
        switchAppearance.onTintColor = XTRColorFactory.doveGrayColor
    }
}
