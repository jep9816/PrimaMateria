//
//  XTRApplication.m
//  PrimaMateria
//
//  Created by Jerry Porter on 3/22/2010.
//  Copyright 2016 xTrensa. All rights reserved.
//

@implementation XTRApplication

#pragma mark Initialization Methods

- (void)registerDefaultsFromSettingsBundle {
    NSString *settingsBundle = [[NSBundle mainBundle] pathForResource: @"Settings" ofType: @"bundle"];
    if (!settingsBundle) {
        NSLog(@"Could not find Settings.bundle");
        return;
    }

    NSDictionary *settings = [NSDictionary dictionaryWithContentsOfFile:[settingsBundle stringByAppendingPathComponent: @"Root.plist"]];
    NSArray *preferences = settings[@"PreferenceSpecifiers"];

    NSMutableDictionary *defaultsToRegister = [[NSMutableDictionary alloc] initWithCapacity:preferences.count];
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
- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (instancetype) init {
    if (self = [super init]) {
        NSString *aDefault = [[NSUserDefaults standardUserDefaults] stringForKey: SPLASH_SCREEN_DEFAULT];
        
        if (!aDefault) {
            [self registerDefaultsFromSettingsBundle];
        }
        [XTRDataSource sharedInstance];
    }
    return self;
}

#pragma mark - Memory Management Methods

@end
