//
//  XTRPreferencesViewController.m
//  PrimaMateria
//
//  Created by Jerry Porter on 11/21/11.
//  Copyright 2016 xTrensa. All rights reserved.
//

#import "PrimaMateria.h"

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
        
        UIColor *aColor = [UIColor colorWithRed:redComponent.floatValue green:greenComponent.floatValue blue:blueComponent.floatValue alpha:1.0];
        NSData *colorData = [NSKeyedArchiver archivedDataWithRootObject:aColor];
        NSString *colorKey = [object valueForKey:COLOR_KEY];
        
        [XTRPropertiesStore storeColorData: colorData forColorKey: colorKey];
        
        if ([colorKey isEqualToString: SERIES_ACTINIDE]) {
            self.seriesActinideLabel.backgroundColor =  aColor;
        } else if ([colorKey isEqualToString: SERIES_ALKALI_EARTH_METAL]) {
            self.seriesAlkaliEarthMetalLabel.backgroundColor =  aColor;
        } else if ([colorKey isEqualToString: SERIES_ALKALI_METAL]) {
            self.seriesAlkaliMetalLabel.backgroundColor =  aColor;
        } else if ([colorKey isEqualToString: SERIES_HALOGEN]) {
            self.seriesHalogenLabel.backgroundColor =  aColor;
        } else if ([colorKey isEqualToString: SERIES_LANTHANIDE]) {
            self.seriesLanthanideLabel.backgroundColor =  aColor;
        } else if ([colorKey isEqualToString: SERIES_METAL]) {
            self.seriesMetalLabel.backgroundColor =  aColor;
        } else if ([colorKey isEqualToString: SERIES_NOBLE_GAS]) {
            self.seriesNobleGasLabel.backgroundColor =  aColor;
        } else if ([colorKey isEqualToString: SERIES_NON_METAL]) {
            self.seriesNonMetalLabel.backgroundColor =  aColor;
        } else if ([colorKey isEqualToString: SERIES_TRANSACTINIDES]) {
            self.seriesTransactinidesLabel.backgroundColor =  aColor;
        } else if ([colorKey isEqualToString: SERIES_TRANSITION_METAL]) {
            self.seriesTransitionMetalLabel.backgroundColor =  aColor;
        }
    }
    
    //[[NSNotificationCenter defaultCenter] postNotificationName: @"notificationColorChanged" object: nil];
    [self dismissViewControllerAnimated:YES completion: nil];
}

- (void)loadDocument: (NSString *) documentName inView: (UIWebView *) webView {
    NSString *path = [[NSBundle mainBundle] pathForResource: documentName ofType: nil];
    NSURL *url = [NSURL fileURLWithPath: path];
    NSURLRequest *request = [NSURLRequest requestWithURL: url];
    [self.webView loadRequest: request];
}

- (void)loadUserDefaults {
    self.self.elementBubbleSwitch.on = [XTRPropertiesStore retreiveElementBubblesState];
    self.showTransitionsBubbleSwitch.on = [XTRPropertiesStore retreiveShowTransitionsState];
    self.splashScreenSwitch.on = [XTRPropertiesStore retreiveSplashScreenState];
}

- (void)populateSeriesColors {
    self.seriesActinideLabel.backgroundColor = [XTRColorFactory actinideColor];
    self.seriesAlkaliEarthMetalLabel.backgroundColor = [XTRColorFactory alkaliEarthMetalColor];
    self.seriesAlkaliMetalLabel.backgroundColor = [XTRColorFactory alkaliMetalColor];
    self.seriesHalogenLabel.backgroundColor = [XTRColorFactory halogenColor];
    self.seriesLanthanideLabel.backgroundColor = [XTRColorFactory lanthanideColor];
    self.seriesMetalLabel.backgroundColor = [XTRColorFactory metalColor];
    self.seriesNobleGasLabel.backgroundColor = [XTRColorFactory nobleGasColor];
    self.seriesNonMetalLabel.backgroundColor = [XTRColorFactory nonMetalColor];
    self.seriesTransactinidesLabel.backgroundColor = [XTRColorFactory transactinideColor];
    self.seriesTransitionMetalLabel.backgroundColor = [XTRColorFactory transitionMetalColor];
    
    [self.seriesActinideLabel setNeedsDisplay];
    [self.seriesAlkaliEarthMetalLabel setNeedsDisplay];
    [self.seriesAlkaliMetalLabel setNeedsDisplay];
    [self.seriesHalogenLabel setNeedsDisplay];
    [self.seriesLanthanideLabel setNeedsDisplay];
    [self.seriesMetalLabel setNeedsDisplay];
    [self.seriesNobleGasLabel setNeedsDisplay];
    [self.seriesNonMetalLabel setNeedsDisplay];
    [self.seriesTransactinidesLabel setNeedsDisplay];
    [self.seriesTransitionMetalLabel setNeedsDisplay];
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

- (IBAction)setShowTransitionsState : (id)sender {
    [self populateShowTransitionsState: self.showTransitionsBubbleSwitch.on];
}

- (IBAction) setSplashScreenState: (id) sender {
    [self populateSplashScreenState: self.splashScreenSwitch.on];
}

- (IBAction) showColorPicker: (id) sender {
    NSString *title = nil;
    XTRColorPickerViewController *colorPicker = [[XTRAppDelegate storyboard] instantiateViewControllerWithIdentifier: NSStringFromClass([XTRColorPickerViewController class])];
    UIColor *aColor = nil;

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
    
    aColor = [XTRColorFactory colorForString: title];
    
    colorPicker.popoverPresentationController.permittedArrowDirections = UIPopoverArrowDirectionLeft;
    colorPicker.modalPresentationStyle = UIModalPresentationPopover;
    colorPicker.popoverPresentationController.sourceView = sender;
    colorPicker.popoverPresentationController.sourceRect = CGRectMake(3, 10, 15, 15);
    colorPicker.preferredContentSize = CGSizeMake(270, 175);

    [self presentViewController:colorPicker animated:YES completion:nil];
    
    colorPicker.colorTitle.text = title;
    colorPicker.previewView.backgroundColor = aColor;
    
    [colorPicker presetSlidersWithColor: aColor];
}

- (IBAction)resetPreferences: (id) sender {
    [XTRPropertiesStore resetPreferences];
    
    [self populateSeriesColors];
    [self populateElementBubbleState: YES];
    [self populateShowTransitionsState: YES];
    [self populateSplashScreenState: YES];
    
    self.elementBubbleSwitch.on = YES;
    self.showTransitionsBubbleSwitch.on = YES;
    self.splashScreenSwitch.on = YES;
}

#pragma mark - View Management Methods

- (BOOL) shouldAutorotateToInterfaceOrientation: (UIInterfaceOrientation) interfaceOrientation {
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
    self.seriesActinideLabel = nil;
    self.seriesAlkaliEarthMetalLabel = nil;
    self.seriesAlkaliMetalLabel = nil;
    self.seriesHalogenLabel = nil;
    self.seriesLanthanideLabel = nil;
    self.seriesMetalLabel = nil;
    self.seriesNobleGasLabel = nil;
    self.seriesNonMetalLabel = nil;
    self.seriesTransactinidesLabel = nil;
    self.seriesTransitionMetalLabel = nil;
    self.showTransitionsBubbleSwitch = nil;
    self.splashScreenSwitch = nil;
    self.versionLabel = nil;
    self.webView.delegate = nil;
    self.webView = nil;
}

@end
