//
//  XTRHelpBalloonViewController.m
//  PrimaMateria
//
//  Created by Jerry Porter on 11/21/11.
//  Copyright 2014 xTrensa. All rights reserved.
//

#import "PrimaMateria.h"

@interface XTRHelpBalloonViewController ()
- (void) loadDocument: (NSString *) documentName;
- (void) showElementHelp: (NSNotification *) aNotification;
@end

@implementation XTRHelpBalloonViewController
@synthesize webView;

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
    NSString *object = [aNotification object];
    [self loadDocument: object];
}

#pragma mark - View Management Methods

- (void) viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(showElementHelp:) name: NOTIFICATION_ELEMENT_HELP_SELECTED object: nil];
}

- (BOOL) shouldAutorotateToInterfaceOrientation: (UIInterfaceOrientation) interfaceOrientation {
    return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

#pragma mark - Memory Management Methods

- (void) dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    webView = nil;
}

@end
