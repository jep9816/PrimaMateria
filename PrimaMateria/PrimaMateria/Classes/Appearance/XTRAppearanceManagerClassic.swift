//
//  AppearanceManagerClassic.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 6/24/18.
//  Copyright © 2018 xTrensa. All rights reserved.
//

import UIKit

class XTRAppearanceManagerClassic : NSObject {
    
    func appearance() {
        let navigationBarAppearance = UINavigationBar.appearance()
        let toolBarAppearance = UIToolbar.appearance()
        let tabBarAppearance = UITabBar.appearance()
        let tabBarItemAppearance = UITabBarItem.appearance()
        let segmentedControlBarAppearance = UISegmentedControl.appearance()
        let switchAppearance = UISwitch.appearance()
        let backgroundView = XTRBackgroundView.appearance()
        
        let navigationBarTextAttributes: [NSAttributedStringKey: AnyObject]? = [
            NSAttributedStringKey.foregroundColor: XTRColorFactoryClassic.white,
            NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 20)
        ]
        
        let segmentedControlTextAttributes: [NSAttributedStringKey: AnyObject]?
        let tabBarNormalItemTextAttributes: [NSAttributedStringKey: AnyObject]?
        let tabBarSelectedItemTextAttributes: [NSAttributedStringKey: AnyObject]?
        
        segmentedControlTextAttributes = [
            NSAttributedStringKey.foregroundColor: XTRColorFactoryClassic.dodgerBlueColor,
            NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 14)
        ]
        tabBarNormalItemTextAttributes = [
            NSAttributedStringKey.foregroundColor: UIColor.white,
            NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 14)
        ]
        tabBarSelectedItemTextAttributes = [
            NSAttributedStringKey.foregroundColor: XTRColorFactory.tabBarSelectedForgroundColor,
            NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 14)
        ]
        
        tabBarAppearance.tintColor = XTRColorFactory.tabBarSelectedForgroundColor
        tabBarAppearance.backgroundColor = XTRColorFactoryClassic.graphite
        tabBarAppearance.barTintColor = XTRColorFactoryClassic.graphite

        tabBarItemAppearance.setTitleTextAttributes(tabBarNormalItemTextAttributes, for: UIControlState())
        tabBarItemAppearance.setTitleTextAttributes(tabBarSelectedItemTextAttributes, for: .selected)
        
        tabBarAppearance.backgroundColor = XTRColorFactoryClassic.dustyGrayColor
        
        segmentedControlBarAppearance.setTitleTextAttributes(segmentedControlTextAttributes, for: .selected)
        segmentedControlBarAppearance.tintColor = XTRColorFactoryClassic.smoke

        navigationBarAppearance.titleTextAttributes = navigationBarTextAttributes
        navigationBarAppearance.tintColor = XTRColorFactoryClassic.galleryColor
        navigationBarAppearance.backgroundColor = XTRColorFactoryClassic.inkwell
        navigationBarAppearance.barTintColor = XTRColorFactoryClassic.inkwell

        toolBarAppearance.tintColor = XTRColorFactoryClassic.galleryColor
        toolBarAppearance.backgroundColor = XTRColorFactoryClassic.inkwell
        toolBarAppearance.barTintColor = XTRColorFactoryClassic.inkwell

        switchAppearance.onTintColor = XTRColorFactoryClassic.doveGrayColor
        
        backgroundView.backgroundColor = XTRColorFactory.backgroundColor
    }
    
}
