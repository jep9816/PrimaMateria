//
//  XTRApplication.m
//  PrimaMateria
//
//  Created by Jerry Porter on 3/22/2010.
//  Copyright 2014 xTrensa. All rights reserved.
//

#import "PrimaMateria.h"

@implementation XTRApplication

#pragma mark Initialization Methods

- (void) registerDefaultsFromSettingsBundle {
    NSString *settingsBundle = [[NSBundle mainBundle] pathForResource: @"Settings" ofType: @"bundle"];
    if (!settingsBundle) {
        NSLog(@"Could not find Settings.bundle");
        return;
    }

    NSDictionary *settings = [NSDictionary dictionaryWithContentsOfFile:[settingsBundle stringByAppendingPathComponent: @"Root.plist"]];
    NSArray *preferences = settings[@"PreferenceSpecifiers"];

    NSMutableDictionary *defaultsToRegister = [[NSMutableDictionary alloc] initWithCapacity:[preferences count]];
    for (NSDictionary *prefSpecification in preferences) {
        NSString *key = prefSpecification[@"Key"];
        if (key) {
            NSString *defaultValue = prefSpecification[@"DefaultValue"];
            if (defaultValue != nil)
                defaultsToRegister[key] = defaultValue;
        }
    }
    [[NSUserDefaults standardUserDefaults] registerDefaults: defaultsToRegister];
}

- (id) init {
    if (self = [super init]) {
        [self setStatusBarHidden: YES withAnimation: NO];
        NSString *directory_url = [[NSUserDefaults standardUserDefaults] stringForKey: SPLASH_SCREEN_DEFAULT];
        if (!directory_url)
            [self registerDefaultsFromSettingsBundle];
        [XTRDataSource sharedInstance];
    }
    return self;
}

#pragma mark - Memory Management Methods

@end
