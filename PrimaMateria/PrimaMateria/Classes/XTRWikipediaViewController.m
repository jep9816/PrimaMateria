//
//  XTRWikipediaViewController.m
//  PrimaMateria
//
//  Created by Jerry Porter on 11/21/11.
//  Copyright 2014 xTrensa. All rights reserved.
//

@interface XTRWikipediaViewController ()

- (void)prepareRequest;

@end

@implementation XTRWikipediaViewController

#pragma mark Private Methods

- (void)prepareRequest {
    NSURL *url = [NSURL URLWithString: [NSString stringWithFormat: @"https://en.wikipedia.org/wiki/%@", self.elementName]];
    NSMutableURLRequest *requestObj = [NSMutableURLRequest requestWithURL: url];
    
    [self.webView loadRequest: requestObj];
}

#pragma mark - Action Methods

- (IBAction)dismiss: (id)sender {
    [self dismissViewControllerAnimated: YES completion:nil];
}

-(IBAction)backButtonPressed: (id)sender {
    [self.progressHUD showAnimated: YES];
    [self.webView goBack];
}

-(IBAction)forwardButtonPressed: (id)sender {
    [self.progressHUD showAnimated: YES];
    [self.webView goForward];
}

#pragma mark - WebView Delegate Methods

- (void)webViewDidStartLoad: (UIWebView *)aWebView {
    [self.progressHUD showAnimated: YES];
    
    self.backButton.enabled = NO;
    self.forwardButton.enabled = NO;
    self.backButton.tintColor = UIColor.blackColor;
    self.forwardButton.tintColor = UIColor.blackColor;
}

- (void)webViewDidFinishLoad: (UIWebView *)aWebView {
    [MBProgressHUD hideHUDForView: self.view animated: YES];
    
    if(aWebView.canGoBack) {
        self.backButton.enabled = YES;
        self.backButton.tintColor = UIColor.whiteColor;
        self.forwardButton.tintColor = UIColor.blackColor;
    } else if(aWebView.canGoForward) {
        self.forwardButton.enabled = YES;
        self.backButton.tintColor = UIColor.blackColor;
        self.forwardButton.tintColor = UIColor.whiteColor;
    }
}

- (void)webView: (UIWebView *)webView didFailLoadWithError: (nullable NSError *)error {
    NSURL *url = [NSURL fileURLWithPath: [[NSBundle mainBundle] pathForResource: @"LoadFailure" ofType: @"html"]];
    NSMutableURLRequest *requestObj = [NSMutableURLRequest requestWithURL: url];
    
    [MBProgressHUD hideHUDForView: self.view animated: YES];
    
    [self.webView loadRequest: requestObj];
}

#pragma mark - View Management Methods

-(void)viewDidLoad {
    [super viewDidLoad];
    NSDictionary *textAttributes = @{NSForegroundColorAttributeName: UIColor.whiteColor, NSFontAttributeName: [UIFont boldSystemFontOfSize: 20]};
    [self.titleButtonItem setTitleTextAttributes: textAttributes forState: UIControlStateNormal];
    
    self.preferredContentSize = CGSizeMake(768, 620);

    self.progressHUD = [[MBProgressHUD alloc] initWithView: self.view];
    self.progressHUD.label.font = [UIFont fontWithName: @"Verdana-Bold" size: 26.0];
    self.progressHUD.detailsLabel.font = [UIFont fontWithName: @"Verdana-Bold" size: 15.0];
    self.progressHUD.delegate = self;
    self.progressHUD.label.text = @"Please Wait";
    self.progressHUD.detailsLabel.text = [NSString stringWithFormat: @"Loading Wikipedia Page for element: %@.", self.elementName];
}

- (void)viewWillAppear: (BOOL) animated {
    [super viewWillAppear:animated];
    
    self.titleButtonItem.title = [NSString stringWithFormat: @"Wikipedia Entry for element:  %@", self.elementName];
    
    self.backButton.enabled = NO;
    self.backButton.tintColor = UIColor.blackColor;
    self.forwardButton.enabled = NO;
    self.forwardButton.tintColor = UIColor.blackColor;
        
    [self.view addSubview: self.progressHUD];
    [self.progressHUD showAnimated: YES];
    [self prepareRequest];
}

- (BOOL)shouldAutorotateToInterfaceOrientation: (UIInterfaceOrientation) interfaceOrientation {
    return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

#pragma mark - MBProgressHUDDelegate methods

- (void)hudWasHidden: (MBProgressHUD *)aProgressHUD {
    [aProgressHUD removeFromSuperview];
}

#pragma mark - Memory Management Methods

- (void)dealloc {
    self.backButton = nil;
    self.forwardButton = nil;
    self.titleButtonItem = nil;
    self.webView.delegate = nil;
    self.webView = nil;
}

@end
