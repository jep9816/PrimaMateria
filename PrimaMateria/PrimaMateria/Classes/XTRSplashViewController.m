//
//  XTRSplashViewController.m
//  PrimaMateria
//
//  Created by Jerry Porter on 11/21/11.
//  Copyright 2014 xTrensa. All rights reserved.
//

#import "PrimaMateria.h"

@implementation XTRSplashViewController

#pragma mark View Management Methods

-(void) wait : (id) sender {
    [NSThread sleepForTimeInterval : 5.0];
    [self.view removeFromSuperview];
}

- (void) viewDidLoad {
    [super viewDidLoad];
    self.appNameLabel.text = XTRVersionChecker.appNameString;
    self.versionLabel.text = XTRVersionChecker.appVersionString;
    self.cpyRightLabel.text = XTRVersionChecker.copywriteString;
    [NSThread detachNewThreadSelector : @selector(wait:) toTarget : self withObject : nil];
}

- (BOOL) shouldAutorotateToInterfaceOrientation: (UIInterfaceOrientation) interfaceOrientation {
    return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

#pragma mark - Memory Management Methods

- (void) dealloc {
    self.appNameLabel = nil;
    self.versionLabel = nil;
    self.cpyRightLabel = nil;
}

@end
