//
//  XTRHelpBalloonViewController.m
//  PrimaMateria
//
//  Created by Jerry Porter on 11/21/11.
//  Copyright 2016 xTrensa. All rights reserved.
//

#import "PrimaMateria.h"

@interface XTRHelpBalloonViewController ()
- (void)loadDocument: (NSString *) documentName;
- (void)showElementHelp: (NSNotification *) aNotification;
@end

@implementation XTRHelpBalloonViewController

#pragma mark Private Methods

- (void)loadDocument: (NSString *) documentName {
    NSString *path = [[NSBundle mainBundle] pathForResource: documentName ofType: @"html" inDirectory: @"ElementTipHelp"];
    if (path != nil) {
        NSURL *url = [NSURL fileURLWithPath: path];
        NSURLRequest *request = [NSURLRequest requestWithURL: url];
        [self.webView loadRequest: request];
    }
}

- (void)showElementHelp: (NSNotification *) aNotification {
    NSString *object = aNotification.object;
    [self loadDocument: object];
}

#pragma mark - Action Methods

- (IBAction)dismiss: (id) sender {
    [self dismissViewControllerAnimated: YES completion: nil];
}

-(IBAction)backButtonPressed:(id)sender {
    [self.webView goBack];
}

-(IBAction)forwardButtonPressed:(id)sender {
    [self.webView goForward];
}

#pragma mark - WebView Delegate Methods

- (void)webViewDidStartLoad: (UIWebView *) aWebView {
    self.backButton.enabled = NO;
    self.forwardButton.enabled = NO;
    self.backButton.tintColor = UIColor.blackColor;
    self.forwardButton.tintColor = UIColor.blackColor;
}

-(void)webViewDidFinishLoad:(UIWebView *)aWebView {
    if(aWebView.canGoBack == YES) {
        self.backButton.enabled = YES;
        self.backButton.tintColor = UIColor.whiteColor;
        self.forwardButton.tintColor = UIColor.blackColor;
    } else if(aWebView.canGoForward == YES) {
        self.forwardButton.enabled = YES;
        self.backButton.tintColor = UIColor.blackColor;
        self.forwardButton.tintColor = UIColor.whiteColor;
    }
}

#pragma mark - View Management Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexString: @"dddd00"];
    
    self.backButton.enabled = NO;
    self.forwardButton.enabled = NO;
    self.backButton.tintColor = UIColor.blackColor;
    self.forwardButton.tintColor = UIColor.blackColor;
    CALayer *layer = [CALayer layer];
    layer.bounds = self.webView.bounds;
    layer.position = self.webView.center;
    layer.backgroundColor = [UIColor colorWithHexString: @"dddd00"].CGColor;
    layer.shadowRadius = 5;
    layer.shadowOpacity = 0.75;
    layer.shadowOffset = CGSizeMake(5, 5);
    layer.cornerRadius = 8;
    layer.borderWidth = 1;
    
    [self.view.layer insertSublayer:layer below: self.webView.layer];
    self.webView.layer.cornerRadius = 8;
    self.webView.layer.masksToBounds = YES;
    self.titleLabel.layer.cornerRadius = 8.0;
    self.titleLabel.layer.masksToBounds = YES;

    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(showElementHelp:) name: NOTIFICATION_ELEMENT_HELP_SELECTED object: nil];
}

- (BOOL) shouldAutorotateToInterfaceOrientation: (UIInterfaceOrientation) interfaceOrientation {
    return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

#pragma mark - Memory Management Methods

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    self.webView.delegate = nil;
    self.webView = nil;
    self.backButton = nil;
    self.forwardButton = nil;
    self.titleLabel = nil;
}

@end
