//
//  XTRAppearanceManagerStandard.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 6/24/18.
//  Copyright ©2018 xTrensa. All rights reserved.
//

import UIKit

class XTRAppearanceManagerStandard : NSObject {
    
    func appearance() {
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
            NSAttributedStringKey.foregroundColor: XTRColorFactory.segmentedControlForgroundColor,
            NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 13)
        ]
        tabBarNormalItemTextAttributes = [
            NSAttributedStringKey.foregroundColor: UIColor.white,
            NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 14)
        ]
        tabBarSelectedItemTextAttributes = [
            NSAttributedStringKey.foregroundColor: XTRColorFactory.tabBarForgroundColor,
            NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 14)
        ]
        
        tabBarAppearance.tintColor = XTRColorFactory.tabBarForgroundColor
        
        tabBarItemAppearance.setTitleTextAttributes(tabBarNormalItemTextAttributes, for: UIControlState())
        tabBarItemAppearance.setTitleTextAttributes(tabBarSelectedItemTextAttributes, for: .selected)
        
        tabBarAppearance.backgroundColor = XTRColorFactoryClassic.dustyGrayColor
        
        segmentedControlBarAppearance.setTitleTextAttributes(segmentedControlTextAttributes, for: .selected)
        
        navigationBarAppearance.titleTextAttributes = navigationBarTextAttributes
        navigationBarAppearance.tintColor = XTRColorFactoryClassic.galleryColor
        
        toolBarAppearance.tintColor = XTRColorFactoryClassic.galleryColor
        
        switchAppearance.onTintColor = XTRColorFactoryStandard.successGreen
    }
    
}
