//
// XTRDataSource.m
// PrimaMateria
//
//  Created by Jerry Porter on 3/22/2010.
//  Copyright 2016 xTrensa. All rights reserved.
//

#import "PrimaMateria.h"

//static XTRDataSource *_sharedInstance = nil;

@interface XTRDataSource ()

- (NSData *) dataForResource: (NSString *) aResourceName type: (NSString *) aType directory: (NSString *) aDirectory;
- (void)loadElementForSymbol: (NSString *) aSymbol;
- (void)loadElementList;
@end

@implementation XTRDataSource

#pragma mark Private Methods

- (NSData *) dataForResource: (NSString *) aResourceName type: (NSString *) aType directory: (NSString *) aDirectory {
    return [NSData dataWithContentsOfFile:[[NSBundle bundleForClass:[self class]] pathForResource: aResourceName ofType: aType inDirectory: aDirectory]];
}

- (void)loadElementForSymbol: (NSString *) aSymbol {
    NSError *error;
    
    NSMutableDictionary *tempDict = [NSPropertyListSerialization propertyListWithData:[self dataForResource: aSymbol type: @"plist" directory: SUPPORTING_FILES] options: NSPropertyListMutableContainers format: NULL error: &error];
    XTRElement *element = [[XTRElement allocWithZone:nil] init];
    element.elementDictionary = tempDict;
    [self.elementList addObject: element];
}

- (void)loadElementList {
    NSError *error;

    NSArray *tempList = [NSPropertyListSerialization propertyListWithData:[self dataForResource: @"ElementList" type: @"plist" directory: SUPPORTING_FILES] options: NSPropertyListMutableContainers format: NULL error: &error];
    NSAssert(nil != tempList, @"Could not read property list of elements.");
    for (NSString *symbol in tempList)
        [self loadElementForSymbol: symbol];
    [self.sortedElementList addObjectsFromArray: self.elementList];
}

#pragma mark - Shared Instance Methods

+ (XTRDataSource *)sharedInstance {
    static XTRDataSource *_sharedInstance;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[super allocWithZone: NULL] init];
    });
    
    return _sharedInstance;
}

//+ (XTRDataSource *) sharedInstance {
//    if (sharedInstance == nil)
//        sharedInstance = [[super allocWithZone: NULL] init];
//    return sharedInstance;
//}

+ (id) allocWithZone: (NSZone *) zone {
    return [self sharedInstance];
}

- (id) copyWithZone: (NSZone *) zone {
    return self;
}

#pragma mark - Initialization Methods

- (instancetype) init {
    if (self = [super init]) {
        NSError *error = nil;
        
        self.elementList = [NSMutableArray array];
        self.sortedElementList = [NSMutableArray array];
        self.sortColumns = @[ @"atomicNumber.intValue", @"symbol", @"name", @"atomicMass.floatValue", @"boilingPoint.floatValue", @"meltingPoint.floatValue", @"density.floatValue", @"series", @"period", @"group"];
        self.graphPropertyList = [NSPropertyListSerialization propertyListWithData:[self dataForResource: @"GraphDefinitions" type: @"plist" directory: SUPPORTING_FILES] options: NSPropertyListMutableContainers format: NULL error: &error];
        [self loadElementList];
    }
    return self;
}

#pragma mark - General Methods

- (void)sortByColumnPosition: (int) aColumnPosition andOrdering: (BOOL) anOrderingFlag {
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

- (void)resetElementList {
    NSString *sortObject = self.sortColumns[0];
    NSSortDescriptor *sortDesc = [[NSSortDescriptor alloc] initWithKey: sortObject ascending: YES];
    [self.sortedElementList sortUsingDescriptors:@[ sortDesc]];
}

#pragma mark - Accessor Methods

- (XTRElement *) elementForSymbol: (NSString *) symbol {
    XTRElement *element;
    for (element in self.elementList) {
        if ([element.symbol isEqualToString: symbol])
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
    return (self.sortedElementList).count;
}

#pragma mark - Memory Management Methods

@end
