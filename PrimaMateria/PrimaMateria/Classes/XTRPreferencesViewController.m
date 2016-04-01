//
//  XTRPreferencesViewController.m
//  PrimaMateria
//
//  Created by Jerry Porter on 11/21/11.
//  Copyright 2016 xTrensa. All rights reserved.
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

//- (void)iterateOverSubviewsOfType:(Class)viewType inView: (UIView*)view {
//    for (UIView* subview in view.subviews) {
//        if ([subview isKindOfClass:viewType]) {
//            //block(subview);
//        }
//    }
//}

- (void) colorSelected: (NSNotification *) notification {
    NSDictionary *object = (NSDictionary *)notification.object;
    if(object != nil) {
        NSNumber *redComponent = (NSNumber*)object[@"redComponent"];
        NSNumber *greenComponent = (NSNumber*)object[@"greenComponent"];
        NSNumber *blueComponent = (NSNumber*)object[@"blueComponent"];
        
        UIColor *aColor = [UIColor colorWithRed:redComponent.floatValue green:greenComponent.floatValue blue:blueComponent.floatValue alpha:1.0];
        NSData *colorData = [NSKeyedArchiver archivedDataWithRootObject:aColor];
        NSString *colorKey = [object valueForKey:@"selectedTitle"];
        
        [XTRPropertiesStore storeColorData:colorData forColorKey: colorKey];
        
        if ([colorKey isEqualToString: SERIES_ACTINIDE]) {
            seriesActinideLabel.backgroundColor =  aColor;
        } else if ([colorKey isEqualToString: SERIES_ALKALI_EARTH_METAL]) {
            seriesAlkaliEarthMetalLabel.backgroundColor =  aColor;
        } else if ([colorKey isEqualToString: SERIES_ALKALI_METAL]) {
            seriesAlkaliMetalLabel.backgroundColor =  aColor;
        } else if ([colorKey isEqualToString: SERIES_HALOGEN]) {
            seriesHalogenLabel.backgroundColor =  aColor;
        } else if ([colorKey isEqualToString: SERIES_LANTHANIDE]) {
            seriesLanthanideLabel.backgroundColor =  aColor;
        } else if ([colorKey isEqualToString: SERIES_METAL]) {
            seriesMetalLabel.backgroundColor =  aColor;
        } else if ([colorKey isEqualToString: SERIES_NOBLE_GAS]) {
            seriesNobleGasLabel.backgroundColor =  aColor;
        } else if ([colorKey isEqualToString: SERIES_NON_METAL]) {
            seriesNonMetalLabel.backgroundColor =  aColor;
        } else if ([colorKey isEqualToString: SERIES_TRANSACTINIDES]) {
            seriesTransactinidesLabel.backgroundColor =  aColor;
        } else if ([colorKey isEqualToString: SERIES_TRANSITION_METAL]) {
            seriesTransitionMetalLabel.backgroundColor =  aColor;
        }
    }
    
    //[[NSNotificationCenter defaultCenter] postNotificationName: @"notificationColorChanged" object: nil];
    [self dismissViewControllerAnimated:YES completion: nil];
}


- (void) loadDocument: (NSString *) documentName inView: (UIWebView *) webView {
    NSString *path = [[NSBundle mainBundle] pathForResource: documentName ofType: nil];
    NSURL *url = [NSURL fileURLWithPath: path];
    NSURLRequest *request = [NSURLRequest requestWithURL: url];
    [self.webView loadRequest: request];
}

- (void) loadUserDefaults {
    elementBubbleSwitch.on = [XTRPropertiesStore retreiveElementBubblesState];
    showTransitionsBubbleSwitch.on = [XTRPropertiesStore retreiveShowTransitionsState];
    splashScreenSwitch.on = [XTRPropertiesStore retreiveSplashScreenState];
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
    [XTRPropertiesStore storeElementBubblesState: aFlag];
}

- (void) populateShowTransitionsState: (BOOL) aFlag {
    [XTRPropertiesStore storeShowTranitionsState: aFlag];
}

- (void) populateSplashScreenState: (BOOL) aFlag {
    [XTRPropertiesStore storeSplashScreenState: aFlag];
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

    UIStoryboard *storyboard = [XTRAppDelegate storyboard];
	XTRColorPickerViewController *colorPicker = [storyboard instantiateViewControllerWithIdentifier: NSStringFromClass([XTRColorPickerViewController class])];
    
    CGSize contentSize = CGSizeMake(270, 175);
    UIColor *aColor = [XTRColorFactory colorForString: title];
    CGRect aRect = CGRectMake(3, 10, 15, 15);
    
    colorPicker.popoverPresentationController.permittedArrowDirections = UIPopoverArrowDirectionLeft;
    colorPicker.modalPresentationStyle = UIModalPresentationPopover;
    colorPicker.popoverPresentationController.sourceView = sender;
    colorPicker.popoverPresentationController.sourceRect = aRect;
    colorPicker.preferredContentSize = contentSize;

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
    elementBubbleSwitch.on = YES;
    splashScreenSwitch.on = YES;
}

#pragma mark - View Management Methods

- (BOOL) shouldAutorotateToInterfaceOrientation: (UIInterfaceOrientation) interfaceOrientation {
    return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

- (void) viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(colorSelected:) name: NOTIFICATION_COLOR_SELECTED object: nil];
    
    [self loadDocument: @"Credits.rtf" inView:self.webView];
    [self loadUserDefaults];
    [self populateSeriesColors];
    
    appNameLabel.text = XTRVersionChecker.appNameString;
    versionLabel.text = XTRVersionChecker.appVersionString;
    cpyRightLabel.text = XTRVersionChecker.copywriteString;
    //[self iterateOverSubviewsOfType: [UIButton class] inView: self.view];
}

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
