//
//  XTRCornerImageView.h
//  PrimaMateria
//
//  Created by Jerry Porter on 1/5/2011.
//  Copyright 2016 xTrensa. All rights reserved.
//

@interface XTRCornerImageView : UIImageView

@property (nonatomic, strong) CAGradientLayer *gradientLayer;

- (void)createLayer;

@end
