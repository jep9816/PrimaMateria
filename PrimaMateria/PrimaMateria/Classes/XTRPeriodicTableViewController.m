//
//  XTRFirstViewController.m
//  PrimaMateria
//
//  Created by Jerry Porter on 11/21/11.
//  Copyright 2016 xTrensa. All rights reserved.
//

#import "PrimaMateria.h"

@interface XTRPeriodicTableViewController ()
- (void) showPopupForButton: (id) sender;
- (void) showElementPanelForElementAtIndex: (int) anIndex;
- (void) setupPopUp;
- (void) toggleMolecularCalculatorState: (BOOL) aFlag;
@end

@implementation XTRPeriodicTableViewController
@synthesize swapView;
@synthesize molecularCalculatorViewController;
@synthesize molecularCalculatorState;
@synthesize elementBalloonViewController;

#pragma mark Private Methods

- (void) showPopupForButton: (id) sender {
    [XTRPropertiesStore storeViewTitle: self.title];
    [XTRPropertiesStore storeAtomicNumber: @([sender tag])];

    CGRect aRect = CGRectMake(10, 10, 15, 15);
    elementBalloonViewController.popoverPresentationController.sourceRect = aRect;
    elementBalloonViewController.popoverPresentationController.sourceView = sender;
    [self presentViewController:elementBalloonViewController animated:YES completion:nil];
}

- (void) showElementPanelForElementAtIndex: (int) anIndex {
    [XTRPropertiesStore storeViewTitle: self.title];
    [XTRPropertiesStore storeAtomicNumber:@(anIndex)];
    [self performSegueWithIdentifier: SHOW_INSPECTOR_FROM_PERIODIC_TABLE sender: self];
}

- (void) setupPopUp {
    UIStoryboard *storyboard = [XTRAppDelegate storyboard];
	elementBalloonViewController = [storyboard instantiateViewControllerWithIdentifier: NSStringFromClass([XTRElementBalloonViewController class])];
    CGSize contentSize = CGSizeMake(320.0f, 206.0f);
    elementBalloonViewController.preferredContentSize = contentSize;
    elementBalloonViewController.modalPresentationStyle = UIModalPresentationPopover;
}

- (void) toggleMolecularCalculatorState: (BOOL) aFlag {
    if (!aFlag) {
        molecularCalculatorState = NO;
        [molecularCalculatorViewController.view removeFromSuperview];
        [molecularCalculatorViewController viewWillDisappear: YES];
    } else {
        molecularCalculatorState = YES;
        [self.view addSubview:molecularCalculatorViewController.view];
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
        BOOL defaultState = [XTRPropertiesStore retreiveElementBubblesState];
        
        if (defaultState) {
            [self showPopupForButton: sender];
        } else {
            [self showElementPanelForElementAtIndex:[sender tag]];
        }
    }
}

#pragma mark - Notification Methods

-(void)closeBubble: (NSNotification *)aNotification {
    [self dismissViewControllerAnimated: YES completion: nil];
}

#pragma mark - View Management Methods

- (void) viewDidLoad {
    [super viewDidLoad];
    UIStoryboard *storyboard = [XTRAppDelegate storyboard];
	molecularCalculatorViewController = [storyboard instantiateViewControllerWithIdentifier: NSStringFromClass([XTRMolecularCalculatorViewController class])];
    molecularCalculatorViewController.view.frame = self.swapView.frame;
    [swapView removeFromSuperview];
    [self setupPopUp];
    [self toggleMolecularCalculatorState: NO];
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(closeBubble:) name: NOTIFICATION_INSPECTOR_DISMISSED object: nil];

}

- (BOOL) shouldAutorotateToInterfaceOrientation: (UIInterfaceOrientation)interfaceOrientation {
    return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

#pragma mark - Memory Management Methods

- (void) dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver: self];
    swapView = nil;
}

@end
