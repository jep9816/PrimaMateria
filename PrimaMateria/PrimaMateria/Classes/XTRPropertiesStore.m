//
//  XTRPropertiesStore.h
//  PrimaMateria
//
//  Created by Jerry Porter on 1/5/2011.
//  Copyright 2014 xTrensa. All rights reserved.
//

#import "PrimaMateria.h"

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

+ (void) storeAtomicNumber: (NSString *) aValue {
    if (aValue != nil) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setValue: aValue forKey: ELEMENT_ATOMIC_NUMBER];
        [defaults synchronize];
    }
}

+ (NSString *) retreiveViewTitle {
    NSString *defaultValue = [[NSUserDefaults standardUserDefaults] stringForKey: @"viewTitle"];
    if (defaultValue == nil) {
        defaultValue = @"None";
        [XTRPropertiesStore storeViewTitle: defaultValue];
    }
    return defaultValue;
}

+ (void) storeViewTitle: (NSString *) aValue {
    if (aValue != nil) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setValue: aValue forKey: @"viewTitle"];
        [defaults synchronize];
    }
}

@end
