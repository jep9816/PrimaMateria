//
//  AppearanceManagerClassic.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 6/24/18.
//  Copyright ©2018 xTrensa. All rights reserved.
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

    /*func appearance() {
        let baseView : BaseControllerView = BaseControllerView.appearance(whenContainedInInstancesOf: [UIViewController.self])
        let navigationBar : UINavigationBar = UINavigationBar.appearance()
        let tabbar : UITabBar = UITabBar.appearance()
        let toolBar : UIToolbar = UIToolbar.appearance()
        let tableView : UITableView = UITableView.appearance()
        let tableView1 : UITableView = UITableView.appearance(whenContainedInInstancesOf: [UITableViewController.self])
        let tableViewCell : UITableViewCell = UITableViewCell.appearance()
        let toolbarButtonItem : UIBarButtonItem = UIBarButtonItem.appearance(whenContainedInInstancesOf: [UIToolbar.self])
        let faaLabel : UILabel = UILabel.appearance(whenContainedInInstancesOf: [FAAWarningViewController.self])
        let baseWrapperView : BaseWrapperView = BaseWrapperView.appearance()
        let webView : UIWebView  = UIWebView.appearance()
        let baseButton : BaseButton = BaseButton.appearance()
        let acceptButton : AcceptButton = AcceptButton.appearance()
        let cancelButton : CancelButton = CancelButton.appearance()
        let numberPadButton : NumberPadButton = NumberPadButton.appearance()
        let navBarButton : UIBarButtonItem = UIBarButtonItem.appearance(whenContainedInInstancesOf: [UINavigationBar.self])
        let textField : UITextField = UITextField.appearance()
        let segmentedControl = UISegmentedControl.appearance()
        // UISwitch appearance is setup in AppearanceManager.commonAppearance()

        baseView.backgroundColor = ColorFactoryClassic.smoke
        
        navigationBar.barStyle = .black
        navigationBar.tintColor = ColorFactoryClassic.white
        navigationBar.barTintColor = ColorFactoryClassic.gulfstreamBlue
        navigationBar.backgroundColor = ColorFactoryClassic.gulfstreamBlue
        navigationBar.isTranslucent = false
        
        navigationBar.titleTextAttributes = [NSAttributedStringKey.font : UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.semibold), NSAttributedStringKey.foregroundColor: ColorFactoryClassic.white]
        
        tabbar.barStyle = .black
        tabbar.barTintColor = ColorFactoryClassic.smoke
        tabbar.tintColor = ColorFactoryClassic.elephant

        toolBar.barStyle = .black
        toolBar.barTintColor = ColorFactoryClassic.gulfstreamBlue
        toolBar.tintColor = ColorFactoryClassic.white
        
        tableView.separatorColor = ColorFactoryClassic.timberwolf
        tableView.backgroundColor = ColorFactory.transparentFull
        
        tableView1.separatorColor = ColorFactoryClassic.timberwolf
        tableView1.backgroundColor = ColorFactoryClassic.white
        
        tableViewCell.backgroundColor = ColorFactoryClassic.white
        tableViewCell.contentView.backgroundColor = ColorFactoryClassic.white
        tableViewCell.textLabel?.textColor = ColorFactoryClassic.inkwell
        tableViewCell.detailTextLabel?.textColor = ColorFactoryClassic.empress
        
        toolbarButtonItem.tintColor = ColorFactoryClassic.white
        toolbarButtonItem.setTitleTextAttributes([NSAttributedStringKey.font : UIFont.systemFont(ofSize: 15), NSAttributedStringKey.foregroundColor: ColorFactoryClassic.white], for: .normal)
        toolbarButtonItem.setTitleTextAttributes([NSAttributedStringKey.font : UIFont.systemFont(ofSize: 13), NSAttributedStringKey.foregroundColor : ColorFactoryClassic.interactiveBlue], for: .selected)
        
        faaLabel.backgroundColor = ColorFactoryClassic.white
        faaLabel.textColor = ColorFactory.defaultButtonText
        
        baseWrapperView.backgroundColor = ColorFactoryClassic.smoke
        baseWrapperView.borderColor = ColorFactory.transparentFull
        baseWrapperView.borderWidth = 0
        baseWrapperView.cornerRadius = 0
        
        navBarButton.setTitleTextAttributes([NSAttributedStringKey.font : UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.regular)], for: .normal)

        webView.backgroundColor = ColorFactoryClassic.smoke
        UIScrollView.appearance(whenContainedInInstancesOf: [UIWebView.self]).backgroundColor = ColorFactoryClassic.smoke
                
        baseButton.setTitleColor(ColorFactoryClassic.white, for: .normal)
        baseButton.backgroundColor = ColorFactoryClassic.interactiveBlue
        baseButton.cornerRadius = 4
        
        acceptButton.setTitleColor(ColorFactoryClassic.white, for: .normal)
        acceptButton.backgroundColor = ColorFactoryClassic.interactiveBlue
        acceptButton.cornerRadius = 4

        cancelButton.setTitleColor(ColorFactoryClassic.interactiveBlue, for: .normal)
        cancelButton.backgroundColor = ColorFactoryClassic.white
        cancelButton.borderColor = ColorFactoryClassic.interactiveBlue
        cancelButton.borderWidth = 1
        cancelButton.cornerRadius = 4
        
        numberPadButton.setTitleColor(ColorFactoryClassic.interactiveBlue, for: .normal)
        numberPadButton.backgroundColor = ColorFactoryClassic.white
        numberPadButton.borderColor = ColorFactoryClassic.interactiveBlue
        numberPadButton.borderWidth = 1
        numberPadButton.cornerRadius = 4
        
        textField.placeHolderColor = ColorFactoryClassic.elephant
        textField.tintColor = ColorFactoryClassic.elephant
        textField.tintAdjustmentMode = .normal
        
        segmentedControl.backgroundColor = ColorFactoryClassic.white
        segmentedControl.borderColor = ColorFactoryClassic.interactiveBlue
        segmentedControl.tintColor = ColorFactoryClassic.interactiveBlue
        
        segmentedControl.setTitleTextAttributes([NSAttributedStringKey.font : UIFont.systemFont(ofSize: 15), NSAttributedStringKey.foregroundColor: ColorFactoryClassic.interactiveBlue], for: .normal)
        segmentedControl.setTitleTextAttributes([NSAttributedStringKey.font : UIFont.systemFont(ofSize: 15), NSAttributedStringKey.foregroundColor: ColorFactoryClassic.white], for: .selected)
        
        applyTabbarAppearance(tabBar: UITabBar.appearance(), andTabBarItem: UITabBarItem.appearance(whenContainedInInstancesOf: [UITabBar.self]))
    }*/
}
