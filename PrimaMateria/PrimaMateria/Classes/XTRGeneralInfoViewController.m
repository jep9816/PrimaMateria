//
//  GeneralInfoViewController.m
//  PrimaMateria
//
//  Created by Jerry Porter on 11/21/11.
//  Copyright 2016 xTrensa. All rights reserved.
//

@interface XTRGeneralInfoViewController ()
- (void)assignGeneralInfo;
@end

@implementation XTRGeneralInfoViewController

#pragma mark Private Methods

- (void)assignGeneralInfo {
    NSString *path = (self.element).pathForGeneralInfoDoc;
    NSURL *url = [NSURL fileURLWithPath: path];
    NSURLRequest *request = [NSURLRequest requestWithURL: url];
    [self.webView loadRequest: request];
}

#pragma mark - Misc Methods

- (void)setupUI {
    if (self.element != nil) {
        self.discovererLabel.text = [self.element valueForKey: ELEMENT_DISCOVERER];
        self.discoveryLocationLabel.text = [self.element valueForKey: ELEMENT_DISCOVERY_LOCATION];
        self.discoveryYearLabel.text = [self.element valueForKey: ELEMENT_DISCOVERY_YEAR];
        self.abundanceCrustLabel.text = [NSString stringWithFormat: @"%@", [self.element valueForKey: ELEMENT_ABUNDANCE_CRUST]];
        self.abundanceSeaLabel.text = [NSString stringWithFormat: @"%@", [self.element valueForKey: ELEMENT_ABUNDANCE_SEA]];
        [self assignGeneralInfo];
    }
}

#pragma mark - Action Methods

- (IBAction)showWikipediaEntry: (id) sender {
    [self performSegueWithIdentifier: SHOW_WIKIPEDIA_VIEW_CONTROLLER_FROM_GENERAL_VIEW_CONTROLLER sender: self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    XTRWikipediaViewController * destController = segue.destinationViewController;
    destController.elementName = self.element.name;
}


#pragma mark - View Management Methods

- (BOOL)shouldAutorotateToInterfaceOrientation: (UIInterfaceOrientation) interfaceOrientation {
    return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

#pragma mark - Memory Management Methods

- (void)dealloc {
    self.abundanceCrustLabel = nil;
    self.abundanceSeaLabel = nil;
    self.discovererLabel = nil;
    self.discoveryLocationLabel = nil;
    self.discoveryYearLabel = nil;
    self.webView.delegate = nil;
    self.webView = nil;
}

@end
