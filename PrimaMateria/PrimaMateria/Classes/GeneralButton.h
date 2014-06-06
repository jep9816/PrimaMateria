//
//  ElementButton.h
//  PrimaMateria
//
//  Created by Jerry Porter on 1/5/2011.
//  Copyright 2014 xTrensa. All rights reserved.
//

@interface GeneralButton : UIButton

@property (nonatomic, strong) UIColor *highColor;
@property (nonatomic, strong) UIColor *lowColor;

-(void)setHigh_Color : (UIColor*)color;
-(void)setLow_Color : (UIColor*)color;
-(void)setupColors;
-(void)createLayer;

@end
