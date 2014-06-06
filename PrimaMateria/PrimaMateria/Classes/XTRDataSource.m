//
// XTRDataSource.m
// PrimaMateria
//
//  Created by Jerry Porter on 3/22/2010.
//  Copyright 2014 xTrensa. All rights reserved.
//

#import "PrimaMateria.h"

static XTRDataSource *sharedInstance = nil;

@interface XTRDataSource ()
@property (strong) NSString *errorString;

- (NSData *) dataForResource: (NSString *) aResourceName type: (NSString *) aType directory: (NSString *) aDirectory;
- (void) loadElementForSymbol: (NSString *) aSymbol;
- (void) loadElementList;
@end

@implementation XTRDataSource

#pragma mark Private Methods

- (NSData *) dataForResource: (NSString *) aResourceName type: (NSString *) aType directory: (NSString *) aDirectory {
    return [NSData dataWithContentsOfFile:[[NSBundle bundleForClass:[self class]] pathForResource: aResourceName ofType: aType inDirectory: aDirectory]];
}

- (void) loadElementForSymbol: (NSString *) aSymbol {
    NSMutableDictionary *tempDict = [NSPropertyListSerialization propertyListFromData:[self dataForResource: aSymbol type: @"plist" directory: SUPPORTING_FILES] mutabilityOption: NSPropertyListMutableContainers format: NULL errorDescription: &_errorString];
    //NSString *tempString = [NSString stringWithFormat: @"Could not read element property list for symbol: %@", aSymbol];
    //NSAssert(nil != tempDict, tempString);
    XTRElement *element = [[XTRElement allocWithZone:nil] init];
    [element setElementDictionary: tempDict];
    [self.elementList addObject: element];
}

- (void) loadElementList {
    NSArray *tempList = [NSPropertyListSerialization propertyListFromData:[self dataForResource: @"ElementList" type: @"plist" directory: SUPPORTING_FILES] mutabilityOption: NSPropertyListMutableContainers format: NULL errorDescription: &_errorString];
    NSAssert(nil != tempList, @"Could not read property list of elements.");
    for (NSString *symbol in tempList)
        [self loadElementForSymbol: symbol];
    [self.sortedElementList addObjectsFromArray: self.elementList];
}

#pragma mark - Shared Instance Methods

+ (XTRDataSource *) sharedInstance {
    if (sharedInstance == nil)
        sharedInstance = [[super allocWithZone: NULL] init];
    return sharedInstance;
}

+ (id) allocWithZone: (NSZone *) zone {
    return [self sharedInstance];
}

- (id) copyWithZone: (NSZone *) zone {
    return self;
}

#pragma mark - Initialization Methods

- (id) init {
    if (self = [super init]) {
        self.elementList = [NSMutableArray array];
        self.sortedElementList = [NSMutableArray array];
        self.sortColumns = @[ @"atomicNumber.intValue", @"symbol", @"name", @"atomicMass.floatValue", @"boilingPoint.floatValue", @"meltingPoint.floatValue", @"density.floatValue", @"series", @"period", @"group"];
        self.graphPropertyList = [NSPropertyListSerialization propertyListFromData:[self dataForResource: @"GraphDefinitions" type: @"plist" directory: SUPPORTING_FILES] mutabilityOption: NSPropertyListMutableContainers format: NULL errorDescription: &_errorString];
        [self loadElementList];
    }
    return self;
}

#pragma mark - General Methods

- (void) sortByColumnPosition: (int) aColumnPosition andOrdering: (BOOL) anOrderingFlag {
    NSString *sortObject = self.sortColumns[aColumnPosition];
    NSSortDescriptor *discripter1;
    if (anOrderingFlag)
        discripter1 = [[NSSortDescriptor alloc] initWithKey: sortObject ascending: YES];
    else
        discripter1 = [[NSSortDescriptor alloc] initWithKey: sortObject ascending: NO];

    if ([sortObject isEqualToString: self.sortColumns[0]]) {
        NSSortDescriptor *discripter2;
        if (anOrderingFlag)
            discripter2 = [[NSSortDescriptor alloc] initWithKey: self.sortColumns[0] ascending: YES];
        else
            discripter2 = [[NSSortDescriptor alloc] initWithKey: self.sortColumns[0] ascending: NO];
        [self.sortedElementList sortUsingDescriptors:@[ discripter2, discripter1]];
    } else
        [self.sortedElementList sortUsingDescriptors:@[ discripter1]];
}

- (void) resetElementList {
    NSString *sortObject = self.sortColumns[0];
    NSSortDescriptor *sortDesc = [[NSSortDescriptor alloc] initWithKey: sortObject ascending: YES];
    [self.sortedElementList sortUsingDescriptors:@[ sortDesc]];
}

#pragma mark - Accessor Methods

- (XTRElement *) elementForSymbol: (NSString *) symbol {
    XTRElement *element;
    for (element in self.elementList) {
        if ([[element symbol] isEqualToString: symbol])
            return element;
    }
    return nil;
}

- (XTRElement *) sortedElementAtIndex: (int) anIndex {
    return self.sortedElementList[anIndex];
}

- (XTRElement *) elementAtIndex: (int) anIndex {
    return self.elementList[anIndex];
}

- (int) elementCount {
    return [self.sortedElementList count];
}

#pragma mark - Memory Management Methods

@end
