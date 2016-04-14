//
//  XTRAppDelegate.m
//  PrimaMateria
//
//  Created by Jerry Porter on 11/21/11.
//  Copyright 2016 xTrensa. All rights reserved.
//

@implementation XTRAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window.rootViewController.modalPresentationStyle = UIModalPresentationCurrentContext;
    
    [XTRAppDelegate applyStyle];
    return YES;
}

+(UIStoryboard *)storyboard {
    return [UIStoryboard storyboardWithName: MAIN_STORY_BOARD bundle:nil];
}

+ (void)applyStyle {
    UINavigationBar *navigationBarAppearance = [UINavigationBar appearance];
    UIToolbar *toolBarAppearance = [UIToolbar appearance];
    UITabBar *tabBarAppearance = [UITabBar appearance];
    UITabBarItem *tabBarItemAppearance = [UITabBarItem appearance];
    UISegmentedControl *segmentedControlBarAppearance = [UISegmentedControl appearance];
    UISwitch *switchAppearance = [UISwitch appearance];

    NSDictionary *navigationBarTextAttributes = @{
                                                  NSForegroundColorAttributeName: UIColor.whiteColor,
                                                  NSFontAttributeName: [UIFont boldSystemFontOfSize: 20]
                                                  };
    NSDictionary *tabBarNormalItemTextAttributes = @{
                                                  NSForegroundColorAttributeName: UIColor.whiteColor,
                                                  NSFontAttributeName: [UIFont boldSystemFontOfSize: 14]
                                                  };
    NSDictionary *tabBarSelectedItemTextAttributes = @{
                                                     NSForegroundColorAttributeName: [UIColor colorWithHexString:@"333333"],
                                                     NSFontAttributeName: [UIFont boldSystemFontOfSize: 14]
                                                     };

    NSDictionary *segmentedControlTextAttributes = @{
                                                     NSForegroundColorAttributeName: UIColor.whiteColor,
                                                     NSFontAttributeName: [UIFont systemFontOfSize: 13]
                                                     };
    
    navigationBarAppearance.titleTextAttributes = navigationBarTextAttributes;
    navigationBarAppearance.tintColor = [UIColor colorWithHexString:@"eeeeee"];
    
    toolBarAppearance.tintColor = [UIColor colorWithHexString:@"eeeeee"];

    [tabBarItemAppearance setTitleTextAttributes:tabBarNormalItemTextAttributes forState:UIControlStateNormal];
    [tabBarItemAppearance setTitleTextAttributes:tabBarSelectedItemTextAttributes forState:UIControlStateSelected];

    tabBarAppearance.tintColor = [UIColor colorWithHexString:@"333333"];
    tabBarAppearance.backgroundColor = [UIColor colorWithHexString:@"999999"];
    //[tabBarAppearance setSelectionIndicatorImage: [UIImage imageNamed: @"SelectedTab"]];
    

    [segmentedControlBarAppearance setTitleTextAttributes: segmentedControlTextAttributes forState: UIControlStateNormal];
    
    switchAppearance.onTintColor = [UIColor colorWithHexString:@"666666"];
}

-(UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window {
    return UIInterfaceOrientationMaskLandscape;
}

@end
