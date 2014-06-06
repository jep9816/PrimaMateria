//
//  PropertiesStore.h
//  Visualizer
//
//  Created by Jerry Porter on 05/18/2011.
//  Modified by $Id: PropertiesStore.h 1464 2011-05-24 21:15:30Z delaware\portej1 $
//  Copyright Lincoln National Corporation 2011. All rights reserved.
//

@interface XTRPropertiesStore : NSObject

+ (NSNumber *)retreiveAtomicNumber;
+ (void)storeAtomicNumber : (NSNumber *)aValue;

+ (NSString *)retreiveViewTitle;
+ (void)storeViewTitle : (NSString *)aValue;

@end
