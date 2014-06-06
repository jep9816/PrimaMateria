//
//  XTRMainViewController.m
//  PrimaMateria
//
//  Created by Jerry Porter on 11/21/11.
//  Copyright (c) 2011 xTrensa. All rights reserved.
//

#import "PrimaMateria.h"

@implementation XTRMainViewController

-(void) showSplash {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    BOOL defaultState = [userDefaults boolForKey: SPLASH_SCREEN_DEFAULT];
    if (defaultState) {
        UIStoryboard *storyboard =[UIStoryboard storyboardWithName:MAIN_STORY_BOARD bundle:nil];
        XTRSplashViewController *splashViewController = [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([XTRSplashViewController class])];
        [self.view addSubview : splashViewController.view];
    }
}

#pragma mark - UITabBarControllerDelegate Methods

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    BOOL defaultState = [userDefaults boolForKey: SHOW_TRANSITIONS_DEFAULT];
    if (defaultState) {
        UIViewController *currentVC = [tabBarController selectedViewController];
        if (currentVC == viewController) 
            return NO;
        
        [UIView beginAnimations:@"View Flip" context:nil];
        [UIView setAnimationDuration:1.5];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationTransition: UIViewAnimationTransitionCurlUp forView:tabBarController.view cache:YES];
        [currentVC viewWillAppear:YES];
        [viewController viewWillDisappear:YES];
        [viewController viewDidDisappear:YES];
        [currentVC viewDidAppear:YES];
        [UIView commitAnimations];
    }
	return YES;
}

#pragma mark - View Management Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    [self showSplash];
    self.delegate = self;
}

- (BOOL) shouldAutorotateToInterfaceOrientation: (UIInterfaceOrientation) interfaceOrientation {
    return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

#pragma mark - Memory Management Methods

@end
