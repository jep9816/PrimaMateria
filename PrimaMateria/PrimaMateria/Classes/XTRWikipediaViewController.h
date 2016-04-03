//
//  WikipediaViewController.h
//  PrimaMateria
//
//  Created by Jerry Porter on 11/21/11.
//  Copyright 2014 xTrensa. All rights reserved.
//

@class MBProgressHUD;

@interface XTRWikipediaViewController : UIViewController <UIWebViewDelegate, MBProgressHUDDelegate>

@property (nonatomic, strong) IBOutlet UIBarButtonItem *backButton;
@property (nonatomic, strong) IBOutlet UIBarButtonItem *titleButtonItem;
@property (nonatomic, strong) IBOutlet UIBarButtonItem *forwardButton;
@property (nonatomic, strong) IBOutlet UIWebView *webView;
@property (nonatomic, strong) MBProgressHUD *progressHUD;
@property (nonatomic, strong) NSMutableData *responseData;
@property (nonatomic, strong) NSMutableURLRequest *request;
@property (nonatomic, strong) NSString *elementName;

- (IBAction)dismiss: (id)sender;
- (IBAction)backButtonPressed:(id)sender;
- (IBAction)forwardButtonPressed:(id)sender;

@end
