//
//  XTRFirstViewController.h
//  PrimaMateria
//
//  Created by Jerry Porter on 11/21/11.
//  Copyright 2016 xTrensa. All rights reserved.
//

@interface XTRPeriodicTableViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIView *swapView;

@property (assign, nonatomic) BOOL molecularCalculatorState;
@property (strong, nonatomic) XTRElementBalloonViewController *elementBalloonViewController;
@property (strong, nonatomic) XTRMolecularCalculatorViewController *molecularCalculatorViewController;

- (IBAction)showElementInspector : sender;
- (IBAction)showMolecularCalculator : (UISwitch *)sender;

@end
