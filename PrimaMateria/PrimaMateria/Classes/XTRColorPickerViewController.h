//
//  XTRColorPickerViewController.h
//  PrimaMateria
//
//  Created by Jerry Porter on 5/11/14.
//  Copyright (c) 2016 xTrensa. All rights reserved.
//

@interface XTRColorPickerViewController : UIViewController

@property (nonatomic, strong) IBOutlet UISlider *redSlider;
@property (nonatomic, strong) IBOutlet UISlider *greenSlider;
@property (nonatomic, strong) IBOutlet UISlider *blueSlider;

@property (nonatomic, strong) IBOutlet UILabel *redLabel;
@property (nonatomic, strong) IBOutlet UILabel *greenLabel;
@property (nonatomic, strong) IBOutlet UILabel *blueLabel;

@property (nonatomic, strong) IBOutlet UILabel *colorTitle;

@property (nonatomic, strong) IBOutlet UIView *previewView;

@property (atomic) BOOL didSelectColor;

- (void)presetSlidersWithColor: (UIColor *) color;

- (IBAction)selectColor: (id)sender;
- (IBAction) redSliderValueChanged: (UISlider *) slider;
- (IBAction) greenSliderValueChanged: (UISlider *) slider;
- (IBAction) blueSliderValueChanged: (UISlider *) slider;

@end
