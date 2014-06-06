//
//  ElementInspectorSeque.m
//  PrimaMateria
//
//  Created by Jerry Porter on 12/6/11.
//  Copyright 2014 xTrensa. All rights reserved.
//

#import "PrimaMateria.h"

@implementation ElementInspectorSeque

- (void)perform {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    BOOL defaultState = [userDefaults boolForKey: SHOW_TRANSITIONS_DEFAULT];
    if (defaultState) {
        UIView *sourceView = ((UIViewController *)self.sourceViewController).view;
        UIView *theWindow = [sourceView superview];
        
        [sourceView removeFromSuperview];
        [self.sourceViewController presentModalViewController: self.destinationViewController animated:NO];
        
        CATransition *animation = [CATransition animation];
        [animation setDuration:1.0];
        [animation setType:kCATransitionPush];
        [animation setSubtype:kCATransitionMoveIn];
        [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
        [[theWindow layer] addAnimation:animation forKey:@"SwitchInspectorView"];
    }
}

@end
