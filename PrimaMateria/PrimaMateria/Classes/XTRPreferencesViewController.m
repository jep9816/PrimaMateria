//
//  XTRPreferencesViewController.m
//  PrimaMateria
//
//  Created by Jerry Porter on 11/21/11.
//  Copyright 2014 xTrensa. All rights reserved.
//

#import "PrimaMateria.h"

@interface XTRPreferencesViewController ()
- (void) loadDocument: (NSString *) documentName inView: (UIWebView *) webView;
- (void) loadUserDefaults;
- (void) populateSeriesColors;
- (void) populateShowTransitionsState: (BOOL) aFlag;
- (void) populateElementBubbleState: (BOOL) aFlag;
- (void) populateSplashScreenState: (BOOL) aFlag;
@end

@implementation XTRPreferencesViewController
@synthesize popoverController;
@synthesize appNameLabel;
@synthesize cpyRightLabel;
@synthesize elementBubbleSwitch;
@synthesize seriesActinideLabel;
@synthesize seriesAlkaliEarthMetalLabel;
@synthesize seriesAlkaliMetalLabel;
@synthesize seriesHalogenLabel;
@synthesize seriesLanthanideLabel;
@synthesize seriesMetalLabel;
@synthesize seriesNobleGasLabel;
@synthesize seriesNonMetalLabel;
@synthesize seriesTransactinidesLabel;
@synthesize seriesTransitionMetalLabel;
@synthesize showTransitionsBubbleSwitch;
@synthesize splashScreenSwitch;
@synthesize versionLabel;
@synthesize webView;
@synthesize colorPickersView;

#pragma mark Private Methods

- (void) colorSelected: (NSNotification *) notification {
    NSDictionary *object = (NSDictionary *)[notification object];
    if(object != nil) {
        UIColor *aColor = [object valueForKey:@"selectedColor"];
        NSData *colorData = [NSKeyedArchiver archivedDataWithRootObject:aColor];
        NSString *aTitle = [object valueForKey:@"selectedTitle"];
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setObject: colorData forKey:aTitle];
        [userDefaults synchronize];
        
        if ([aTitle isEqualToString: SERIES_ACTINIDE])
            seriesActinideLabel.backgroundColor =  aColor;
        else if ([aTitle isEqualToString: SERIES_ALKALI_EARTH_METAL])
            seriesAlkaliEarthMetalLabel.backgroundColor =  aColor;
        else if ([aTitle isEqualToString: SERIES_ALKALI_METAL])
            seriesAlkaliMetalLabel.backgroundColor =  aColor;
        else if ([aTitle isEqualToString: SERIES_HALOGEN])
            seriesHalogenLabel.backgroundColor =  aColor;
        else if ([aTitle isEqualToString: SERIES_LANTHANIDE])
            seriesLanthanideLabel.backgroundColor =  aColor;
        else if ([aTitle isEqualToString: SERIES_METAL])
            seriesMetalLabel.backgroundColor =  aColor;
        else if ([aTitle isEqualToString: SERIES_NOBLE_GAS])
            seriesNobleGasLabel.backgroundColor =  aColor;
        else if ([aTitle isEqualToString: SERIES_NON_METAL])
            seriesNonMetalLabel.backgroundColor =  aColor;
        else if ([aTitle isEqualToString: SERIES_TRANSACTINIDES])
            seriesTransactinidesLabel.backgroundColor =  aColor;
        else if ([aTitle isEqualToString: SERIES_TRANSITION_METAL])
            seriesTransitionMetalLabel.backgroundColor =  aColor;
    }
    [self.popoverController dismissPopoverAnimated: YES];
}


- (void) loadDocument: (NSString *) documentName inView: (UIWebView *) webView {
    NSString *path = [[NSBundle mainBundle] pathForResource: documentName ofType: nil];
    NSURL *url = [NSURL fileURLWithPath: path];
    NSURLRequest *request = [NSURLRequest requestWithURL: url];
    [[self webView] loadRequest: request];
}

- (void) loadUserDefaults {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    elementBubbleSwitch.on = [userDefaults boolForKey: ELEMENT_BUBBLE_DEFAULT];
    showTransitionsBubbleSwitch.on = [userDefaults boolForKey: SHOW_TRANSITIONS_DEFAULT];
    splashScreenSwitch.on = [userDefaults boolForKey: SPLASH_SCREEN_DEFAULT];
}

- (void) populateSeriesColors {
    seriesActinideLabel.backgroundColor = [XTRColorFactory actinideColor];
    seriesAlkaliEarthMetalLabel.backgroundColor = [XTRColorFactory alkaliEarthMetalColor];
    seriesAlkaliMetalLabel.backgroundColor = [XTRColorFactory alkaliMetalColor];
    seriesHalogenLabel.backgroundColor = [XTRColorFactory halogenColor];
    seriesLanthanideLabel.backgroundColor = [XTRColorFactory lanthanideColor];
    seriesMetalLabel.backgroundColor = [XTRColorFactory metalColor];
    seriesNobleGasLabel.backgroundColor = [XTRColorFactory nobleGasColor];
    seriesNonMetalLabel.backgroundColor = [XTRColorFactory nonMetalColor];
    seriesTransactinidesLabel.backgroundColor = [XTRColorFactory transactinideColor];
    seriesTransitionMetalLabel.backgroundColor = [XTRColorFactory transitionMetalColor];
    [seriesActinideLabel setNeedsDisplay];
    [seriesAlkaliEarthMetalLabel setNeedsDisplay];
    [seriesAlkaliMetalLabel setNeedsDisplay];
    [seriesHalogenLabel setNeedsDisplay];
    [seriesLanthanideLabel setNeedsDisplay];
    [seriesMetalLabel setNeedsDisplay];
    [seriesNobleGasLabel setNeedsDisplay];
    [seriesNonMetalLabel setNeedsDisplay];
    [seriesTransactinidesLabel setNeedsDisplay];
    [seriesTransitionMetalLabel setNeedsDisplay];
}

- (void) populateElementBubbleState: (BOOL) aFlag {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setBool: aFlag forKey: ELEMENT_BUBBLE_DEFAULT];
    [userDefaults synchronize];
}

- (void) populateShowTransitionsState: (BOOL) aFlag {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setBool: aFlag forKey: SHOW_TRANSITIONS_DEFAULT];
    [userDefaults synchronize];
}

- (void) populateSplashScreenState: (BOOL) aFlag {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setBool: aFlag forKey: SPLASH_SCREEN_DEFAULT];
    [userDefaults synchronize];
}

#pragma mark - Action Methods

- (IBAction) setElementBubbleState: (id) sender {
    [self populateElementBubbleState: elementBubbleSwitch.on];
}

- (IBAction)setShowTransitionsState : (id)sender {
    [self populateShowTransitionsState: showTransitionsBubbleSwitch.on];
}

- (IBAction) setSplashScreenState: (id) sender {
    [self populateSplashScreenState: splashScreenSwitch.on];
}

- (IBAction) showColorPicker: (id) sender {
    NSString *title = nil;
    switch ([sender tag]) {
        case kSERIES_ACTINIDE:
            title = SERIES_ACTINIDE;
            break;
            
        case kSERIES_ALKALI_EARTH_METAL:
            title = SERIES_ALKALI_EARTH_METAL;
            break;
            
        case kSERIES_ALKALI_METAL:
            title = SERIES_ALKALI_METAL;
            break;
            
        case kSERIES_HALOGEN:
            title = SERIES_HALOGEN;
            break;
            
        case kSERIES_LANTHANIDE:
            title = SERIES_LANTHANIDE;
            break;
            
        case kSERIES_METAL:
            title = SERIES_METAL;
            break;
            
        case kSERIES_NOBLE_GAS:
            title = SERIES_NOBLE_GAS;
            break;
            
        case kSERIES_NON_METAL:
            title = SERIES_NON_METAL;
            break;
            
        case kSERIES_TRANSACTINIDES:
            title = SERIES_TRANSACTINIDES;
            break;
            
        case kSERIES_TRANSITION_METAL:
            title = SERIES_TRANSITION_METAL;
            break;
            
        default:
            break;
    }
    /*PTColorAlertView *alert = [[PTColorAlertView alloc] initWithTitle: title message: @"\n\n\n\n\n\n\n\n\n" delegate: self cancelButtonTitle: @"Cancel" otherButtonTitles: @"Set", nil];
     alert.delegate = self;
     [alert show];*/
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName: MAIN_STORY_BOARD bundle:nil];
	XTRColorPickerViewController *colorPicker = [storyboard instantiateViewControllerWithIdentifier: NSStringFromClass([XTRColorPickerViewController class])];
    
    CGSize contentSize = CGSizeMake(270, 175);
    UIColor *aColor = [XTRColorFactory colorForString: title];
    
    colorPicker.preferredContentSize = contentSize;
    
    UIPopoverController *aPopover = [[UIPopoverController alloc] initWithContentViewController: colorPicker];
    aPopover.contentViewController.view.backgroundColor = UIColor.whiteColor;
    aPopover.popoverContentSize = contentSize;
    [aPopover setDelegate: self];
    
    self.popoverController = aPopover;
    [self.popoverController presentPopoverFromRect:[sender frame] inView: self.colorPickersView permittedArrowDirections: UIPopoverArrowDirectionAny animated: YES];
    
    colorPicker.colorTitle.text = title;
    colorPicker.modalInPopover = YES;
    colorPicker.previewView.backgroundColor = aColor;
    [colorPicker presetSlidersWithColor: aColor];
}

- (IBAction) resetPreferences: (id) sender {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults removeObjectForKey: ELEMENT_BUBBLE_DEFAULT];
    [userDefaults removeObjectForKey: SERIES_ACTINIDE];
    [userDefaults removeObjectForKey: SERIES_ALKALI_EARTH_METAL];
    [userDefaults removeObjectForKey: SERIES_ALKALI_METAL];
    [userDefaults removeObjectForKey: SERIES_HALOGEN];
    [userDefaults removeObjectForKey: SERIES_LANTHANIDE];
    [userDefaults removeObjectForKey: SERIES_METAL];
    [userDefaults removeObjectForKey: SERIES_NOBLE_GAS];
    [userDefaults removeObjectForKey: SERIES_NON_METAL];
    [userDefaults removeObjectForKey: SERIES_TRANSACTINIDES];
    [userDefaults removeObjectForKey: SERIES_TRANSITION_METAL];
    [self populateSeriesColors];
    [self populateElementBubbleState: YES];
    [self populateShowTransitionsState: YES];
    [self populateSplashScreenState: YES];
    elementBubbleSwitch.on = YES;
    splashScreenSwitch.on = YES;
}

#pragma mark - UIPopoverController Delegate Methods

- (BOOL) popoverControllerShouldDismissPopover: (UIPopoverController *) popoverController {
    return YES;
}

- (void) popoverControllerDidDismissPopover: (UIPopoverController *) aPopoverController {
}

/*- (void) didPresentAlertView: (UIAlertView *) alertView {
 NSString *title = [alertView title];
 UIColor *color = [XTRColorFactory colorForString: title];
 [(PTColorAlertView *) alertView setColor: color];
 }*/

/*- (void) alertView: (UIAlertView *) alertView clickedButtonAtIndex: (NSInteger) buttonIndex {
 switch (buttonIndex) {
 case 0: // Cancel
 break;
 
 case 1: {
 // Set
 UIColor *aColor = [(PTColorAlertView *) alertView getColor];
 CGFloat hue = [aColor hue];
 CGFloat saturation = [aColor saturation];
 CGFloat brightness = [aColor brightness];
 NSArray *values = @[@((float)hue * HSB_CONSTANT), @((float)saturation), @((float)brightness)];
 NSArray *keys = @[ HUE_COLOR_COMPONENT, SATURATION_COLOR_COMPONENT, BRIGHTNESS_COLOR_COMPONENT];
 
 NSDictionary *dict = @{keys : values};
 NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
 [userDefaults setObject: dict forKey:[alertView title]];
 [userDefaults synchronize];
 NSString *title = [alertView title];
 if ([title isEqualToString: SERIES_ACTINIDE])
 seriesActinideLabel.backgroundColor =  aColor;
 else if ([title isEqualToString: SERIES_ALKALI_EARTH_METAL])
 seriesAlkaliEarthMetalLabel.backgroundColor =  aColor;
 else if ([title isEqualToString: SERIES_ALKALI_METAL])
 seriesAlkaliMetalLabel.backgroundColor =  aColor;
 else if ([title isEqualToString: SERIES_HALOGEN])
 seriesHalogenLabel.backgroundColor =  aColor;
 else if ([title isEqualToString: SERIES_LANTHANIDE])
 seriesLanthanideLabel.backgroundColor =  aColor;
 else if ([title isEqualToString: SERIES_METAL])
 seriesMetalLabel.backgroundColor =  aColor;
 else if ([title isEqualToString: SERIES_NOBLE_GAS])
 seriesNobleGasLabel.backgroundColor =  aColor;
 else if ([title isEqualToString: SERIES_NON_METAL])
 seriesNonMetalLabel.backgroundColor =  aColor;
 else if ([title isEqualToString: SERIES_TRANSACTINIDES])
 seriesTransactinidesLabel.backgroundColor =  aColor;
 else if ([title isEqualToString: SERIES_TRANSITION_METAL])
 seriesTransitionMetalLabel.backgroundColor =  aColor;
 break;
 }
 
 default:
 break;
 }
 }*/

#pragma mark - View Management Methods

- (BOOL) shouldAutorotateToInterfaceOrientation: (UIInterfaceOrientation) interfaceOrientation {
    return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

- (void) viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(colorSelected:) name: NOTIFICATION_COLOR_SELECTED object: nil];
    
    [self loadDocument: @"Credits.rtf" inView:[self webView]];
    [self loadUserDefaults];
    [self populateSeriesColors];
    
    appNameLabel.text = XTRVersionChecker.appNameString;
    versionLabel.text = XTRVersionChecker.appVersionString;
    cpyRightLabel.text = XTRVersionChecker.copywriteString;
}

#pragma mark - Memory Management Methods

#pragma mark - Memory Management Methods

- (void) dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver: self];
    appNameLabel = nil;
    cpyRightLabel = nil;
    elementBubbleSwitch = nil;
    seriesActinideLabel = nil;
    seriesAlkaliEarthMetalLabel = nil;
    seriesAlkaliMetalLabel = nil;
    seriesHalogenLabel = nil;
    seriesLanthanideLabel = nil;
    seriesMetalLabel = nil;
    seriesNobleGasLabel = nil;
    seriesNonMetalLabel = nil;
    seriesTransactinidesLabel = nil;
    seriesTransitionMetalLabel = nil;
    showTransitionsBubbleSwitch = nil;
    splashScreenSwitch = nil;
    versionLabel = nil;
    webView = nil;
}

@end
