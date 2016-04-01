//
//  ElementButton.m
//  PrimaMateria
//
//  Created by Jerry Porter on 1/5/2011.
//  Copyright 2016 xTrensa. All rights reserved.
//

#import "PrimaMateria.h"

@interface ElementButton()
//-(void)colorChanged: (NSNotification *)aNotification;
@end

@implementation ElementButton

//-(void)colorChanged: (NSNotification *)aNotification {
//    self.backgroundColor = [[XTRDataSource sharedInstance] elementAtIndex: self.tag].seriesColor;
//    [self setNeedsDisplay];
//    [self setNeedsLayout];
//}

- (void)setupColors {
	self.backgroundColor = [[XTRDataSource sharedInstance] elementAtIndex: self.tag].seriesColor;
}

- (void)awakeFromNib {
	[super awakeFromNib];
    //[[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(colorChanged:) name: @"notificationColorChanged" object: nil];
	[self setTitleColor:[[[XTRDataSource sharedInstance] elementAtIndex: self.tag] standardConditionColor] forState:UIControlStateNormal];
}

//- (void)dealloc {
//    [[NSNotificationCenter defaultCenter] removeObserver: self name:@"notificationColorChanged" object: nil];
//}

@end
