//
//  XTRAppearanceManagerStandard.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 6/24/18.
//  Copyright © 2018 xTrensa. All rights reserved.
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
        let backgroundView = XTRBackgroundView.appearance()

        let navigationBarTextAttributes: [NSAttributedStringKey: AnyObject]? = [
            NSAttributedStringKey.foregroundColor: XTRColorFactoryStandard.lightGray,
            NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 20)
        ]
        
        let segmentedControlTextAttributes: [NSAttributedStringKey: AnyObject]?
        let tabBarNormalItemTextAttributes: [NSAttributedStringKey: AnyObject]?
        let tabBarSelectedItemTextAttributes: [NSAttributedStringKey: AnyObject]?
        
        segmentedControlTextAttributes = [
            NSAttributedStringKey.foregroundColor: XTRColorFactory.segmentedControlForgroundColor,
            NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 14)
        ]
        tabBarNormalItemTextAttributes = [
            NSAttributedStringKey.foregroundColor: XTRColorFactoryStandard.lightGray,
            NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 14)
        ]
        tabBarSelectedItemTextAttributes = [
            NSAttributedStringKey.foregroundColor: XTRColorFactory.tabBarSelectedForgroundColor,
            NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 14)
        ]
        
        tabBarAppearance.tintColor = XTRColorFactory.tabBarSelectedForgroundColor
        tabBarAppearance.backgroundColor = XTRColorFactoryStandard.navyBlue
        tabBarAppearance.barTintColor = XTRColorFactoryStandard.navyBlue

        tabBarItemAppearance.setTitleTextAttributes(tabBarNormalItemTextAttributes, for: UIControlState())
        tabBarItemAppearance.setTitleTextAttributes(tabBarSelectedItemTextAttributes, for: .selected)
        
        tabBarAppearance.backgroundColor = XTRColorFactoryStandard.suvaGrey
        
        segmentedControlBarAppearance.setTitleTextAttributes(segmentedControlTextAttributes, for: .selected)
        segmentedControlBarAppearance.tintColor = XTRColorFactoryStandard.whiteSmoke

        navigationBarAppearance.titleTextAttributes = navigationBarTextAttributes
        navigationBarAppearance.tintColor = XTRColorFactoryStandard.lightGray
        navigationBarAppearance.backgroundColor = XTRColorFactoryStandard.wavesOfGrass
        navigationBarAppearance.barTintColor = XTRColorFactoryClassic.dodgerBlueColor

        toolBarAppearance.tintColor = XTRColorFactoryStandard.navyBlue
        toolBarAppearance.backgroundColor = XTRColorFactoryStandard.darkText
        toolBarAppearance.barTintColor = XTRColorFactoryStandard.darkText

        switchAppearance.onTintColor = XTRColorFactoryStandard.successGreen

        backgroundView.backgroundColor = XTRColorFactory.backgroundColor
    }
    
}
