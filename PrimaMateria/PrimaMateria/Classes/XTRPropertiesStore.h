//
//  PropertiesStore.h
//  Visualizer
//
//  Created by Jerry Porter on 05/18/2011.
//  Copyright (c) 2016 xTrensa. All rights reserved.
//

@interface XTRPropertiesStore : NSObject

+ (NSNumber *)retreiveAtomicNumber;
+ (void)storeAtomicNumber : (NSNumber *)aValue;

+ (NSString *)retreiveViewTitle;
+ (void)storeViewTitle : (NSString *)aValue;

+ (BOOL)retreiveSplashScreenState;
+ (void)storeSplashScreenState: (BOOL) aValue;

+ (BOOL)retreiveShowTransitionsState;
+ (void)storeShowTranitionsState: (BOOL) aValue;

+ (BOOL)retreiveElementBubblesState;
+ (void)storeElementBubblesState: (BOOL) aValue;

+ (NSData *)retreiveColorDataForColorKey: (NSString *)aColorKey;
+ (void)storeColorData: (NSData *)colorData forColorKey: (NSString *)aColorKey;

+ (void)resetPreferences;

@end
