//
//  AppearanceManagerClassic.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 6/24/18.
//  Copyright © 2018 xTrensa. All rights reserved.
//

import UIKit

class XTRAppearanceManagerClassic: NSObject {
    
    func appearance() {
        activityIndicatorViewAppearance()
        barButtonItemAppearance()
        barItemAppearance()
        navigationBarAppearance()
        pageControlAppearance()
        progressViewAppearance()
        searchBarAppearance()
        segmentedControlAppearance()
        sliderAppearance()
        stepperAppearance()
        switchAppearance()
        tabBarAppearance()
        tabBarItemAppearance()
        tableViewAppearance()
        tableViewCellAppearance()
        toolbarAppearance()
        viewAppearance()
        miscAppearance()
    }
    
    func activityIndicatorViewAppearance() {
        //@property(nullable, readwrite, nonatomic, strong) UIColor *color;
    }
    
    func barButtonItemAppearance() {
        let appearance = UIBarButtonItem.appearance()
        appearance.tintColor = XTRColorFactoryClassic.doveGrayColor
        
        //- (void)setBackgroundImage:(nullable UIImage *)backgroundImage forState:(UIControl.State)state barMetrics:(UIBarMetrics)barMetrics;
        //- (nullable UIImage *)backgroundImageForState:(UIControl.State)state barMetrics:(UIBarMetrics)barMetrics;
        //- (void)setBackgroundImage:(nullable UIImage *)backgroundImage forState:(UIControl.State)state style:(UIBarButtonItemStyle)style barMetrics:(UIBarMetrics)barMetrics;
        //- (nullable UIImage *)backgroundImageForState:(UIControl.State)state style:(UIBarButtonItemStyle)style barMetrics:(UIBarMetrics)barMetrics;
        //- (void)setBackgroundVerticalPositionAdjustment:(CGFloat)adjustment forBarMetrics:(UIBarMetrics)barMetrics;
        //- (CGFloat)backgroundVerticalPositionAdjustmentForBarMetrics:(UIBarMetrics)barMetrics;
        //- (void)setTitlePositionAdjustment:(UIOffset)adjustment forBarMetrics:(UIBarMetrics)barMetrics;
        //- (UIOffset)titlePositionAdjustmentForBarMetrics:(UIBarMetrics)barMetrics;
        //- (void)setBackButtonBackgroundImage:(nullable UIImage *)backgroundImage forState:(UIControl.State)state barMetrics:(UIBarMetrics)barMetrics;
        //- (nullable UIImage *)backButtonBackgroundImageForState:(UIControl.State)state barMetrics:(UIBarMetrics)barMetrics;
        //- (void)setBackButtonTitlePositionAdjustment:(UIOffset)adjustment forBarMetrics:(UIBarMetrics)barMetrics;
        //- (UIOffset)backButtonTitlePositionAdjustmentForBarMetrics:(UIBarMetrics)barMetrics;
        //- (void)setBackButtonBackgroundVerticalPositionAdjustment:(CGFloat)adjustment forBarMetrics:(UIBarMetrics)barMetrics;
        //- (CGFloat)backButtonBackgroundVerticalPositionAdjustmentForBarMetrics:(UIBarMetrics)barMetrics;
    }
    
    func barItemAppearance() {
        //- (void)setTitleTextAttributes:(nullable NSDictionary<NSAttributedString.Key,id> *)attributes forState:(UIControl.State)state;
        //- (nullable NSDictionary<NSString *,id> *)titleTextAttributesForState:(UIControl.State)state;
    }

    func navigationBarAppearance() {
        let appearance = UINavigationBar.appearance()
        let navigationBarTextAttributes = [
            NSAttributedString.Key.foregroundColor: XTRColorFactoryClassic.white,
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 30)
        ]

        appearance.setTitleVerticalPositionAdjustment(5.0, for: .default)
        appearance.titleTextAttributes = navigationBarTextAttributes
        appearance.barTintColor = XTRColorFactoryClassic.inkwell
        appearance.tintColor = XTRColorFactoryClassic.galleryColor
        appearance.backgroundColor = XTRColorFactoryClassic.inkwell

        //@property(nonatomic,assign) UIBarStyle barStyle;
        //@property(nonatomic,assign,getter=isTranslucent) BOOL translucent;
        //@property(nonatomic, readwrite, assign) BOOL prefersLargeTitles;
        //@property(nullable, nonatomic,strong) UIColor *barTintColor;
        //- (void)setBackgroundImage:(nullable UIImage *)backgroundImage forBarPosition:(UIBarPosition)barPosition barMetrics:(UIBarMetrics)barMetrics;
        //- (nullable UIImage *)backgroundImageForBarPosition:(UIBarPosition)barPosition barMetrics:(UIBarMetrics)barMetrics;
        //- (void)setBackgroundImage:(nullable UIImage *)backgroundImage forBarMetrics:(UIBarMetrics)barMetrics;
        //- (nullable UIImage *)backgroundImageForBarMetrics:(UIBarMetrics)barMetrics;
        //@property(nullable, nonatomic,strong) UIImage *shadowImage;
        //@property(nullable,nonatomic,copy) NSDictionary<NSAttributedString.Key, id> *titleTextAttributes;
        //@property(nullable, nonatomic, copy) NSDictionary<NSAttributedString.Key, id> *largeTitleTextAttributes;
        //- (void)setTitleVerticalPositionAdjustment:(CGFloat)adjustment forBarMetrics:(UIBarMetrics)barMetrics;
        //- (CGFloat)titleVerticalPositionAdjustmentForBarMetrics:(UIBarMetrics)barMetrics;
        //@property(nullable,nonatomic,strong) UIImage *backIndicatorImage;
        //@property(nullable,nonatomic,strong) UIImage *backIndicatorTransitionMaskImage;
    }
    
    func pageControlAppearance() {
        let appearance = UIPageControl.appearance()
        
        appearance.pageIndicatorTintColor = XTRColorFactoryClassic.dodgerBlueColor
        appearance.currentPageIndicatorTintColor = XTRColorFactoryClassic.alert
        
        //@property(nullable, nonatomic,strong) UIColor *pageIndicatorTintColor;
        //@property(nullable, nonatomic,strong) UIColor *currentPageIndicatorTintColor;
    }
    
    func progressViewAppearance() {
        //@property(nonatomic, strong, nullable) UIColor* progressTintColor;
        //@property(nonatomic, strong, nullable) UIColor* trackTintColor;
        //@property(nonatomic, strong, nullable) UIImage* progressImage;
        //@property(nonatomic, strong, nullable) UIImage* trackImage;
    }
    
    func searchBarAppearance() {
        //@property(nullable, nonatomic,strong) UIColor *barTintColor;
        //@property(nullable, nonatomic,strong) UIImage *backgroundImage;
        //@property(nullable, nonatomic,strong) UIImage *scopeBarBackgroundImage;
        //- (void)setBackgroundImage:(nullable UIImage *)backgroundImage forBarPosition:(UIBarPosition)barPosition barMetrics:(UIBarMetrics)barMetrics;
        //- (nullable UIImage *)backgroundImageForBarPosition:(UIBarPosition)barPosition barMetrics:(UIBarMetrics)barMetrics;
        //- (void)setSearchFieldBackgroundImage:(nullable UIImage *)backgroundImage forState:(UIControl.State)state;
        //- (nullable UIImage *)searchFieldBackgroundImageForState:(UIControl.State)state;
        //- (void)setImage:(nullable UIImage *)iconImage forSearchBarIcon:(UISearchBarIcon)icon state:(UIControl.State)state;
        //- (nullable UIImage *)imageForSearchBarIcon:(UISearchBarIcon)icon state:(UIControl.State)state;
        //- (void)setScopeBarButtonBackgroundImage:(nullable UIImage *)backgroundImage forState:(UIControl.State)state;
        //- (nullable UIImage *)scopeBarButtonBackgroundImageForState:(UIControl.State)state;
        //- (void)setScopeBarButtonDividerImage:(nullable UIImage *)dividerImage forLeftSegmentState:(UIControl.State)leftState rightSegmentState:(UIControl.State)rightState;
        //- (nullable UIImage *)scopeBarButtonDividerImageForLeftSegmentState:(UIControl.State)leftState rightSegmentState:(UIControl.State)rightState;
        //- (void)setScopeBarButtonTitleTextAttributes:(nullable NSDictionary<NSString *, id> *)attributes forState:(UIControl.State)state;
        //- (nullable NSDictionary<NSString *, id> *)scopeBarButtonTitleTextAttributesForState:(UIControl.State)state;
        //@property(nonatomic) UIOffset searchFieldBackgroundPositionAdjustment;
        //@property(nonatomic) UIOffset searchTextPositionAdjustment;
        //- (void)setPositionAdjustment:(UIOffset)adjustment forSearchBarIcon:(UISearchBarIcon)icon;
        //- (UIOffset)positionAdjustmentForSearchBarIcon:(UISearchBarIcon)icon;
    }
    
    func segmentedControlAppearance() {
        let appearance = UISegmentedControl.appearance()
        let selectedSegmentedControlTextAttributes = [
            NSAttributedString.Key.foregroundColor: XTRColorFactoryClassic.dodgerBlueColor,
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 12)
        ]
        
        appearance.setTitleTextAttributes(selectedSegmentedControlTextAttributes, for: .selected)

        let normalSegmentedControlTextAttributes = [
            NSAttributedString.Key.foregroundColor: XTRColorFactoryClassic.grayColor,
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 12)
        ]
        
        appearance.setTitleTextAttributes(normalSegmentedControlTextAttributes, for: .normal)
        appearance.setTitleTextAttributes(normalSegmentedControlTextAttributes, for: .highlighted)

        appearance.tintColor = XTRColorFactoryClassic.smoke
        appearance.backgroundColor = UIColor.clear

        appearance.setBackgroundImage(UIImage.imageFromColor(XTRColorFactoryClassic.graphite, andSize: CGSize(width: 32, height: 32)), for: UIControl.State.selected, barMetrics: .default)
        appearance.setBackgroundImage(UIImage.imageFromColor(XTRColorFactoryClassic.timberwolf, andSize: CGSize(width: 32, height: 32)), for: UIControl.State.highlighted, barMetrics: .default)
        appearance.setBackgroundImage(UIImage.imageFromColor(XTRColorFactoryClassic.timberwolf, andSize: CGSize(width: 32, height: 32)), for: UIControl.State.normal, barMetrics: .default)

        //- (void)setBackgroundImage:(nullable UIImage *)backgroundImage forState:(UIControl.State)state barMetrics:(UIBarMetrics)barMetrics;
        //- (nullable UIImage *)backgroundImageForState:(UIControl.State)state barMetrics:(UIBarMetrics)barMetrics;
        //- (void)setDividerImage:(nullable UIImage *)dividerImage forLeftSegmentState:(UIControl.State)leftState rightSegmentState:(UIControl.State)rightState barMetrics:(UIBarMetrics)barMetrics;
        //- (nullable UIImage *)dividerImageForLeftSegmentState:(UIControl.State)leftState rightSegmentState:(UIControl.State)rightState barMetrics:(UIBarMetrics)barMetrics;
        //- (void)setTitleTextAttributes:(nullable NSDictionary *)attributes forState:(UIControl.State)state;
        //- (nullable NSDictionary *)titleTextAttributesForState:(UIControl.State)state;
        //- (void)setContentPositionAdjustment:(UIOffset)adjustment forSegmentType:(UISegmentedControlSegment)leftCenterRightOrAlone barMetrics:(UIBarMetrics)barMetrics;
        //- (UIOffset)contentPositionAdjustmentForSegmentType:(UISegmentedControlSegment)leftCenterRightOrAlone barMetrics:(UIBarMetrics)barMetrics;
    }
    
    func sliderAppearance() {
        let appearance = UISlider.appearance()
        
        appearance.minimumTrackTintColor = XTRColorFactoryClassic.caution
        appearance.maximumTrackTintColor = XTRColorFactoryClassic.interactiveBlue
        appearance.thumbTintColor = XTRColorFactoryClassic.dodgerBlueColor
        appearance.setThumbImage("🔘".image(size: CGSize(width: 45, height: 45)), for: .selected)
        appearance.setThumbImage("🔘".image(size: CGSize(width: 45, height: 45)), for: .highlighted)
        appearance.setThumbImage("🔘".image(size: CGSize(width: 45, height: 45)), for: .normal)

        //open var minimumTrackTintColor: UIColor?
        //open var maximumTrackTintColor: UIColor?
        //open var thumbTintColor: UIColor?
        //open func setThumbImage(_ image: UIImage?, for state: UIControl.State)
        //open func setMinimumTrackImage(_ image: UIImage?, for state: UIControl.State)
        //open func setMaximumTrackImage(_ image: UIImage?, for state: UIControl.State)
        //open func thumbImage(for state: UIControl.State) -> UIImage?
        //open func minimumTrackImage(for state: UIControl.State) -> UIImage?
        //open func maximumTrackImage(for state: UIControl.State) -> UIImage?
    }

    func stepperAppearance() {
        let appearance = UIStepper.appearance()
        
        appearance.tintColor = XTRColorFactoryClassic.interactiveBlue
        
        //open var tintColor: UIColor!
        //- (void)setBackgroundImage:(nullable UIImage*)image forState:(UIControl.State)state;
        //- (nullable UIImage*)backgroundImageForState:(UIControl.State)state;
        //- (void)setDividerImage:(nullable UIImage*)image forLeftSegmentState:(UIControl.State)leftState rightSegmentState:(UIControl.State)rightState;
        //- (nullable UIImage*)dividerImageForLeftSegmentState:(UIControl.State)state rightSegmentState:(UIControl.State)state;
        //- (void)setIncrementImage:(nullable UIImage *)image forState:(UIControl.State)state;
        //- (nullable UIImage *)incrementImageForState:(UIControl.State)state;
        //- (void)setDecrementImage:(nullable UIImage *)image forState:(UIControl.State)state;
        //- (nullable UIImage *)decrementImageForState:(UIControl.State)state;
    }
    
    func switchAppearance() {
        let appearance = UISwitch.appearance()
        
        appearance.onTintColor = XTRColorFactoryClassic.favorite
        appearance.tintColor = XTRColorFactoryClassic.white
        appearance.thumbTintColor = XTRColorFactoryClassic.cotton

        //open var onTintColor: UIColor?
        //open var tintColor: UIColor!
        //open var thumbTintColor: UIColor?
        //open var onImage: UIImage?
        //open var offImage: UIImage?
    }
    
    func tabBarAppearance() {
        let appearance = UITabBar.appearance()

        appearance.tintColor = XTRColorFactory.tabBarSelectedForgroundColor
        appearance.backgroundColor = XTRColorFactoryClassic.graphite
        appearance.barTintColor = XTRColorFactoryClassic.graphite
        
        //@property(nullable, nonatomic, strong) UIColor *barTintColor;
        //@property(nonatomic, readwrite, copy, nullable) UIColor *unselectedItemTintColor;
        //@property(nullable, nonatomic, strong) UIColor *selectedImageTintColor;
        //@property(nullable, nonatomic, strong) UIImage *backgroundImage;
        //@property(nullable, nonatomic, strong) UIImage *selectionIndicatorImage;
        //@property(nullable, nonatomic, strong) UIImage *shadowImage;
        //@property(nonatomic) UITabBarItemPositioning itemPositioning;
        //@property(nonatomic) CGFloat itemWidth;
        //@property(nonatomic) CGFloat itemSpacing;
        //@property(nonatomic) UIBarStyle barStyle;
    }
    
    func tabBarItemAppearance() {
        let appearance = UITabBarItem.appearance()
        let normalItemTextAttributes = [
            NSAttributedString.Key.foregroundColor: XTRColorFactoryClassic.white,
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)
        ]
        let selectedItemTextAttributes = [
            NSAttributedString.Key.foregroundColor: XTRColorFactoryClassic.elephant,
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)
        ]
        
        appearance.setTitleTextAttributes(normalItemTextAttributes, for: UIControl.State())
        appearance.setTitleTextAttributes(selectedItemTextAttributes, for: .selected)

        //@property(nonatomic, readwrite, assign) UIOffset titlePositionAdjustment;
        //@property(nonatomic, readwrite, copy, nullable) UIColor *badgeColor;
        //- (void)setBadgeTextAttributes:(nullable NSDictionary<NSString *,id> *)textAttributes forState:(UIControl.State)state;
        //- (nullable NSDictionary<NSString *,id> *)badgeTextAttributesForState:(UIControl.State)state;
    }
    
    func tableViewAppearance() {
        //@property(nonatomic) UIEdgeInsets separatorInset;
        //@property(nonatomic, strong, nullable) UIColor *sectionIndexColor;
        //@property(nonatomic, strong, nullable) UIColor *sectionIndexBackgroundColor;
        //@property(nonatomic, strong, nullable) UIColor *sectionIndexTrackingBackgroundColor;
        //@property(nonatomic, strong, nullable) UIColor *separatorColor;
        //@property(nonatomic, copy, nullable) UIVisualEffect *separatorEffect;
    }
    
    func tableViewCellAppearance() {
        //@property(nonatomic) UIEdgeInsets separatorInset;
        //@property(nonatomic) UITableViewCellFocusStyle focusStyle;
    }
    
    func toolbarAppearance() {
        let appearance = UIToolbar.appearance()
        
        appearance.tintColor = XTRColorFactoryClassic.galleryColor
        appearance.backgroundColor = XTRColorFactoryClassic.inkwell
        appearance.barTintColor = XTRColorFactoryClassic.inkwell

        //@property(nonatomic) UIBarStyle barStyle;
        //@property(nonatomic,assign,getter=isTranslucent) BOOL translucent;
        //@property(nullable, nonatomic, strong) UIColor *barTintColor;
        //- (void)setBackgroundImage:(nullable UIImage *)backgroundImage forToolbarPosition:(UIBarPosition)topOrBottom barMetrics:(UIBarMetrics)barMetrics;
        //- (nullable UIImage *)backgroundImageForToolbarPosition:(UIBarPosition)topOrBottom barMetrics:(UIBarMetrics)barMetrics;
        //- (void)setShadowImage:(nullable UIImage *)shadowImage forToolbarPosition:(UIBarPosition)topOrBottom;
        //- (nullable UIImage *)shadowImageForToolbarPosition:(UIBarPosition)topOrBottom;
    }
    
    func viewAppearance() {
        //@property(nullable, nonatomic,copy) UIColor *backgroundColor;
    }
    
    func miscAppearance() {
        let backgroundViewAppearance = XTRBackgroundView.appearance()
        let tableHeaderButtonAppearance = XTRTableHeaderButton.appearance()
        let helpButtonAppearance = XTRHelpButton.appearance()

        backgroundViewAppearance.backgroundColor = XTRColorFactory.backgroundColor
        tableHeaderButtonAppearance.backgroundColor = XTRColorFactoryClassic.armadillo
        
        helpButtonAppearance.setTitleColor(UIColor.black, for: UIControl.State())
        helpButtonAppearance.backgroundColor = XTRColorFactory.helpBackgroundColor
    }

}
