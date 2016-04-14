//
//  XTRElementTableViewCell.h
//  PrimaMateria
//
//  Created by Jerry Porter on 4/8/16.
//  Copyright © 2016 xTrensa. All rights reserved.
//

@interface XTRElementTableViewCell : UITableViewCell

@property (strong, nonatomic) DynoTableLabel *atomicNumberLabel;
@property (strong, nonatomic) DynoTableLabel *symbolLabel;
@property (strong, nonatomic) DynoTableLabel *nameLabel;
@property (strong, nonatomic) DynoTableLabel *atomicMassLabel;
@property (strong, nonatomic) DynoTableLabel *boilingPointLabel;
@property (strong, nonatomic) DynoTableLabel *meltingPointLabel;
@property (strong, nonatomic) DynoTableLabel *densityLabel;
@property (strong, nonatomic) DynoTableLabel *seriesLabel;
@property (strong, nonatomic) DynoTableLabel *periodLabel;
@property (strong, nonatomic) DynoTableLabel *groupLabel;
@property (strong, nonatomic) XTRElement *element;

- (instancetype)initWithStyle: (UITableViewCellStyle)style reuseIdentifier: (NSString *)reuseIdentifier andElement: (XTRElement *)anElement;

- (void)modifyCellProperties;

@end
