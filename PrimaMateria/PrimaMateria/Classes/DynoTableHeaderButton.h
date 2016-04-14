//
//  DynoTableHeaderButton.h
//  PrimaMateria
//
//  Created by Jerry Porter on 1/5/2011.
//  Copyright 2016 xTrensa. All rights reserved.
//

@interface DynoTableHeaderButton : GeneralButton

@property (nonatomic, strong) CALayer *imageLayer;
@property (nonatomic, strong) UIImage *descentingImageView;
@property (nonatomic, strong) UIImage *ascendingImageView;
@property (nonatomic) BOOL toggle;

@property (NS_NONATOMIC_IOSONLY, readonly) BOOL toggleState;

@end

