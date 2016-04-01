//
//  XTRMainViewController.m
//  PrimaMateria
//
//  Created by Jerry Porter on 11/21/11.
//  Copyright (c) 2011 xTrensa. All rights reserved.
//

#import "PrimaMateria.h"

@interface XTRMainViewController ()
- (void)customizeTabBarItems;
- (void)showSplash;
@end

@implementation XTRMainViewController

- (void)customizeTabBarItems {
    CGRect rect = self.tabBar.frame;
    CGSize newSize = CGSizeMake(90, rect.size.height);
    UIImage *selectionImage = [UIImage imageWithColor: UIColor.lightGrayColor size: newSize];
    UIImageView *imageView = [[UIImageView alloc] initWithImage: selectionImage];
    
    UIGraphicsBeginImageContextWithOptions(imageView.bounds.size, NO, [UIScreen mainScreen].scale);
    
    [[UIBezierPath bezierPathWithRoundedRect:imageView.bounds cornerRadius: 8.0] addClip];
    [selectionImage drawInRect:imageView.bounds];
    
    self.tabBar.selectionIndicatorImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
}

-(void) showSplash {
    BOOL defaultState = [XTRPropertiesStore retreiveSplashScreenState];
    
    if (defaultState) {
        UIStoryboard *storyboard =[UIStoryboard storyboardWithName:MAIN_STORY_BOARD bundle:nil];
        XTRSplashViewController *splashViewController = [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([XTRSplashViewController class])];
        [self.view addSubview : splashViewController.view];
    }
}

#pragma mark - UITabBarControllerDelegate Methods

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {

    BOOL defaultState = [XTRPropertiesStore retreiveShowTransitionsState];
    
    if (defaultState) {
        UIViewController *currentVC = tabBarController.selectedViewController;
        
        if (currentVC == viewController) {
            return NO;
        }
        
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
    [self customizeTabBarItems];

    //self.delegate = self;
}

- (BOOL) shouldAutorotateToInterfaceOrientation: (UIInterfaceOrientation) interfaceOrientation {
    return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

#pragma mark - Memory Management Methods

@end
