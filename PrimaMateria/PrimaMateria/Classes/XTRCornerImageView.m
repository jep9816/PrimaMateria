//
//  XTRCornerImageView.m
//  PrimaMateria
//
//  Created by Jerry Porter on 1/5/2011.
//  Copyright 2014 xTrensa. All rights reserved.
//

#import "PrimaMateria.h"

@implementation XTRCornerImageView
@synthesize gradientLayer;

- (void) createLayer {
    gradientLayer = [[CAGradientLayer alloc] init];
    gradientLayer.bounds = self.bounds;
    gradientLayer.position = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2);
    [self.layer insertSublayer: gradientLayer atIndex: 0];
    self.layer.cornerRadius = 10.0f;
    self.layer.masksToBounds = YES;
}

- (void) awakeFromNib {
    [super awakeFromNib];
    [self createLayer];
}

#pragma mark - Memory Management Methods


@end
