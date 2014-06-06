//
//  XTRSecondViewController.h
//  PrimaMateria
//
//  Created by Jerry Porter on 11/21/11.
//  Copyright 2014 xTrensa. All rights reserved.
//

@class XTRColorPickerViewController;

@interface XTRPreferencesViewController : UIViewController </*UIAlertViewDelegate, */UIPopoverControllerDelegate>

@property (strong, nonatomic) UIPopoverController *popoverController;
@property (nonatomic, strong) IBOutlet UILabel *appNameLabel;
@property (nonatomic, strong) IBOutlet UILabel *cpyRightLabel;
@property (nonatomic, strong) IBOutlet UILabel *seriesActinideLabel;
@property (nonatomic, strong) IBOutlet UILabel *seriesAlkaliEarthMetalLabel;
@property (nonatomic, strong) IBOutlet UILabel *seriesAlkaliMetalLabel;
@property (nonatomic, strong) IBOutlet UILabel *seriesHalogenLabel;
@property (nonatomic, strong) IBOutlet UILabel *seriesLanthanideLabel;
@property (nonatomic, strong) IBOutlet UILabel *seriesMetalLabel;
@property (nonatomic, strong) IBOutlet UILabel *seriesNobleGasLabel;
@property (nonatomic, strong) IBOutlet UILabel *seriesNonMetalLabel;
@property (nonatomic, strong) IBOutlet UILabel *seriesTransactinidesLabel;
@property (nonatomic, strong) IBOutlet UILabel *seriesTransitionMetalLabel;
@property (nonatomic, strong) IBOutlet UILabel *versionLabel;
@property (nonatomic, strong) IBOutlet UISwitch *elementBubbleSwitch;
@property (nonatomic, strong) IBOutlet UISwitch *showTransitionsBubbleSwitch;
@property (nonatomic, strong) IBOutlet UISwitch *splashScreenSwitch;
@property (nonatomic, strong) IBOutlet UIWebView *webView;
@property (nonatomic, strong) IBOutlet UIView *colorPickersView;

- (IBAction)resetPreferences : (id)sender;
- (IBAction)setElementBubbleState : (id)sender;
- (IBAction)setShowTransitionsState : (id)sender;
- (IBAction)setSplashScreenState : (id)sender;
- (IBAction)showColorPicker : (id)sender;

@end
