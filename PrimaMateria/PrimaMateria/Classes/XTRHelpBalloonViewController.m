//
//  XTRHelpBalloonViewController.m
//  PrimaMateria
//
//  Created by Jerry Porter on 11/21/11.
//  Copyright 2016 xTrensa. All rights reserved.
//

#import "PrimaMateria.h"

@interface XTRHelpBalloonViewController ()
- (void) loadDocument: (NSString *) documentName;
- (void) showElementHelp: (NSNotification *) aNotification;
@end

@implementation XTRHelpBalloonViewController
@synthesize webView;
@synthesize backbutton;
@synthesize fwdbutton;
@synthesize titleLabel;

#pragma mark Private Methods

- (void) loadDocument: (NSString *) documentName {
    NSString *path = [[NSBundle mainBundle] pathForResource: documentName ofType: @"html" inDirectory: @"ElementTipHelp"];
    if (path != nil) {
        NSURL *url = [NSURL fileURLWithPath: path];
        NSURLRequest *request = [NSURLRequest requestWithURL: url];
        [webView loadRequest: request];
    }
}

- (void) showElementHelp: (NSNotification *) aNotification {
    NSString *object = aNotification.object;
    [self loadDocument: object];
}

#pragma mark - Action Methods

- (IBAction)close: (id) sender {
    [self dismissViewControllerAnimated: YES completion: nil];
}

#pragma mark - WebView Delegate Methods

-(void)webViewDidFinishLoad:(UIWebView *)webView {
    if ([self.webView canGoBack])
        [self.backbutton setEnabled:YES];
    else
        [self.backbutton setEnabled:NO];
    
    if ([self.webView canGoForward])
        [self.fwdbutton setEnabled:YES];
    else
        [self.fwdbutton setEnabled:NO];
}

#pragma mark - View Management Methods

- (void) viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexString: @"dddd00"];
    
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
    
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(showElementHelp:) name: NOTIFICATION_ELEMENT_HELP_SELECTED object: nil];
}

- (BOOL) shouldAutorotateToInterfaceOrientation: (UIInterfaceOrientation) interfaceOrientation {
    return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

#pragma mark - Memory Management Methods

- (void) dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    webView.delegate = nil;
    webView = nil;
    backbutton = nil;
    fwdbutton = nil;
    titleLabel = nil;
}

@end
