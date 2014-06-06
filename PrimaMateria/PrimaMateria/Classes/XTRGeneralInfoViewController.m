//
//  GeneralInfoViewController.m
//  PrimaMateria
//
//  Created by Jerry Porter on 11/21/11.
//  Copyright 2014 xTrensa. All rights reserved.
//

#import "PrimaMateria.h"

@interface XTRGeneralInfoViewController ()
- (void) assignGeneralInfo;
@end

@implementation XTRGeneralInfoViewController
@synthesize abundanceCrustLabel;
@synthesize abundanceSeaLabel;
@synthesize discovererLabel;
@synthesize discoveryLocationLabel;
@synthesize discoveryYearLabel;
@synthesize webView;

#pragma mark Private Methods

- (void) assignGeneralInfo {
    NSString *path = [self.element pathForGeneralInfoDoc];
    NSURL *url = [NSURL fileURLWithPath: path];
    NSURLRequest *request = [NSURLRequest requestWithURL: url];
    [webView loadRequest: request];
}

#pragma mark - Misc Methods

- (void) setupUI {
    if (self.element != nil) {
        discovererLabel.text = [self.element valueForKey: ELEMENT_DISCOVERER];
        discoveryLocationLabel.text = [self.element valueForKey: ELEMENT_DISCOVERY_LOCATION];
        discoveryYearLabel.text = [self.element valueForKey: ELEMENT_DISCOVERY_YEAR];
        abundanceCrustLabel.text = [NSString stringWithFormat: @"%@", [self.element valueForKey: ELEMENT_ABUNDANCE_CRUST]];
        abundanceSeaLabel.text = [NSString stringWithFormat: @"%@", [self.element valueForKey: ELEMENT_ABUNDANCE_SEA]];
        [self assignGeneralInfo];
    }
}

#pragma mark - Action Methods

- (IBAction) showWikipediaEntry: (id) sender {
    [self performSegueWithIdentifier: SHOW_WIKIPEDIA_VIEW_CONTROLLER_FROM_GENERAL_VIEW_CONTROLLER sender: self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    ((XTRWikipediaViewController *)segue.destinationViewController).elementName = self.element.name;
}

#pragma mark - View Management Methods

#pragma mark - Memory Management Methods

- (void) dealloc {
    abundanceCrustLabel = nil;
    abundanceSeaLabel = nil;
    discovererLabel = nil;
    discoveryLocationLabel = nil;
    discoveryYearLabel = nil;
    webView = nil;
}

@end
