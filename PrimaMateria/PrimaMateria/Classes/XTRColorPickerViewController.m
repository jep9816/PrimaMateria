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

- (IBAction)selectColor: (id)sender {
    NSArray *values = @[@(self.redSlider.value), @(self.greenSlider.value), @(self.blueSlider.value), self.colorTitle.text];
    NSArray *keys = @[RED_COLOR_COMPONENT, GREEN_COLOR_COMPONENT, BLUE_COLOR_COMPONENT, COLOR_KEY];
    NSDictionary *dict = [NSDictionary dictionaryWithObjects: values forKeys: keys];
	[[NSNotificationCenter defaultCenter] postNotificationName: NOTIFICATION_COLOR_SELECTED object: dict];
}

- (void)presetSlidersWithColor: (UIColor *) aColor {
    const CGFloat *clr = CGColorGetComponents(aColor.CGColor);
    [self.redSlider setValue: clr[0] animated: YES];
    [self.greenSlider setValue: clr[1] animated: YES];
    [self.blueSlider setValue: clr[2] animated: YES];
    self.previewView.backgroundColor = [UIColor colorWithRed: self.redSlider.value green: self.greenSlider.value blue: self.blueSlider.value alpha: 1.0];
    [self performSelector: @selector(redSliderValueChanged:) withObject: self.redSlider afterDelay: 0.0];
}

- (void)redSliderValueChanged: (UISlider *) slider {
    [UIView beginAnimations: nil context: NULL];
    self.previewView.backgroundColor = [UIColor colorWithRed: slider.value green: self.greenSlider.value blue: self.blueSlider.value alpha: 1.0];
    [UIView commitAnimations];
}

- (void)greenSliderValueChanged: (UISlider *) slider {
    [UIView beginAnimations: nil context: NULL];
    self.previewView.backgroundColor = [UIColor colorWithRed: self.redSlider.value green: slider.value blue: self.blueSlider.value alpha: 1.0];
    [UIView commitAnimations];
}

- (void)blueSliderValueChanged: (UISlider *) slider {
    [UIView beginAnimations: nil context: NULL];
    self.previewView.backgroundColor = [UIColor colorWithRed: self.redSlider.value green: self.greenSlider.value blue: slider.value alpha: 1.0];
    [UIView commitAnimations];
}

- (void)dealloc {
    self.redSlider = nil;
    self.greenSlider = nil;
    self.blueSlider = nil;
    self.redLabel = nil;
    self.greenLabel = nil;
    self.blueLabel = nil;
    self.previewView = nil;
    self.colorTitle = nil;
}

- (BOOL) shouldAutorotateToInterfaceOrientation: (UIInterfaceOrientation) interfaceOrientation {
    return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

@end
