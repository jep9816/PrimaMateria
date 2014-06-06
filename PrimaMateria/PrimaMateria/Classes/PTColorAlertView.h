//
//  PTColorAlertView.h
//  PrimaMateria
//
//  Created by Jerry Porter on 3/16/10.
//  Copyright 2014 xTrensa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PTColorAlertView : UIAlertView {
    UISlider *hueSlider;
    UISlider *saturationSlider;
    UISlider *brightnessSlider;

    UILabel *hueLabel;
    UILabel *saturationLabel;
    UILabel *brightnessLabel;
    UIView *previewView;
}

@property (nonatomic, strong) UISlider *hueSlider;
@property (nonatomic, strong) UISlider *saturationSlider;
@property (nonatomic, strong) UISlider *brightnessSlider;

@property (nonatomic, strong) UILabel *hueLabel;
@property (nonatomic, strong) UILabel *saturationLabel;
@property (nonatomic, strong) UILabel *brightnessLabel;

@property (nonatomic, strong) UIView *previewView;

//- (void) presetSlidersWithColor: (UIColor *) color;
- (UIColor *) getColor;
- (void) setColor: (UIColor *) aColor;

@end
