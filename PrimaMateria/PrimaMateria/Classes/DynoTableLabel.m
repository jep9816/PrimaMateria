//
//  DynoTableLabel.m
//  PrimaMateria
//
//  Created by Jerry Porter on 1/5/2011.
//  Copyright 2016 xTrensa. All rights reserved.
//

@interface DynoTableLabel() {
    UIEdgeInsets edgeInsets;
}

@end

@implementation DynoTableLabel

- (instancetype)initWithFrame: (CGRect)aFrame andColor: (UIColor *)aColor {
    if (self = [super initWithFrame: aFrame]) {
        self.backgroundColor = aColor;
        edgeInsets = UIEdgeInsetsMake(0, 5, 0, 5);
    }
    return self;
}

- (void)drawTextInRect: (CGRect)rect {
    [super drawTextInRect: UIEdgeInsetsInsetRect(rect, edgeInsets)];
}

#pragma mark - Memory Management Methods

@end
