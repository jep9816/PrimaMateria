//
//  GeneralInfoViewController.h
//  PrimaMateria
//
//  Created by Jerry Porter on 11/21/11.
//  Copyright 2016 xTrensa. All rights reserved.
//

@class XTRWikipediaViewController;
@class XTRSwapableViewController;

@interface XTRGeneralInfoViewController : XTRSwapableViewController {
}

@property (nonatomic, strong) IBOutlet UILabel *discovererLabel;
@property (nonatomic, strong) IBOutlet UILabel *discoveryLocationLabel;
@property (nonatomic, strong) IBOutlet UILabel *discoveryYearLabel;
@property (nonatomic, strong) IBOutlet UILabel *abundanceCrustLabel;
@property (nonatomic, strong) IBOutlet UILabel *abundanceSeaLabel;
@property (nonatomic, strong) IBOutlet UIWebView *webView;

- (IBAction)showWikipediaEntry : (id)sender;
- (void) setupUI;

@end
