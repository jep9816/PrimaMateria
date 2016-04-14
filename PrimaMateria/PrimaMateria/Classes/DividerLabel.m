//
//  DividerLabel.m
//  PrimaMateria
//
//  Created by Jerry Porter on 1/5/2011.
//  Copyright (c) 2016 xTrensa. All rights reserved.
//

@implementation DividerLabel

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

- (void)setHigh_Color: (UIColor*)color {
	self.highColor = color;
	[self.layer setNeedsDisplay];
}

- (void)setLow_Color: (UIColor*)color {
	self.lowColor = color;
	[self.layer setNeedsDisplay];
}

#pragma mark - Memory Management Methods

@end
