//
// DynoTableCell.m
// PrimaMateria
//
//  Created by Jerry Porter on 1/5/2011.
//  Copyright 2014 xTrensa. All rights reserved.
//

#import "PrimaMateria.h"

@interface DynoTableLabel() {
    UIEdgeInsets edgeInsets;
}

@end

@implementation DynoTableLabel

- (id) initWithFrame: (CGRect) frame andColor: (UIColor *) aColor {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = aColor;
        edgeInsets = UIEdgeInsetsMake(0, 5, 0, 5);
    }
    return self;
}

- (void)drawTextInRect:(CGRect)rect {
    [super drawTextInRect:UIEdgeInsetsInsetRect(rect, edgeInsets)];
}

#pragma mark - Memory Management Methods

@end
