//
//  DividerLabel.m
//  PrimaMateria
//
//  Created by Jerry Porter on 1/5/2011.
//  Copyright 2016 xTrensa. All rights reserved.
//

#import "PrimaMateria.h"

@implementation DividerLabel
@synthesize highColor;
@synthesize lowColor;
@synthesize gradientLayer;

- (void)createLayer {    
	self.layer.masksToBounds = YES;
	[self setupColors];
}

- (void)setupColors {
	self.textColor = UIColor.whiteColor;
	[self setHigh_Color: UIColor.lightGrayColor];
	[self setLow_Color: UIColor.grayColor];
}

- (void)awakeFromNib {
	[super awakeFromNib];
	[self createLayer];
}

- (void)setHigh_Color:(UIColor*)color {
	highColor = color;
	[self.layer setNeedsDisplay];
}

- (void)setLow_Color:(UIColor*)color {
	lowColor = color;
	[self.layer setNeedsDisplay];
}

#pragma mark - Memory Management Methods

@end
