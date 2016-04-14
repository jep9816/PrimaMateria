//
//  XTRPreferencesViewController.m
//  PrimaMateria
//
//  Created by Jerry Porter on 11/21/11.
//  Copyright 2016 xTrensa. All rights reserved.
//

@interface XTRPreferencesViewController ()
- (void)loadDocument: (NSString *) documentName inView: (UIWebView *) webView;
- (void)loadUserDefaults;
- (void)populateSeriesColors;
- (void)populateShowTransitionsState: (BOOL) aFlag;
- (void)populateElementBubbleState: (BOOL) aFlag;
- (void)populateSplashScreenState: (BOOL) aFlag;
@end

@implementation XTRPreferencesViewController

#pragma mark Private Methods

- (void)colorSelected: (NSNotification *)notification {
    NSDictionary *object = (NSDictionary *)notification.object;
    
    if(object != nil) {
        NSNumber *redComponent = (NSNumber*)object[RED_COLOR_COMPONENT];
        NSNumber *greenComponent = (NSNumber*)object[GREEN_COLOR_COMPONENT];
        NSNumber *blueComponent = (NSNumber*)object[BLUE_COLOR_COMPONENT];
        NSString *seriesColorKey = object[SERIES_COLOR_KEY];
        
        UIColor *aColor = [UIColor colorWithRed:redComponent.floatValue green:greenComponent.floatValue blue:blueComponent.floatValue alpha:1.0];
        NSData *colorData = [NSKeyedArchiver archivedDataWithRootObject:aColor];
        
        [XTRPropertiesStore storeColorData: colorData forColorKey: seriesColorKey];
        
        if ([seriesColorKey isEqualToString: SERIES_ACTINIDE]) {
            self.seriesActinideButton.backgroundColor = aColor;
            [self.seriesActinideButton setTitleColor: [UIColor reverseColorOf: aColor] forState: UIControlStateNormal];
        } else if ([seriesColorKey isEqualToString: SERIES_ALKALI_EARTH_METAL]) {
            self.seriesAlkaliEarthMetalButton.backgroundColor = aColor;
            [self.seriesAlkaliEarthMetalButton setTitleColor: [UIColor reverseColorOf: aColor] forState: UIControlStateNormal];
        } else if ([seriesColorKey isEqualToString: SERIES_ALKALI_METAL]) {
            self.seriesAlkaliMetalButton.backgroundColor = aColor;
            [self.seriesAlkaliMetalButton setTitleColor: [UIColor reverseColorOf: aColor] forState: UIControlStateNormal];
        } else if ([seriesColorKey isEqualToString: SERIES_HALOGEN]) {
            self.seriesHalogenButton.backgroundColor = aColor;
            [self.seriesHalogenButton setTitleColor: [UIColor reverseColorOf: aColor] forState: UIControlStateNormal];
        } else if ([seriesColorKey isEqualToString: SERIES_LANTHANIDE]) {
            self.seriesLanthanideButton.backgroundColor = aColor;
            [self.seriesLanthanideButton setTitleColor: [UIColor reverseColorOf: aColor] forState: UIControlStateNormal];
        } else if ([seriesColorKey isEqualToString: SERIES_METAL]) {
            self.seriesMetalButton.backgroundColor = aColor;
            [self.seriesMetalButton setTitleColor: [UIColor reverseColorOf: aColor] forState: UIControlStateNormal];
        } else if ([seriesColorKey isEqualToString: SERIES_NOBLE_GAS]) {
            self.seriesNobleGasButton.backgroundColor = aColor;
            [self.seriesNobleGasButton setTitleColor: [UIColor reverseColorOf: aColor] forState: UIControlStateNormal];
        } else if ([seriesColorKey isEqualToString: SERIES_NON_METAL]) {
            self.seriesNonMetalButton.backgroundColor = aColor;
            [self.seriesNonMetalButton setTitleColor: [UIColor reverseColorOf: aColor] forState: UIControlStateNormal];
        } else if ([seriesColorKey isEqualToString: SERIES_TRANSACTINIDES]) {
            self.seriesTransactinidesButton.backgroundColor = aColor;
            [self.seriesTransactinidesButton setTitleColor: [UIColor reverseColorOf: aColor] forState: UIControlStateNormal];
        } else if ([seriesColorKey isEqualToString: SERIES_TRANSITION_METAL]) {
            self.seriesTransitionMetalButton.backgroundColor = aColor;
            [self.seriesTransitionMetalButton setTitleColor: [UIColor reverseColorOf: aColor] forState: UIControlStateNormal];
        }
        [[NSNotificationCenter defaultCenter] postNotificationName: NOTIFICATION_SERIES_COLOR_CHANGED object: nil];
    }
    
    [self dismissViewControllerAnimated:YES completion: nil];
}

- (void)loadDocument: (NSString *) documentName inView: (UIWebView *) webView {
    NSString *path = [[NSBundle mainBundle] pathForResource: documentName ofType: nil];
    NSURL *url = [NSURL fileURLWithPath: path];
    NSURLRequest *request = [NSURLRequest requestWithURL: url];
    [webView loadRequest: request];
}

- (void)loadUserDefaults {
    self.self.elementBubbleSwitch.on = [XTRPropertiesStore retreiveElementBubblesState];
    self.showTransitionsBubbleSwitch.on = [XTRPropertiesStore retreiveShowTransitionsState];
    self.splashScreenSwitch.on = [XTRPropertiesStore retreiveSplashScreenState];
}

- (void)populateSeriesColors {
    self.seriesActinideButton.backgroundColor = [XTRColorFactory actinideColor];
    self.seriesAlkaliEarthMetalButton.backgroundColor = [XTRColorFactory alkaliEarthMetalColor];
    self.seriesAlkaliMetalButton.backgroundColor = [XTRColorFactory alkaliMetalColor];
    self.seriesHalogenButton.backgroundColor = [XTRColorFactory halogenColor];
    self.seriesLanthanideButton.backgroundColor = [XTRColorFactory lanthanideColor];
    self.seriesMetalButton.backgroundColor = [XTRColorFactory metalColor];
    self.seriesNobleGasButton.backgroundColor = [XTRColorFactory nobleGasColor];
    self.seriesNonMetalButton.backgroundColor = [XTRColorFactory nonMetalColor];
    self.seriesTransactinidesButton.backgroundColor = [XTRColorFactory transactinideColor];
    self.seriesTransitionMetalButton.backgroundColor = [XTRColorFactory transitionMetalColor];
    
    [self.seriesActinideButton setTitleColor: [UIColor reverseColorOf: [XTRColorFactory actinideColor]] forState: UIControlStateNormal];
    [self.seriesAlkaliEarthMetalButton setTitleColor: [UIColor reverseColorOf: [XTRColorFactory alkaliEarthMetalColor]] forState: UIControlStateNormal];
    [self.seriesAlkaliMetalButton setTitleColor: [UIColor reverseColorOf: [XTRColorFactory alkaliMetalColor]] forState: UIControlStateNormal];
    [self.seriesHalogenButton setTitleColor: [UIColor reverseColorOf: [XTRColorFactory halogenColor]] forState: UIControlStateNormal];
    [self.seriesLanthanideButton setTitleColor: [UIColor reverseColorOf: [XTRColorFactory lanthanideColor]] forState: UIControlStateNormal];
    [self.seriesMetalButton setTitleColor: [UIColor reverseColorOf: [XTRColorFactory metalColor]] forState: UIControlStateNormal];
    [self.seriesNobleGasButton setTitleColor: [UIColor reverseColorOf: [XTRColorFactory nobleGasColor]] forState: UIControlStateNormal];
    [self.seriesNonMetalButton setTitleColor: [UIColor reverseColorOf: [XTRColorFactory nonMetalColor]] forState: UIControlStateNormal];
    [self.seriesTransactinidesButton setTitleColor: [UIColor reverseColorOf: [XTRColorFactory transactinideColor]] forState: UIControlStateNormal];
    [self.seriesTransitionMetalButton setTitleColor: [UIColor reverseColorOf: [XTRColorFactory transitionMetalColor]] forState: UIControlStateNormal];
}

- (void)populateElementBubbleState: (BOOL) aFlag {
    [XTRPropertiesStore storeElementBubblesState: aFlag];
}

- (void)populateShowTransitionsState: (BOOL) aFlag {
    [XTRPropertiesStore storeShowTranitionsState: aFlag];
}

- (void)populateSplashScreenState: (BOOL) aFlag {
    [XTRPropertiesStore storeSplashScreenState: aFlag];
}

#pragma mark - Action Methods

- (IBAction) setElementBubbleState: (id) sender {
    [self populateElementBubbleState: self.elementBubbleSwitch.on];
}

- (IBAction)setShowTransitionsState: (id)sender {
    [self populateShowTransitionsState: self.showTransitionsBubbleSwitch.on];
}

- (IBAction)setSplashScreenState: (id)sender {
    [self populateSplashScreenState: self.splashScreenSwitch.on];
}

- (IBAction)showColorPicker: (id)sender {
    UIButton *aButton = sender;
    NSString *title = aButton.titleLabel.text;
    XTRColorPickerViewController *colorPicker = [[XTRAppDelegate storyboard] instantiateViewControllerWithIdentifier: NSStringFromClass([XTRColorPickerViewController class])];
    UIColor *aColor = [XTRColorFactory colorForString: title];
    
    colorPicker.popoverPresentationController.permittedArrowDirections = UIPopoverArrowDirectionDown;
    colorPicker.modalPresentationStyle = UIModalPresentationPopover;
    colorPicker.popoverPresentationController.sourceView = sender;
    colorPicker.popoverPresentationController.sourceRect = CGRectMake(100, 17, 5, 5);
    colorPicker.preferredContentSize = CGSizeMake(270, 175);

    [self presentViewController:colorPicker animated:YES completion:nil];
    
    colorPicker.colorTitle.text = title;
    colorPicker.previewView.backgroundColor = aColor;
    
    [colorPicker presetSlidersWithColor: aColor];
}

- (IBAction)resetPreferences: (id)sender {
    [XTRPropertiesStore resetPreferences];
    
    [self populateSeriesColors];
    [self populateElementBubbleState: YES];
    [self populateShowTransitionsState: YES];
    [self populateSplashScreenState: YES];
    
    [[NSNotificationCenter defaultCenter] postNotificationName: NOTIFICATION_SERIES_COLOR_CHANGED object: nil];
    self.elementBubbleSwitch.on = YES;
    self.showTransitionsBubbleSwitch.on = YES;
    self.splashScreenSwitch.on = YES;
}

#pragma mark - View Management Methods

- (BOOL)shouldAutorotateToInterfaceOrientation: (UIInterfaceOrientation)interfaceOrientation {
    return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(colorSelected:) name: NOTIFICATION_COLOR_SELECTED object: nil];
    
    [self loadDocument: @"Credits.rtf" inView:self.webView];
    [self loadUserDefaults];
    [self populateSeriesColors];
    
    self.appNameLabel.text = XTRVersionChecker.appNameString;
    self.versionLabel.text = XTRVersionChecker.appVersionString;
    self.cpyRightLabel.text = XTRVersionChecker.copywriteString;
}

#pragma mark - Memory Management Methods

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver: self];
    self.appNameLabel = nil;
    self.cpyRightLabel = nil;
    self.elementBubbleSwitch = nil;
    self.seriesActinideButton = nil;
    self.seriesAlkaliEarthMetalButton = nil;
    self.seriesAlkaliMetalButton = nil;
    self.seriesHalogenButton = nil;
    self.seriesLanthanideButton = nil;
    self.seriesMetalButton = nil;
    self.seriesNobleGasButton = nil;
    self.seriesNonMetalButton = nil;
    self.seriesTransactinidesButton = nil;
    self.seriesTransitionMetalButton = nil;
    self.showTransitionsBubbleSwitch = nil;
    self.splashScreenSwitch = nil;
    self.versionLabel = nil;
    self.webView.delegate = nil;
    self.webView = nil;
}

@end
