//
//  ElementButton.m
//  PrimaMateria
//
//  Created by Jerry Porter on 1/5/2011.
//  Copyright 2016 xTrensa. All rights reserved.
//

@interface ElementButton()

-(void)colorChanged: (NSNotification *)aNotification;

@end

@implementation ElementButton

-(void)colorChanged: (NSNotification *)aNotification {
    [self setupColors];
    [self setNeedsDisplay];
}

- (void)setupColors {
    UIColor *backgroundColor = [[XTRDataSource sharedInstance] elementAtIndex: self.tag].seriesColor;
    UIColor *selectedColor = [UIColor reverseColorOf: backgroundColor];
    UIImage *backgroundImage = [UIImage imageWithColor: backgroundColor size: self.frame.size];
    UIImage *selectedImage = [UIImage imageWithColor: selectedColor size: self.frame.size];
    
    [self setBackgroundImage: backgroundImage forState: UIControlStateNormal];
    [self setBackgroundImage: selectedImage forState: UIControlStateHighlighted];
    [self setBackgroundImage: selectedImage forState: UIControlStateSelected];
}

- (void)awakeFromNib {
	[super awakeFromNib];
    
    self.backgroundColor = UIColor.clearColor;
    
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(colorChanged:) name: NOTIFICATION_SERIES_COLOR_CHANGED object: nil];
	[self setTitleColor: [[[XTRDataSource sharedInstance] elementAtIndex: self.tag] standardConditionColor] forState: UIControlStateNormal];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver: self name: NOTIFICATION_SERIES_COLOR_CHANGED object: nil];
}

@end
