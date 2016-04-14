//
//  DynoTableHeaderButton.m
//  PrimaMateria
//
//  Created by Jerry Porter on 1/5/2011.
//  Copyright (c) 2016 xTrensa. All rights reserved.
//

@implementation DynoTableHeaderButton

- (void)tableHeaderCellSelected: (NSNotification *)aNotification {
    self.imageLayer.contents = nil;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
	[[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(tableHeaderCellSelected:) name: NOTIFICATION_TABLE_HEADER_SELECTED object: nil];
    self.toggle = 0;
    self.ascendingImageView = [UIImage imageNamed: @"AscendingArrow.png"];
    self.descentingImageView = [UIImage imageNamed: @"DescendingArrow.png"];
    self.imageLayer = [CALayer layer];
    [self.layer addSublayer: self.imageLayer];
    self.backgroundColor = UIColor.lightGrayColor;
}

- (void)toggleButtonState: (BOOL) aFlag {
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_TABLE_HEADER_SELECTED object: nil];
    [CATransaction begin];
    [CATransaction setAnimationDuration:0.0];
    self.imageLayer.frame = (aFlag) ? CGRectMake((self.frame.size.width/2) - 6, 2, 12, 12) : CGRectMake((self.frame.size.width/2) - 6, 30, 12, 12);
    self.imageLayer.contents = (aFlag) ? (id)self.ascendingImageView.CGImage : (id)self.descentingImageView.CGImage;
    [CATransaction commit];
    self.toggle = aFlag;
}

- (BOOL)toggleState {
    [self toggleButtonState: !self.toggle];
    return self.toggle;
}

- (void)createLayer {
    self.layer.masksToBounds = YES;
    self.layer.borderWidth = 1.0f;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver: self];
}

@end

