//
//  XTRHelpViewController.m
//  PrimaMateria
//
//  Created by Jerry Porter on 11/21/11.
//  Copyright (c) 2016 xTrensa. All rights reserved.
//

@interface XTRHelpViewController ()
- (void)loadDocument: (NSString *) documentName;
@end

@implementation XTRHelpViewController

#pragma mark Private Methods

- (void)loadDocument: (NSString *) documentName {
    NSString *path = [[NSBundle mainBundle] pathForResource: documentName ofType: @"html" inDirectory: @"PrimaMateriaHelp"];
    NSURL *url = [NSURL fileURLWithPath: path];
    NSURLRequest *request = [NSURLRequest requestWithURL: url];
    [self.webView loadRequest: request];
}

#pragma mark - View Management Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadDocument: @"index"];
}

- (BOOL) shouldAutorotateToInterfaceOrientation: (UIInterfaceOrientation) interfaceOrientation {
    return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

#pragma mark - Memory Management Methods

- (void)dealoc {
    self.webView.delegate = nil;
    self.webView = nil;
}

@end
