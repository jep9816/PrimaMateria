//
// DynoTableCell.h
// PrimaMateria
//
//  Created by Jerry Porter on 1/5/2011.
//  Copyright 2014 xTrensa. All rights reserved.
//

@interface DynoTableCell : UITableViewCell {
	NSMutableArray *columns;
}

-(void)addColumn : (CGFloat)position;

@end
