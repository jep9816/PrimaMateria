//
// XTRVersionChecker.m
// PrimaMateria
//
//  Created by Jerry Porter on 3/22/2010.
//  Copyright (c) 2016 xTrensa. All rights reserved.
//

@implementation XTRVersionChecker

#pragma mark - Accessor Methods

+ (NSString *)appNameString {
    return [[NSBundle mainBundle] objectForInfoDictionaryKey: @"CFBundleDisplayName"];
}

+ (NSString *) appVersionString {
    return [[NSBundle mainBundle] objectForInfoDictionaryKey: @"CFBundleShortVersionString"];
}

+ (NSString *) copywriteString {
    return [[NSBundle mainBundle] objectForInfoDictionaryKey: @"CFBundleGetInfoString"];
}

@end
