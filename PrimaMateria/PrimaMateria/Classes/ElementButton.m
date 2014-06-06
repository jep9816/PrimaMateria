//
//  ElementButton.m
//  PrimaMateria
//
//  Created by Jerry Porter on 1/5/2011.
//  Copyright 2014 xTrensa. All rights reserved.
//

#import "PrimaMateria.h"

@implementation ElementButton

- (void)setupColors {
	self.backgroundColor = [[[XTRDataSource sharedInstance] elementAtIndex: [self tag]] seriesColor];
}

- (void)awakeFromNib {
	[super awakeFromNib];
	[self setTitleColor:[[[XTRDataSource sharedInstance] elementAtIndex: [self tag]] standardConditionColor] forState:UIControlStateNormal];
}

@end
