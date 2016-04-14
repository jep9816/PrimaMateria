//
//  DividerLabel.h
//  PrimaMateria
//
//  Created by Jerry Porter on 1/5/2011.
//  Copyright (c) 2016 xTrensa. All rights reserved.
//

@interface DividerLabel : UILabel

@property (nonatomic, strong) UIColor *highColor;
@property (nonatomic, strong) UIColor *lowColor;

- (void)setHigh_Color: (UIColor*)color;
- (void)setLow_Color: (UIColor*)color;
- (void)createLayer;
- (void)setupColors;

@end
