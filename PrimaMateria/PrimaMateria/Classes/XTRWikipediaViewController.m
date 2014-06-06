//
//  XTRWikipediaViewController.m
//  PrimaMateria
//
//  Created by Jerry Porter on 11/21/11.
//  Copyright 2014 xTrensa. All rights reserved.
//

#import "PrimaMateria.h"

@interface XTRWikipediaViewController ()
- (void) prepareRequest;
- (void) loadFailureMessage;
@end

@implementation XTRWikipediaViewController

#pragma mark Private Methods


- (void) prepareRequest {
    NSString *path = [NSString stringWithFormat: @"http://en.wikipedia.org/wiki/%@", self.elementName];
    NSURL *url = [NSURL URLWithString: path];
    NSMutableURLRequest *requestObj = [NSMutableURLRequest requestWithURL: url];
    [requestObj setCachePolicy: NSURLRequestReloadIgnoringLocalCacheData];
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest: requestObj delegate: self];
    if (connection) {
        [self.progressHUD show: YES];
        [self.webView loadRequest: requestObj];
    } else {
        [MBProgressHUD hideHUDForView: self.webView animated: YES];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Alert" message: @"Network error occured. Could not load url." delegate: self cancelButtonTitle: @"OK" otherButtonTitles: nil];
        [alert show];
    }
}

- (void) loadFailureMessage {
    NSURL *url = [NSURL fileURLWithPath: [[NSBundle mainBundle] pathForResource: @"LoadFailure" ofType: @"html"]];
    self.request = [NSURLRequest requestWithURL: url];
    [self.webView removeFromSuperview];
}

#pragma mark - Action Methods

- (IBAction) dismiss: (id) sender {
    [self dismissViewControllerAnimated: YES completion:nil];
}

-(IBAction)backButtonPressed:(id)sender {
    [self.progressHUD show: YES];
	[self.webView goBack]; 
}

-(IBAction)forwardButtonPressed:(id)sender {
    [self.progressHUD show: YES];
	[self.webView goForward];
}

#pragma mark - Connection Delegate Methods

- (void) connection: (NSURLConnection *) connection didFailLoadWithError: (NSError *) error {
    [MBProgressHUD hideHUDForView: self.webView animated: YES];
    UIApplication *app = [UIApplication sharedApplication];
    app.networkActivityIndicatorVisible = NO;
    [self.webView stopLoading];
    NSLog(@"error...");
    NSInteger myErrorCode = [error code]; // myErrorCode = -999 if user cancel action
    if (myErrorCode != - 999) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Alert" message: @"Unable to connect. Contact IT for support." delegate: self cancelButtonTitle: nil otherButtonTitles: @"OK", nil];
        [alert show];
    }
}

- (NSCachedURLResponse *) connection: (NSURLConnection *) connection willCacheResponse: (NSCachedURLResponse *) cachedResponse {
    NSCachedURLResponse *newCachedResponse = cachedResponse;
    if ([[[[cachedResponse response] URL] scheme] isEqual: @"http"])
        newCachedResponse = nil;
    return newCachedResponse;
}

- (void) connection: (NSURLConnection *) connection didReceiveResponse: (NSURLResponse *) response {
    [self.responseData setLength: 0];
}

- (void) connection: (NSURLConnection *) connection didReceiveData: (NSData *) data {
    [self.responseData appendData: data];
}

- (BOOL) connectionShouldUseCredentialStorage: (NSURLConnection *) connection {
    return NO;
}

- (void) connectionDidFinishLoading: (NSURLConnection *) aConnection {
    [MBProgressHUD hideHUDForView: self.webView animated: YES];
}

#pragma mark - WebView Delegate Methods

- (void) webViewDidStartLoad: (UIWebView *) webView {
    [self.progressHUD show: YES];
	self.back.enabled = NO;
	self.forward.enabled = NO;
}

- (void) webViewDidFinishLoad: (UIWebView *) aWebView {
    [MBProgressHUD hideHUDForView: self.webView animated: YES];
	if(aWebView.canGoBack == YES)
		self.back.enabled = YES;
	if(aWebView.canGoForward == YES)
		self.forward.enabled = YES;
}

#pragma mark - View Management Methods

- (BOOL) shouldAutorotateToInterfaceOrientation: (UIInterfaceOrientation) interfaceOrientation {
    return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

- (void) viewWillAppear: (BOOL) animated {
    [super viewWillAppear:animated];
    self.back.enabled = NO;
    self.forward.enabled = NO;
    NSString *localTitle = [NSString stringWithFormat: @"Loading Wikipedia Page for element: %@.", self.elementName];
    NSString *titleString = [NSString stringWithFormat: @"Wikipedia Entry for element:  %@", self.elementName];
    self.barButtonItem.title = titleString;
    self.progressHUD = [[MBProgressHUD alloc] initWithView: self.view];
    self.progressHUD.labelFont = [UIFont fontWithName: @"Verdana-Bold" size: 26.0];
    self.progressHUD.detailsLabelFont = [UIFont fontWithName: @"Verdana-Bold" size: 15.0];
    [self.webView addSubview: self.progressHUD];
    self.progressHUD.delegate = self;
    self.progressHUD.labelText = @"Please Wait";
    self.progressHUD.detailsLabelText = localTitle;
    [self.progressHUD show: YES];
    [self prepareRequest];
}

#pragma mark - MBProgressHUDDelegate methods

- (void) hudWasHidden: (MBProgressHUD *) aProgressHUD {
    [aProgressHUD removeFromSuperview];
}

#pragma mark - Memory Management Methods

- (void) dealloc {
    self.barButtonItem = nil;
    self.webView = nil;
    self.back = nil;
    self.forward = nil;
}

@end
