//
//  GeneralButton.m
//  PrimaMateria
//
//  Created by Jerry Porter on 1/5/2011.
//  Copyright 2016 xTrensa. All rights reserved.
//

@implementation GeneralButton

- (void)createLayer {
	self.layer.cornerRadius = 8.0f;
	self.layer.masksToBounds = YES;
	self.layer.borderWidth = 1.0f;
    self.layer.borderColor = UIColor.darkGrayColor.CGColor;
	[self setupColors];
}

- (void)setupColors {
}

- (void)awakeFromNib {
	[super awakeFromNib];
    
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.backgroundColor = [UIColor colorWithHexString:@"cccccc"];
    [self setTitleColor: UIColor.whiteColor forState: UIControlStateNormal];
	[self createLayer];
}

#pragma mark - Memory Management Methods

@end
