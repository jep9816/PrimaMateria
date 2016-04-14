//
//  MolecularCalculatorViewController.h
//  PrimaMateria
//
//  Created by Jerry Porter on 11/21/11.
//  Copyright 2016 xTrensa. All rights reserved.
//
    
@interface XTRMolecularCalculatorViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *errorLabel;
@property (strong, nonatomic) IBOutlet UILabel *formulaLabel;
@property (strong, nonatomic) IBOutlet UILabel *resultsLabel;
@property (strong, nonatomic) IBOutlet UITextField *formulaTextField;
@property (strong, nonatomic) IBOutlet UIView *backgroundView;

- (IBAction)calculate: (id) sender;
- (IBAction)clear: (id) sender;
- (IBAction)numberClicked: (id) sender;

- (void)setElement: (XTRElement *)anElement;

@end
