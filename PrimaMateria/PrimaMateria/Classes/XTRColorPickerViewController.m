//
//  XTRColorPickerViewController.m
//  PrimaMateria
//
//  Created by Jerry Porter on 5/11/14.
//  Copyright (c) 2014 xTrensa. All rights reserved.
//

#import "PrimaMateria.h"

@interface XTRColorPickerViewController ()

@end

@implementation XTRColorPickerViewController

@synthesize hueSlider;
@synthesize saturationSlider;
@synthesize brightnessSlider;
@synthesize hueLabel;
@synthesize saturationLabel;
@synthesize brightnessLabel;
@synthesize previewView;
@synthesize colorTitle;
@synthesize chooseColorButton;

- (IBAction)selectColor: (id)sender {
    NSArray *values = [NSArray arrayWithObjects: previewView.backgroundColor, colorTitle.text, nil];
    NSArray *keys = [NSArray arrayWithObjects: @"selectedColor", @"selectedTitle", nil];
    NSDictionary *dict = [NSDictionary dictionaryWithObjects: values forKeys: keys];
	[[NSNotificationCenter defaultCenter] postNotificationName: NOTIFICATION_COLOR_SELECTED object: dict];
}

- (IBAction)cancel: (id)sender {
	[[NSNotificationCenter defaultCenter] postNotificationName: NOTIFICATION_COLOR_SELECTED object: nil];
}

- (void) presetSlidersWithColor: (UIColor *) aColor {
    const CGFloat *clr = CGColorGetComponents(aColor.CGColor);
    [hueSlider setValue: clr[0] animated: YES];
    [saturationSlider setValue: clr[1] animated: YES];
    [brightnessSlider setValue: clr[2] animated: YES];
    previewView.backgroundColor = [UIColor colorWithRed: hueSlider.value green: saturationSlider.value blue: brightnessSlider.value alpha: 1.0];
    [self performSelector: @selector(hueSliderValueChanged:) withObject: hueSlider afterDelay: 0.0];
}

- (void) hueSliderValueChanged: (UISlider *) slider {
    [UIView beginAnimations: nil context: NULL];
    previewView.backgroundColor = [UIColor colorWithRed: slider.value green: saturationSlider.value blue: brightnessSlider.value alpha: 1.0];
    [UIView commitAnimations];
}

- (void) saturationSliderValueChanged: (UISlider *) slider {
    [UIView beginAnimations: nil context: NULL];
    previewView.backgroundColor = [UIColor colorWithRed: hueSlider.value green: slider.value blue: brightnessSlider.value alpha: 1.0];
    [UIView commitAnimations];
}

- (void) brightnessSliderValueChanged: (UISlider *) slider {
    [UIView beginAnimations: nil context: NULL];
    previewView.backgroundColor = [UIColor colorWithRed: hueSlider.value green: saturationSlider.value blue: slider.value alpha: 1.0];
    [UIView commitAnimations];
}

- (void) dealloc {
    hueSlider = nil;
    saturationSlider = nil;
    brightnessSlider = nil;
    hueLabel = nil;
    saturationLabel = nil;
    brightnessLabel = nil;
    previewView = nil;
    colorTitle = nil;
    chooseColorButton = nil;
}

@end
