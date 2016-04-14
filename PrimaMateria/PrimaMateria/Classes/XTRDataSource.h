//
// XTRDataSource.h
// PrimaMateria
//
//  Created by Jerry Porter on 3/22/2010.
//  Copyright 2016 xTrensa. All rights reserved.
//

@interface XTRDataSource : NSObject
@property (strong) NSArray *sortColumns;
@property (strong) NSMutableArray<XTRElement *> *elementList;
@property (strong) NSMutableArray<XTRElement *> *sortedElementList;
@property (strong) NSMutableArray<NSDictionary *> *graphPropertyList;
@property SEL columnSortSelector;
@property (NS_NONATOMIC_IOSONLY, readonly) NSUInteger elementCount;

+ (XTRDataSource *)sharedInstance;

- (XTRElement *)elementAtIndex : (NSUInteger)index;
- (XTRElement *)elementForSymbol : (NSString *)symbol;
- (XTRElement *)sortedElementAtIndex : (NSUInteger)index;

- (void)resetElementList;
- (void)sortByColumnPosition: (int) aColumnPosition andOrdering: (BOOL) anOrderingFlag;

@end
