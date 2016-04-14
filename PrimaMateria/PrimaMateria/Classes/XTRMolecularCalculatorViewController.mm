//
//  XTRMolecularCalculatorViewController.m
//  PrimaMateria
//
//  Created by Jerry Porter on 11/21/11.
//  Copyright 2016 xTrensa. All rights reserved.
//

#import "MolecularCalculator.h"

@interface XTRMolecularCalculatorViewController ()
- (void)cleanUp;
- (void)setLabelForNumber: (int) aNumber;
- (void)setLabelForSymbol: (NSString *) aSymbol;
- (void)setTextFieldForNumber: (int) aNumber;
- (void)setTextFieldForSymbol: (NSString *) aSymbol;
@end

@implementation XTRMolecularCalculatorViewController

#pragma mark Private Methods

- (void)cleanUp {
    self.errorLabel.text = STRING_EMPTY;
    self.formulaTextField.text =  STRING_EMPTY;
    self.formulaLabel.text =  STRING_EMPTY;
    self.resultsLabel.text =  STRING_EMPTY;
}

- (void)setTextFieldForNumber: (int) aNumber {
    NSMutableString *origString = [[NSMutableString alloc] initWithString: self.formulaTextField.text];
    [origString appendString:[NSString stringWithFormat: @"%d", aNumber]];
    self.formulaTextField.text = origString;
}

- (void)setLabelForNumber: (int) aNumber {
    NSString *origString = self.formulaLabel.text;
    switch (aNumber) {
        case 0:
            self.formulaLabel.text = [NSString stringWithFormat: @"%@%@", origString, @"\u2080"];
            break;
            
        case 1:
            self.formulaLabel.text = [NSString stringWithFormat: @"%@%@", origString, @"\u2081"];
            break;
            
        case 2:
            self.formulaLabel.text = [NSString stringWithFormat: @"%@%@", origString, @"\u2082"];
            break;
            
        case 3:
            self.formulaLabel.text = [NSString stringWithFormat: @"%@%@", origString, @"\u2083"];
            break;
            
        case 4:
            self.formulaLabel.text = [NSString stringWithFormat: @"%@%@", origString, @"\u2084"];
            break;
            
        case 5:
            self.formulaLabel.text = [NSString stringWithFormat: @"%@%@", origString, @"\u2085"];
            break;
            
        case 6:
            self.formulaLabel.text = [NSString stringWithFormat: @"%@%@", origString, @"\u2086"];
            break;
            
        case 7:
            self.formulaLabel.text = [NSString stringWithFormat: @"%@%@", origString, @"\u2087"];
            break;
            
        case 8:
            self.formulaLabel.text = [NSString stringWithFormat: @"%@%@", origString, @"\u2088"];
            break;
            
        case 9:
            self.formulaLabel.text = [NSString stringWithFormat: @"%@%@", origString, @"\u2089"];
            break;
            
        default:
            break;
    }
}

- (void)setTextFieldForSymbol: (NSString *) aSymbol {
    NSMutableString *origString = [[NSMutableString alloc] initWithString: self.formulaTextField.text];
    [origString appendString: aSymbol];
    self.formulaTextField.text = origString;
}

- (void)setLabelForSymbol: (NSString *) aSymbol {
    NSMutableString *origString = [[NSMutableString alloc] initWithString: self.formulaLabel.text];
    [origString appendString: aSymbol];
    self.formulaLabel.text = origString;
}

- (void)setElement: (XTRElement *)anElement {
    [self setTextFieldForSymbol:anElement.symbol];
    [self setLabelForSymbol:anElement.symbol];
}

#pragma mark - Action Methods

- (IBAction) calculate: (id) sender {
    double result = mcalc([self.formulaTextField.text cStringUsingEncoding: NSASCIIStringEncoding]);
    if (result == 0)
        self.errorLabel.text =  @"Unknown symbol or syntax error.";
    else {
        self.resultsLabel.text = [NSString stringWithFormat: @"%f", result];
        self.errorLabel.text =  STRING_EMPTY;
    }
}

- (IBAction) clear: (id) sender {
    [self cleanUp];
}

- (IBAction) numberClicked: (id) sender {
    NSInteger length = self.formulaTextField.text.length;
    NSInteger tag = [sender tag];
    if (length > 0) {
        BOOL is_alpha = isalpha([self.formulaTextField.text characterAtIndex:(NSUInteger) (length - 1)]);
        BOOL is_char = isnumber([self.formulaTextField.text characterAtIndex:(NSUInteger) (length - 1)]);
        if (is_alpha || is_char) {
            [self setTextFieldForNumber: tag];
            [self setLabelForNumber: tag];
        }
    }
}

#pragma mark - View Management Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    self.backgroundView.layer.borderColor = UIColor.blackColor.CGColor;
    self.backgroundView.layer.borderWidth = 2;
    self.backgroundView.layer.cornerRadius = 8;

    [self cleanUp];
}

- (void)viewWillDisappear: (BOOL) animated {
    [super viewWillDisappear:animated];
    [self cleanUp];
}

- (BOOL) shouldAutorotateToInterfaceOrientation: (UIInterfaceOrientation) interfaceOrientation {
    return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

#pragma mark - Memory Management Methods

- (void)dealloc {
    self.errorLabel = nil;
    self.formulaTextField = nil;
    self.formulaLabel = nil;
    self.resultsLabel = nil;
}

@end
