//
//  XTRFirstViewController.h
//  PrimaMateria
//
//  Created by Jerry Porter on 11/21/11.
//  Copyright 2014 xTrensa. All rights reserved.
//

@interface XTRPeriodicTableViewController : UIViewController <UIPopoverControllerDelegate>

@property (strong, nonatomic) XTRElementBalloonViewController *elementBalloonViewController;
@property (strong, nonatomic) XTRMolecularCalculatorViewController *molecularCalculatorViewController;
@property (strong, nonatomic) IBOutlet UIView *swapView;
@property (strong, nonatomic) UIPopoverController *popoverController;
@property BOOL molecularCalculatorState;

- (IBAction)showElementInspector : sender;
- (IBAction)showMolecularCalculator : (UISwitch *)sender;

@end
