//
//  XTRColorPickerViewController.m
//  PrimaMateria
//
//  Created by Jerry Porter on 5/11/14.
//  Copyright (c) 2016 xTrensa. All rights reserved.
//

@interface XTRColorPickerViewController ()

@end

@implementation XTRColorPickerViewController

- (IBAction)selectColor: (id)sender {
    NSArray *values = [NSArray arrayWithObjects: @(self.redSlider.value), @(self.greenSlider.value), @(self.blueSlider.value), self.colorTitle.text, nil];
    NSArray *keys = [NSArray arrayWithObjects: RED_COLOR_COMPONENT, GREEN_COLOR_COMPONENT, BLUE_COLOR_COMPONENT, SERIES_COLOR_KEY, nil];
    NSDictionary *dict = [NSDictionary dictionaryWithObjects: values forKeys: keys];
    [self dismissViewControllerAnimated: YES completion: nil];
	[[NSNotificationCenter defaultCenter] postNotificationName: NOTIFICATION_COLOR_SELECTED object: dict];
}

- (void)presetSlidersWithColor: (UIColor *)aColor {
    [self.redSlider setValue: aColor.red /*clr[0]*/ animated: YES];
    [self.greenSlider setValue: aColor.green /*clr[1]*/ animated: YES];
    [self.blueSlider setValue: aColor.blue /*clr[2]*/ animated: YES];
    self.previewView.backgroundColor = [UIColor colorWithRed: self.redSlider.value green: self.greenSlider.value blue: self.blueSlider.value alpha: 1.0];
    [self performSelector: @selector(redSliderValueChanged:) withObject: self.redSlider afterDelay: 0.0];
}

- (void)redSliderValueChanged: (UISlider *)slider {
    [UIView beginAnimations: nil context: NULL];
    self.previewView.backgroundColor = [UIColor colorWithRed: slider.value green: self.greenSlider.value blue: self.blueSlider.value alpha: 1.0];
    [UIView commitAnimations];
}

- (void)greenSliderValueChanged: (UISlider *)slider {
    [UIView beginAnimations: nil context: NULL];
    self.previewView.backgroundColor = [UIColor colorWithRed: self.redSlider.value green: slider.value blue: self.blueSlider.value alpha: 1.0];
    [UIView commitAnimations];
}

- (void)blueSliderValueChanged: (UISlider *)slider {
    [UIView beginAnimations: nil context: NULL];
    self.previewView.backgroundColor = [UIColor colorWithRed: self.redSlider.value green: self.greenSlider.value blue: slider.value alpha: 1.0];
    [UIView commitAnimations];
}

- (void)dealloc {
    self.redSlider = nil;
    self.greenSlider = nil;
    self.blueSlider = nil;
    self.previewView = nil;
    self.colorTitle = nil;
}

- (BOOL) shouldAutorotateToInterfaceOrientation: (UIInterfaceOrientation) interfaceOrientation {
    return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

@end
