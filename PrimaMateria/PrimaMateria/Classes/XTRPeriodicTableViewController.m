//
//  XTRFirstViewController.m
//  PrimaMateria
//
//  Created by Jerry Porter on 11/21/11.
//  Copyright 2014 xTrensa. All rights reserved.
//

#import "PrimaMateria.h"

@interface XTRPeriodicTableViewController ()
- (void) showPopupForButton: (id) sender;
- (void) showElementPanelForElementAtIndex: (int) anIndex;
- (void) setupPopUp;
- (void) toggleMolecularCalculatorState: (BOOL) aFlag;
@end

@implementation XTRPeriodicTableViewController
@synthesize popoverController;
@synthesize swapView;
@synthesize molecularCalculatorViewController;
@synthesize molecularCalculatorState;
@synthesize elementBalloonViewController;

#pragma mark Private Methods

- (void)dismissPopover: (NSNotification *)aNotification {
    if(self.popoverController)
        [self.popoverController dismissPopoverAnimated: YES];
}

- (void) showPopupForButton: (id) sender {
    [XTRPropertiesStore storeViewTitle: self.title];
    [XTRPropertiesStore storeAtomicNumber:@([sender tag])];    
    [self.popoverController presentPopoverFromRect:[sender frame] inView: self.view permittedArrowDirections: UIPopoverArrowDirectionAny animated: YES];
}

- (void) showElementPanelForElementAtIndex: (int) anIndex {
    [XTRPropertiesStore storeViewTitle: self.title];
    [XTRPropertiesStore storeAtomicNumber:@(anIndex)];
    [self performSegueWithIdentifier: SHOW_INSPECTOR_FROM_PERIODIC_TABLE sender: self];
}

- (void) setupPopUp {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName: MAIN_STORY_BOARD bundle:nil];
	elementBalloonViewController = [storyboard instantiateViewControllerWithIdentifier: NSStringFromClass([XTRElementBalloonViewController class])];
    CGSize contentSize = CGSizeMake(320.0f, 206.0f);
    elementBalloonViewController.preferredContentSize = contentSize;
    UIPopoverController *aPopover = [[UIPopoverController alloc] initWithContentViewController: elementBalloonViewController];
    aPopover.contentViewController.view.backgroundColor = UIColor.whiteColor;

    aPopover.popoverContentSize = contentSize;
    [aPopover setDelegate: self];
    self.popoverController = aPopover;
    elementBalloonViewController.localPopoverController = aPopover;
}

- (void) toggleMolecularCalculatorState: (BOOL) aFlag {
    if (!aFlag) {
        molecularCalculatorState = NO;
        [[molecularCalculatorViewController view] removeFromSuperview];
        [molecularCalculatorViewController viewWillDisappear: YES];
    } else {
        molecularCalculatorState = YES;
        [self.view addSubview:[molecularCalculatorViewController view]];
    }
}

#pragma mark - Action Methods

- (IBAction) showMolecularCalculator: (UISwitch *) sender {
    [self toggleMolecularCalculatorState: sender.on];
}

- (IBAction) showElementInspector: (id) sender {
    if (molecularCalculatorState) {
        XTRElement *element = [[XTRDataSource sharedInstance] elementAtIndex:[sender tag]];
        [self.molecularCalculatorViewController setElement: element];
    } else {
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        BOOL defaultState = [userDefaults boolForKey: ELEMENT_BUBBLE_DEFAULT];
        if (defaultState)
            [self showPopupForButton: sender];
        else
            [self showElementPanelForElementAtIndex:[sender tag]];
    }
}

#pragma mark - UIPopoverController Delegate Methods

- (BOOL) popoverControllerShouldDismissPopover: (UIPopoverController *) popoverController {
    return YES;
}

- (void) popoverControllerDidDismissPopover: (UIPopoverController *) popoverController {
}

#pragma mark - View Management Methods

- (void) viewDidLoad {
    [super viewDidLoad];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName: MAIN_STORY_BOARD bundle:nil];
	molecularCalculatorViewController = [storyboard instantiateViewControllerWithIdentifier: NSStringFromClass([XTRMolecularCalculatorViewController class])];
    [molecularCalculatorViewController view];
    molecularCalculatorViewController.view.frame = self.swapView.frame;
    [swapView removeFromSuperview];
    [self setupPopUp];
    [self toggleMolecularCalculatorState: NO];
}

- (BOOL) shouldAutorotateToInterfaceOrientation: (UIInterfaceOrientation) interfaceOrientation {
    return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

#pragma mark - Memory Management Methods

- (void) dealloc {
    swapView = nil;
}

@end
