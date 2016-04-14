//
//  XTRSwapableViewController.m
//  PrimaMateria
//
//  Created by Jerry Porter on 11/30/11.
//  Copyright (c) 2011 xTrensa. All rights reserved.
//

@implementation XTRSwapableViewController

- (void)setupUI { }

#pragma mark - View Management Methods

- (BOOL) shouldAutorotateToInterfaceOrientation: (UIInterfaceOrientation) interfaceOrientation {
    return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

@end
