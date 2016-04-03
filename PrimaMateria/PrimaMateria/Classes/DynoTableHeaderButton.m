//
//  DynoTableHeaderButton.m
//  PrimaMateria
//
//  Created by Jerry Porter on 1/5/2011.
//  Copyright 2016 xTrensa. All rights reserved.
//

#import "PrimaMateria.h"

@implementation DynoTableHeaderButton

@synthesize imageLayer;
@synthesize toggle;
@synthesize descentingImageView;
@synthesize ascendingImageView;

- (void)tableHeaderCellSelected: (NSNotification *)aNotification {
    imageLayer.contents = nil;
}

- (void)awakeFromNib {
    [super awakeFromNib];
	[[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(tableHeaderCellSelected:) name: NOTIFICATION_TABLE_HEADER_SELECTED object: nil];
    toggle = 0;
    ascendingImageView = [UIImage imageNamed: @"AscendingArrow.png"];
    descentingImageView = [UIImage imageNamed: @"DescendingArrow.png"];
    imageLayer = [CALayer layer];
    [self.layer addSublayer: imageLayer];
    self.backgroundColor = UIColor.lightGrayColor;
}

- (void)toggleButtonState: (BOOL) aFlag {
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_TABLE_HEADER_SELECTED object: nil];
    [CATransaction begin];
    [CATransaction setAnimationDuration:0.0];
    imageLayer.frame = (aFlag) ? CGRectMake((self.frame.size.width/2) - 6, 2, 12, 12) : CGRectMake((self.frame.size.width/2) - 6, 30, 12, 12);
    imageLayer.contents = (aFlag) ? (id)ascendingImageView.CGImage : (id)descentingImageView.CGImage;
    [CATransaction commit];
    toggle = aFlag;
}

- (BOOL)toggleState {
    [self toggleButtonState: 1 - toggle];
    return toggle;
}

- (void)createLayer {
    self.layer.masksToBounds = YES;
    self.layer.borderWidth = 1.0f;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver: self];
}

@end

