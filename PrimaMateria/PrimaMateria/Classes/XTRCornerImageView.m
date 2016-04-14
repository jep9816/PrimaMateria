//
//  XTRCornerImageView.m
//  PrimaMateria
//
//  Created by Jerry Porter on 1/5/2011.
//  Copyright (c) 2016 xTrensa. All rights reserved.
//

@implementation XTRCornerImageView

- (void)createLayer {
    self.gradientLayer = [[CAGradientLayer alloc] init];
    self.gradientLayer.bounds = self.bounds;
    self.gradientLayer.position = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2);
    [self.layer insertSublayer: self.gradientLayer atIndex: 0];
    self.layer.cornerRadius = 10.0f;
    self.layer.masksToBounds = YES;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self createLayer];
}

#pragma mark - Memory Management Methods


@end
