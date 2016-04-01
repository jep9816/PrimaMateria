//
//  XTRColorPickerViewController.m
//  PrimaMateria
//
//  Created by Jerry Porter on 5/11/14.
//  Copyright (c) 2016 xTrensa. All rights reserved.
//

#import "PrimaMateria.h"

@interface XTRColorPickerViewController ()

@end

@implementation XTRColorPickerViewController

@synthesize redSlider;
@synthesize greenSlider;
@synthesize blueSlider;
@synthesize redLabel;
@synthesize greenLabel;
@synthesize blueLabel;
@synthesize previewView;
@synthesize colorTitle;

- (IBAction)selectColor: (id)sender {
    NSArray *values = @[@(redSlider.value), @(greenSlider.value), @(blueSlider.value), colorTitle.text];
    NSArray *keys = @[@"redComponent", @"greenComponent", @"blueComponent", @"selectedTitle"];
    NSDictionary *dict = [NSDictionary dictionaryWithObjects: values forKeys: keys];
	[[NSNotificationCenter defaultCenter] postNotificationName: NOTIFICATION_COLOR_SELECTED object: dict];
}

- (void) presetSlidersWithColor: (UIColor *) aColor {
    const CGFloat *clr = CGColorGetComponents(aColor.CGColor);
    [redSlider setValue: clr[0] animated: YES];
    [greenSlider setValue: clr[1] animated: YES];
    [blueSlider setValue: clr[2] animated: YES];
    previewView.backgroundColor = [UIColor colorWithRed: redSlider.value green: greenSlider.value blue: blueSlider.value alpha: 1.0];
    [self performSelector: @selector(redSliderValueChanged:) withObject: redSlider afterDelay: 0.0];
}

- (void) redSliderValueChanged: (UISlider *) slider {
    [UIView beginAnimations: nil context: NULL];
    previewView.backgroundColor = [UIColor colorWithRed: slider.value green: greenSlider.value blue: blueSlider.value alpha: 1.0];
    [UIView commitAnimations];
}

- (void) greenSliderValueChanged: (UISlider *) slider {
    [UIView beginAnimations: nil context: NULL];
    previewView.backgroundColor = [UIColor colorWithRed: redSlider.value green: slider.value blue: blueSlider.value alpha: 1.0];
    [UIView commitAnimations];
}

- (void) blueSliderValueChanged: (UISlider *) slider {
    [UIView beginAnimations: nil context: NULL];
    previewView.backgroundColor = [UIColor colorWithRed: redSlider.value green: greenSlider.value blue: slider.value alpha: 1.0];
    [UIView commitAnimations];
}

- (void) dealloc {
    redSlider = nil;
    greenSlider = nil;
    blueSlider = nil;
    redLabel = nil;
    greenLabel = nil;
    blueLabel = nil;
    previewView = nil;
    colorTitle = nil;
}

- (BOOL) shouldAutorotateToInterfaceOrientation: (UIInterfaceOrientation) interfaceOrientation {
    return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

@end
