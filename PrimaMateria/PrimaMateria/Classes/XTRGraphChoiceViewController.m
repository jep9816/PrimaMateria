//
//  XTRGraphChoiceViewController.m
//  PrimaMateria
//
//  Created by Jerry Porter on 3/13/10.
//  Copyright 2016 xTrensa. All rights reserved.
//

#import "PrimaMateria.h"

@implementation XTRGraphChoiceViewController

#pragma mark - Action Methods

- (IBAction)chooseGraph: (id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName: NOTIFICATION_GRAPH_SELECTED object: @([sender tag])];
}

#pragma mark - View Management Methods

- (BOOL) shouldAutorotateToInterfaceOrientation: (UIInterfaceOrientation) interfaceOrientation {
    return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

#pragma mark - Memory Management Methods

@end
