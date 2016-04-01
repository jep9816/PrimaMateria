//
//  ElementInspectorSeque.m
//  PrimaMateria
//
//  Created by Jerry Porter on 12/6/11.
//  Copyright 2016 xTrensa. All rights reserved.
//

#import "PrimaMateria.h"

@implementation ElementInspectorSeque

- (void)perform {
    BOOL defaultState = [XTRPropertiesStore retreiveShowTransitionsState];
    
    if (defaultState) {
        UIView *sourceView = ((UIViewController *)self.sourceViewController).view;
        UIView *theWindow = sourceView.superview;
        
        [sourceView removeFromSuperview];
        [self.sourceViewController presentViewController: self.destinationViewController animated:NO completion: NULL];
        
        CATransition *animation = [CATransition animation];
        animation.duration = 1.0;
        animation.type = kCATransitionPush;
        animation.subtype = kCATransitionMoveIn;
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        [theWindow.layer addAnimation:animation forKey:@"SwitchInspectorView"];
    }
}

@end
