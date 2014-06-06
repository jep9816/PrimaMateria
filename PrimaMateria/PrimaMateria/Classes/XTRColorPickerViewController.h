//
//  XTRColorPickerViewController.h
//  PrimaMateria
//
//  Created by Jerry Porter on 5/11/14.
//  Copyright (c) 2014 xTrensa. All rights reserved.
//

@interface XTRColorPickerViewController : UIViewController

@property (nonatomic, strong) IBOutlet UISlider *hueSlider;
@property (nonatomic, strong) IBOutlet UISlider *saturationSlider;
@property (nonatomic, strong) IBOutlet UISlider *brightnessSlider;

@property (nonatomic, strong) IBOutlet UILabel *hueLabel;
@property (nonatomic, strong) IBOutlet UILabel *saturationLabel;
@property (nonatomic, strong) IBOutlet UILabel *brightnessLabel;

@property (nonatomic, strong) IBOutlet UILabel *colorTitle;

@property (nonatomic, strong) IBOutlet UIView *previewView;

@property (nonatomic, strong) IBOutlet UIButton *chooseColorButton;

- (void) presetSlidersWithColor: (UIColor *) color;

- (IBAction)selectColor: (id)sender;
- (IBAction)cancel: (id)sender;

- (IBAction) hueSliderValueChanged: (UISlider *) slider;
- (IBAction) saturationSliderValueChanged: (UISlider *) slider;
- (IBAction) brightnessSliderValueChanged: (UISlider *) slider;

@end
