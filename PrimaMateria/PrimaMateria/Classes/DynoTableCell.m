//
// DynoTableCell.m
// PrimaMateria
//
//  Created by Jerry Porter on 1/5/2011.
//  Copyright 2014 xTrensa. All rights reserved.
//

#import "PrimaMateria.h"

typedef enum LabelTypes {
    kAtomicNumber  = 1,
    kSymbol = 2
}
LabelTypes;

@implementation DynoTableCell

- (id) initWithStyle: (UITableViewCellStyle) style reuseIdentifier: (NSString *) reuseIdentifier {
    if (self = [super initWithStyle: (UITableViewCellStyle) style reuseIdentifier: (NSString *)reuseIdentifier]) {
        columns = [NSMutableArray arrayWithCapacity: 5];
    }
    return self;
}

- (void) addColumn: (CGFloat) position {
    [columns addObject:@(position)];
}

- (void) drawRect: (CGRect) rect {
    [super drawRect: rect];
    self.backgroundColor = UIColor.blackColor;
    CGContextRef ctx = UIGraphicsGetCurrentContext();

    // just match the color and size of the horizontal line
    CGContextSetRGBStrokeColor(ctx, 0.5, 0.5, 0.5, 1.0);
    CGContextSetLineWidth(ctx, 0.25);

    for (NSInteger i = 0; i <[columns count]; i++) {
        // get the position for the vertical line
        CGFloat f = [( (NSNumber *)columns[i] )floatValue];
        CGContextMoveToPoint(ctx, f, 0);
        CGContextAddLineToPoint(ctx, f, self.bounds.size.height);
    }
    CGContextStrokePath(ctx);
}

#pragma mark - Memory Management Methods

@end
