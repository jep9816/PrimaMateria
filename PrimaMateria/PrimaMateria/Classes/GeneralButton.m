//
//  ElementButton.m
//  PrimaMateria
//
//  Created by Jerry Porter on 1/5/2011.
//  Copyright 2014 xTrensa. All rights reserved.
//

#import "PrimaMateria.h"

@implementation GeneralButton
@synthesize highColor;
@synthesize lowColor;

- (void)createLayer {
	self.layer.cornerRadius = 8.0f;
	self.layer.masksToBounds = YES;
	self.layer.borderWidth = 1.0f;
	[self setupColors];
}

- (void)setupColors {
    [self setHigh_Color: [UIColor whiteColor]];
    [self setLow_Color: [UIColor grayColor]];
}

- (void)awakeFromNib {
	[super awakeFromNib];
	[self createLayer];
}

- (void)setHigh_Color:(UIColor*)color {
    highColor = color;
    [[self layer] setNeedsDisplay];
}

- (void)setLow_Color:(UIColor*)color {
    lowColor = color;
    [[self layer] setNeedsDisplay];
}

#pragma mark - Memory Management Methods

@end
