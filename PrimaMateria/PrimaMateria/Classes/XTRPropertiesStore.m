//
//  XTRPropertiesStore.h
//  PrimaMateria
//
//  Created by Jerry Porter on 1/5/2011.
//  Copyright 2016 xTrensa. All rights reserved.
//

@implementation XTRPropertiesStore

#pragma mark PrimaMateria Methods

+ (NSNumber *)retreiveAtomicNumber {
    NSNumber *defaultValue = [[NSUserDefaults standardUserDefaults] valueForKey: ELEMENT_ATOMIC_NUMBER];
    if (defaultValue == nil) {
        defaultValue = @1;
        [XTRPropertiesStore storeAtomicNumber: defaultValue];
    }
    return defaultValue;
}

+ (void)storeAtomicNumber: (NSNumber *) aValue {
    if (aValue != nil) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setValue: aValue forKey: ELEMENT_ATOMIC_NUMBER];
        [defaults synchronize];
    }
}

+ (NSString *)retreiveViewTitle {
    NSString *defaultValue = [[NSUserDefaults standardUserDefaults] stringForKey: VIEW_TITLE_KEY];
    if (defaultValue == nil) {
        defaultValue = @"None";
        [XTRPropertiesStore storeViewTitle: defaultValue];
    }
    return defaultValue;
}

+ (void)storeViewTitle: (NSString *) aValue {
    if (aValue != nil) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setValue: aValue forKey: VIEW_TITLE_KEY];
        [defaults synchronize];
    }
}

+ (BOOL)retreiveSplashScreenState {
    return [[NSUserDefaults standardUserDefaults] boolForKey: SPLASH_SCREEN_DEFAULT];
}

+ (void)storeSplashScreenState: (BOOL) aValue {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool: aValue forKey: SPLASH_SCREEN_DEFAULT];
    [defaults synchronize];
}

+ (BOOL)retreiveShowTransitionsState {
    return [[NSUserDefaults standardUserDefaults] boolForKey: SHOW_TRANSITIONS_DEFAULT];
}

+ (void)storeShowTranitionsState: (BOOL) aValue {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool: aValue forKey: SHOW_TRANSITIONS_DEFAULT];
    [defaults synchronize];
}

+ (BOOL)retreiveElementBubblesState {
    return [[NSUserDefaults standardUserDefaults] boolForKey: ELEMENT_BUBBLE_DEFAULT];
}

+ (void)storeElementBubblesState: (BOOL) aValue {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool: aValue forKey: ELEMENT_BUBBLE_DEFAULT];
    [defaults synchronize];
}

+ (NSData *)retreiveColorDataForColorKey: (NSString *)aColorKey {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults objectForKey: aColorKey];
}

+(void)storeColorData: (NSData *)colorData forColorKey: (NSString *)aColorKey {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    [userDefaults setObject: colorData forKey: aColorKey];
    [userDefaults synchronize];
}

+ (void)resetPreferences {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    [userDefaults removeObjectForKey: ELEMENT_BUBBLE_DEFAULT];
    [userDefaults removeObjectForKey: SERIES_ACTINIDE];
    [userDefaults removeObjectForKey: SERIES_ALKALI_EARTH_METAL];
    [userDefaults removeObjectForKey: SERIES_ALKALI_METAL];
    [userDefaults removeObjectForKey: SERIES_HALOGEN];
    [userDefaults removeObjectForKey: SERIES_LANTHANIDE];
    [userDefaults removeObjectForKey: SERIES_METAL];
    [userDefaults removeObjectForKey: SERIES_NOBLE_GAS];
    [userDefaults removeObjectForKey: SERIES_NON_METAL];
    [userDefaults removeObjectForKey: SERIES_TRANSACTINIDES];
    [userDefaults removeObjectForKey: SERIES_TRANSITION_METAL];
    [userDefaults synchronize];
}

@end
