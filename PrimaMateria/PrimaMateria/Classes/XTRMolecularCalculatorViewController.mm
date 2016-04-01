//
//  XTRMolecularCalculatorViewController.m
//  PrimaMateria
//
//  Created by Jerry Porter on 11/21/11.
//  Copyright 2016 xTrensa. All rights reserved.
//

#import "PrimaMateria.h"
#import "MolecularCalculator.h"

@interface XTRMolecularCalculatorViewController ()
- (void) cleanUp;
- (void) setLabelForNumber: (int) aNumber;
- (void) setLabelForSymbol: (NSString *) aSymbol;
- (void) setTextFieldForNumber: (int) aNumber;
- (void) setTextFieldForSymbol: (NSString *) aSymbol;
@end

@implementation XTRMolecularCalculatorViewController
@synthesize errorLabel;
@synthesize formulaTextField;
@synthesize resultsLabel;
@synthesize formulaLabel;

#pragma mark Private Methods

- (void) cleanUp {
    errorLabel.text = STRING_EMPTY;
    formulaTextField.text =  STRING_EMPTY;
    formulaLabel.text =  STRING_EMPTY;
    resultsLabel.text =  STRING_EMPTY;
}

- (void) setTextFieldForNumber: (int) aNumber {
    NSMutableString *origString = [[NSMutableString alloc] initWithString:formulaTextField.text];
    [origString appendString:[NSString stringWithFormat: @"%d", aNumber]];
    formulaTextField.text = origString;
}

- (void) setLabelForNumber: (int) aNumber {
    NSString *origString = formulaLabel.text;
    switch (aNumber) {
        case 0:
            formulaLabel.text = [NSString stringWithFormat: @"%@%@", origString, @"\u2080"];
            break;
            
        case 1:
            formulaLabel.text = [NSString stringWithFormat: @"%@%@", origString, @"\u2081"];
            break;
            
        case 2:
            formulaLabel.text = [NSString stringWithFormat: @"%@%@", origString, @"\u2082"];
            break;
            
        case 3:
            formulaLabel.text = [NSString stringWithFormat: @"%@%@", origString, @"\u2083"];
            break;
            
        case 4:
            formulaLabel.text = [NSString stringWithFormat: @"%@%@", origString, @"\u2084"];
            break;
            
        case 5:
            formulaLabel.text = [NSString stringWithFormat: @"%@%@", origString, @"\u2085"];
            break;
            
        case 6:
            formulaLabel.text = [NSString stringWithFormat: @"%@%@", origString, @"\u2086"];
            break;
            
        case 7:
            formulaLabel.text = [NSString stringWithFormat: @"%@%@", origString, @"\u2087"];
            break;
            
        case 8:
            formulaLabel.text = [NSString stringWithFormat: @"%@%@", origString, @"\u2088"];
            break;
            
        case 9:
            formulaLabel.text = [NSString stringWithFormat: @"%@%@", origString, @"\u2089"];
            break;
            
        default:
            break;
    }
}

- (void) setTextFieldForSymbol: (NSString *) aSymbol {
    NSMutableString *origString = [[NSMutableString alloc] initWithString: formulaTextField.text];
    [origString appendString: aSymbol];
    formulaTextField.text = origString;
}

- (void) setLabelForSymbol: (NSString *) aSymbol {
    NSMutableString *origString = [[NSMutableString alloc] initWithString: formulaLabel.text];
    [origString appendString: aSymbol];
    formulaLabel.text = origString;
}

- (void) setElement: (XTRElement *)anElement {
    [self setTextFieldForSymbol:anElement.symbol];
    [self setLabelForSymbol:anElement.symbol];
}

#pragma mark - Action Methods

- (IBAction) calculate: (id) sender {
    double result = mcalc([formulaTextField.text cStringUsingEncoding: NSASCIIStringEncoding]);
    if (result == 0)
        errorLabel.text =  @"Unknown symbol or syntax error.";
    else {
        resultsLabel.text = [NSString stringWithFormat: @"%f", result];
        errorLabel.text =  STRING_EMPTY;
    }
}

- (IBAction) clear: (id) sender {
    [self cleanUp];
}

- (IBAction) numberClicked: (id) sender {
    NSInteger length = formulaTextField.text.length;
    NSInteger tag = [sender tag];
    if (length > 0) {
        BOOL is_alpha = isalpha([formulaTextField.text characterAtIndex: (length - 1)]);
        BOOL is_char = isnumber([formulaTextField.text characterAtIndex: (length - 1)]);
        if (is_alpha || is_char) {
            [self setTextFieldForNumber: tag];
            [self setLabelForNumber: tag];
        }
    }
}

#pragma mark - View Management Methods

- (void) viewDidLoad {
    [super viewDidLoad];
    self.backgroundView.layer.borderColor = UIColor.blackColor.CGColor;
    self.backgroundView.layer.borderWidth = 2;
    self.backgroundView.layer.cornerRadius = 8;

    [self cleanUp];
}

- (void) viewWillDisappear: (BOOL) animated {
    [super viewWillDisappear:animated];
    [self cleanUp];
}

- (BOOL) shouldAutorotateToInterfaceOrientation: (UIInterfaceOrientation) interfaceOrientation {
    return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

#pragma mark - Memory Management Methods

- (void) dealloc {
    errorLabel = nil;
    formulaTextField = nil;
    formulaLabel = nil;
    resultsLabel = nil;
}

@end
