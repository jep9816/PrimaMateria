//
// DynoTableCell.h
// PrimaMateria
//
//  Created by Jerry Porter on 1/5/2011.
//  Copyright 2014 xTrensa. All rights reserved.
//

@interface DynoTableHeaderButton : GeneralButton

@property (nonatomic, strong) CALayer *imageLayer;
@property (nonatomic, strong) UIImage *descentingImageView;
@property (nonatomic, strong) UIImage *ascendingImageView;
@property (nonatomic) NSInteger toggle;

- (BOOL) toggleState;

@end

