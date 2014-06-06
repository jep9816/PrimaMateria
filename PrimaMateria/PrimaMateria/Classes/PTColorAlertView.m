//
//  PTColorAlertView.m
//  PrimaMateria
//
//  Created by Jerry Porter on 3/16/10.
//  Copyright 2014 xTrensa. All rights reserved.
//

#import "PrimaMateria.h"

@implementation PTColorAlertView
@synthesize hueSlider;
@synthesize saturationSlider;
@synthesize brightnessSlider;
@synthesize hueLabel;
@synthesize saturationLabel;
@synthesize brightnessLabel;
@synthesize previewView;

- (id) initWithFrame: (CGRect) frame {
    if (self = [super initWithFrame: frame]) {
        previewView = [[UIView alloc] initWithFrame: CGRectMake(0, 0, 200, 200)];
        previewView.backgroundColor = [UIColor colorWithHue: 0.0 saturation: 0.0 brightness: 0.0 alpha: 1.0];
        //previewView.opaque = YES;

//        hueLabel = [[UILabel alloc] initWithFrame: CGRectZero];
//        hueLabel.backgroundColor = [UIColor lightGrayColor];
//        hueLabel.text = @" H";
//        hueLabel.textColor = [UIColor redColor];
//        hueLabel.font = [UIFont systemFontOfSize: 20];
//
//        saturationLabel = [[UILabel alloc] initWithFrame: CGRectZero];
//        saturationLabel.backgroundColor = [UIColor lightGrayColor];
//        saturationLabel.text = @" S";
//        saturationLabel.textColor = [UIColor greenColor];
//        saturationLabel.font = [UIFont systemFontOfSize: 20];
//
//        brightnessLabel = [[UILabel alloc] initWithFrame: CGRectZero];
//        brightnessLabel.backgroundColor = [UIColor lightGrayColor];
//        brightnessLabel.text = @" B";
//        brightnessLabel.textColor = [UIColor blueColor];
//        brightnessLabel.font = [UIFont systemFontOfSize: 20];
//
//        hueSlider = [[UISlider alloc] initWithFrame: CGRectZero];
//        hueSlider.minimumValue = 0.0f;
//        hueSlider.maximumValue = 359.0f;
//        [hueSlider addTarget: self action: @selector(hueSliderValueChanged:) forControlEvents: UIControlEventValueChanged];
        //[hueSlider setTransform: CGAffineTransformMakeRotation(0.5 * M_PI)];

//        saturationSlider = [[UISlider alloc] initWithFrame: CGRectZero];
//        saturationSlider.minimumValue = 0.0f;
//        saturationSlider.maximumValue = 1.0f;
//        [saturationSlider addTarget: self action: @selector(saturationSliderValueChanged:) forControlEvents: UIControlEventValueChanged];
        //[saturationSlider setTransform: CGAffineTransformMakeRotation(0.5 * M_PI)];

//        brightnessSlider = [[UISlider alloc] initWithFrame: CGRectZero];
//        brightnessSlider.minimumValue = 0.0f;
//        brightnessSlider.maximumValue = 1.0f;
//        [brightnessSlider addTarget: self action: @selector(brightnessSliderValueChanged:) forControlEvents: UIControlEventValueChanged];
        //[brightnessSlider setTransform: CGAffineTransformMakeRotation(0.5 * M_PI)];

//        [self addSubview: hueLabel];
//        [self addSubview: saturationLabel];
//        [self addSubview: brightnessLabel];
//        [self addSubview: hueSlider];
//        [self addSubview: saturationSlider];
//        [self addSubview: brightnessSlider];
        [self addSubview: previewView];
        
//        [self bringSubviewToFront: hueLabel];
//        [self bringSubviewToFront: saturationLabel];
//        [self bringSubviewToFront: brightnessLabel];
//        
       [self bringSubviewToFront: previewView];
//
//        [self bringSubviewToFront:hueSlider];
//        [self bringSubviewToFront:saturationSlider];
//        [self bringSubviewToFront:brightnessSlider];
    }
    return self;
}

/*- (void) setFrame: (CGRect) rect {
    super.frame = CGRectMake(0, 0, rect.size.width, 310);
    CGSize size = [UIScreen mainScreen].bounds.size;
    self.center = CGPointMake(size.height / 2, size.width / 2);
}*/

/*- (void) layoutSubviews {
    CGFloat buttonTop = 250;
    for (UIView *view in self.subviews) {
        if ([[[view class] description] isEqualToString: @"UIThreePartButton"]) {
            view.frame = CGRectMake(view.frame.origin.x, self.bounds.size.height - view.frame.size.height - 15, view.frame.size.width, view.frame.size.height);
            buttonTop = view.frame.origin.y;
        }
    }
    buttonTop -= 7;
    buttonTop -= 100;
    previewView.frame = CGRectMake(25, buttonTop, self.frame.size.width - 51, 75);
    buttonTop -= 7;
    buttonTop -= 30;
    brightnessLabel.frame = CGRectMake(25, buttonTop, self.frame.size.width - 52, 30);
    brightnessSlider.frame = CGRectMake(brightnessLabel.frame.origin.x + 25, brightnessLabel.frame.origin.y, brightnessLabel.frame.size.width - 25, brightnessLabel.frame.size.height);
    buttonTop -= 30;
    saturationLabel.frame = CGRectMake(25, buttonTop, self.frame.size.width - 52, 30);
    saturationSlider.frame = CGRectMake(saturationLabel.frame.origin.x + 25, saturationLabel.frame.origin.y, saturationLabel.frame.size.width - 25, saturationLabel.frame.size.height);
    buttonTop -= 30;
    hueLabel.frame = CGRectMake(25, buttonTop, self.frame.size.width - 52, 30);
    hueSlider.frame = CGRectMake(hueLabel.frame.origin.x + 25, hueLabel.frame.origin.y, hueLabel.frame.size.width - 25, hueLabel.frame.size.height);
}

- (void) drawRect: (CGRect) rect {
    [super drawRect: rect];
    UIGraphicsBeginImageContext(previewView.frame.size);
    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), 2.0);
    CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), 0.9, 0.9, 1.0, 1.0);
    CGContextSetShadow(UIGraphicsGetCurrentContext(), CGSizeMake(0, -3), 3.0);
    CGContextStrokeRect( UIGraphicsGetCurrentContext(), CGContextGetClipBoundingBox( UIGraphicsGetCurrentContext() ) );
    [previewView addSubview:[[UIImageView alloc] initWithImage: UIGraphicsGetImageFromCurrentImageContext()]];
    UIGraphicsEndImageContext();
}

- (void) presetSlidersWithColor: (UIColor *) aColor {
    if (CGColorSpaceGetModel( CGColorGetColorSpace(aColor.CGColor) ) == kCGColorSpaceModelMonochrome) {
        const CGFloat *clr = CGColorGetComponents(aColor.CGColor);
        [hueSlider setValue: clr[0] animated: YES];
        [saturationSlider setValue: clr[0] animated: YES];
        [brightnessSlider setValue: clr[0] animated: YES];
    } else {
        const CGFloat *clr = CGColorGetComponents(aColor.CGColor);
        [hueSlider setValue: clr[0] animated: YES];
        [saturationSlider setValue: clr[1] animated: YES];
        [brightnessSlider setValue: clr[2] animated: YES];
    }
    [self performSelector: @selector(hueSliderValueChanged:) withObject: hueSlider afterDelay: 0.0];
}*/

- (UIColor *) getColor {
    return [UIColor colorWithHue: hueSlider.value / HSB_CONSTANT saturation: saturationSlider.value brightness: brightnessSlider.value alpha: 1.0];
}

- (void) setColor: (UIColor *) aColor {
    [hueSlider setValue:[aColor hue] * HSB_CONSTANT animated: YES];
    [saturationSlider setValue:[aColor saturation] animated: YES];
    [brightnessSlider setValue:[aColor brightness] animated: YES];
    //[self performSelector: @selector(hueSliderValueChanged:) withObject: hueSlider afterDelay: 0.0];
}

#pragma mark -

#pragma mark UISlider Methods

/*- (void) hueSliderValueChanged: (UISlider *) slider {
    [UIView beginAnimations: nil context: NULL];
    previewView.backgroundColor = [UIColor colorWithHue: slider.value / HSB_CONSTANT saturation: saturationSlider.value brightness: brightnessSlider.value alpha: 1.0];
    [UIView commitAnimations];
}

- (void) saturationSliderValueChanged: (UISlider *) slider {
    [UIView beginAnimations: nil context: NULL];
    previewView.backgroundColor = [UIColor colorWithHue: hueSlider.value / HSB_CONSTANT saturation: slider.value brightness: brightnessSlider.value alpha: 1.0];
    [UIView commitAnimations];
}

- (void) brightnessSliderValueChanged: (UISlider *) slider {
    [UIView beginAnimations: nil context: NULL];
    previewView.backgroundColor = [UIColor colorWithHue: hueSlider.value / HSB_CONSTANT saturation: saturationSlider.value brightness: slider.value alpha: 1.0];
    [UIView commitAnimations];
}*/

@end
