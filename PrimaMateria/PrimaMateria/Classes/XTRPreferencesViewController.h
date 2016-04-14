//
//  XTRSecondViewController.h
//  PrimaMateria
//
//  Created by Jerry Porter on 11/21/11.
//  Copyright (c) 2016 xTrensa. All rights reserved.
//

@interface XTRPreferencesViewController : UIViewController <UIPopoverPresentationControllerDelegate>
@property (nonatomic, strong) IBOutlet UILabel *appNameLabel;
@property (nonatomic, strong) IBOutlet UILabel *cpyRightLabel;

@property (nonatomic, strong) IBOutlet UIButton *seriesActinideButton;
@property (nonatomic, strong) IBOutlet UIButton *seriesAlkaliEarthMetalButton;
@property (nonatomic, strong) IBOutlet UIButton *seriesAlkaliMetalButton;
@property (nonatomic, strong) IBOutlet UIButton *seriesHalogenButton;
@property (nonatomic, strong) IBOutlet UIButton *seriesLanthanideButton;
@property (nonatomic, strong) IBOutlet UIButton *seriesMetalButton;
@property (nonatomic, strong) IBOutlet UIButton *seriesNobleGasButton;
@property (nonatomic, strong) IBOutlet UIButton *seriesNonMetalButton;
@property (nonatomic, strong) IBOutlet UIButton *seriesTransactinidesButton;
@property (nonatomic, strong) IBOutlet UIButton *seriesTransitionMetalButton;

@property (nonatomic, strong) IBOutlet UILabel *versionLabel;
@property (nonatomic, strong) IBOutlet UISwitch *elementBubbleSwitch;
@property (nonatomic, strong) IBOutlet UISwitch *showTransitionsBubbleSwitch;
@property (nonatomic, strong) IBOutlet UISwitch *splashScreenSwitch;
@property (nonatomic, strong) IBOutlet UIWebView *webView;

- (IBAction)resetPreferences: (id)sender;
- (IBAction)setElementBubbleState: (id)sender;
- (IBAction)setShowTransitionsState: (id)sender;
- (IBAction)setSplashScreenState: (id)sender;
- (IBAction)showColorPicker: (id)sender;

@end
