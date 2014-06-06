//
//  XTRShadowView.m
//  PrimaMateria
//
//  Created by Jerry Porter on 1/5/2011.
//  Copyright 2014 xTrensa. All rights reserved.
//

#import "PrimaMateria.h"

@implementation XTRShadowView

- (void) drawRect: (CGRect) rect {
    [super drawRect: rect];
    UIView *superView = self.superview;
    CALayer *sublayer = [CALayer layer];
    sublayer.backgroundColor = [UIColor clearColor].CGColor;
    sublayer.shadowOffset = CGSizeMake(5.0f, 5.0f);
    sublayer.shadowRadius = 10.0f;
    sublayer.shadowColor = [UIColor blackColor].CGColor;
    sublayer.shadowOpacity = 1.0;
    sublayer.frame = CGRectMake(self.frame.origin.x + 1, self.frame.origin.y + 1, self.frame.size.width - 2, self.frame.size.height - 2);
    sublayer.borderColor = [UIColor blackColor].CGColor;
    sublayer.backgroundColor = [UIColor blackColor].CGColor;
    sublayer.borderWidth = 1.0;
    sublayer.cornerRadius = 10.0;
    [superView.layer addSublayer: sublayer];
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 10.0f;
    self.layer.borderColor = [UIColor colorWithRed: 0.0f green: 0.0f blue: 0.0f alpha: 0.5f].CGColor;
    self.layer.borderWidth = 3.0f;
    self.opaque = NO;
    [superView bringSubviewToFront: self];
}

@end
