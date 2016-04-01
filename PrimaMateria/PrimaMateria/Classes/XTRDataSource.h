//
// XTRDataSource.h
// PrimaMateria
//
//  Created by Jerry Porter on 3/22/2010.
//  Copyright 2016 xTrensa. All rights reserved.
//

@class XTRElement;

@interface XTRDataSource : NSObject

@property (strong) NSArray *sortColumns;
@property (strong) NSMutableArray *elementList;
@property (strong) NSMutableArray *sortedElementList;
@property (strong) NSMutableArray *graphPropertyList;
@property BOOL sortDescending;
@property SEL columnSortSelector;

+ (XTRDataSource *)sharedInstance;
- (XTRElement *)elementAtIndex : (int)index;
- (XTRElement *)elementForSymbol : (NSString *)symbol;
- (XTRElement *)sortedElementAtIndex : (int)index;
@property (NS_NONATOMIC_IOSONLY, readonly) int elementCount;
- (void)resetElementList;
- (void) sortByColumnPosition: (int) aColumnPosition andOrdering: (BOOL) anOrderingFlag;

@end
