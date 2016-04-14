//
//  XTRElementTableViewCell.m
//  PrimaMateria
//
//  Created by Jerry Porter on 4/8/16.
//  Copyright © 2016 xTrensa. All rights reserved.
//

@interface XTRElementTableViewCell()

-(void)colorChanged: (NSNotification *)aNotification;

@end

@implementation XTRElementTableViewCell

-(void)colorChanged: (NSNotification *)aNotification {
    [self setupColors];
    [self setNeedsDisplay];
}

- (void)setupColors {
    UIColor *aSeriesColor = self.element.seriesColor;
    self.atomicNumberLabel.backgroundColor = aSeriesColor;
    self.symbolLabel.backgroundColor = aSeriesColor;
    self.nameLabel.backgroundColor = aSeriesColor;
    self.atomicMassLabel.backgroundColor = aSeriesColor;
    self.boilingPointLabel.backgroundColor = aSeriesColor;
    self.meltingPointLabel.backgroundColor = aSeriesColor;
    self.densityLabel.backgroundColor = aSeriesColor;
    self.seriesLabel.backgroundColor = aSeriesColor;
    self.periodLabel.backgroundColor = aSeriesColor;
    self.groupLabel.backgroundColor = aSeriesColor;
}

- (instancetype)initWithStyle: (UITableViewCellStyle)style reuseIdentifier: (NSString *)reuseIdentifier andElement: (XTRElement *) anElement {
    if (self = [super initWithStyle:(UITableViewCellStyle) style reuseIdentifier:reuseIdentifier]) {
        self.element = anElement;
        self.backgroundColor = UIColor.blackColor;
        self.contentView.backgroundColor = UIColor.darkGrayColor;

        self.atomicNumberLabel = [[DynoTableLabel alloc] initWithFrame: CGRectMake(0, 0, 85, 42) andColor: self.element.seriesColor];
        [self.contentView addSubview: self.atomicNumberLabel];

        self.symbolLabel = [[DynoTableLabel alloc] initWithFrame: CGRectMake(86, 0, 95, 42) andColor: self.element.seriesColor];
        [self.contentView addSubview: self.symbolLabel];

        self.nameLabel = [[DynoTableLabel alloc] initWithFrame: CGRectMake(182, 0, 125, 42) andColor: self.element.seriesColor];
        [self.contentView addSubview: self.nameLabel];

        self.atomicMassLabel = [[DynoTableLabel alloc] initWithFrame: CGRectMake(308, 0, 95, 42) andColor: self.element.seriesColor];
        [self.contentView addSubview: self.atomicMassLabel];

        self.boilingPointLabel = [[DynoTableLabel alloc] initWithFrame: CGRectMake(404, 0, 105, 42) andColor: self.element.seriesColor];
        [self.contentView addSubview: self.boilingPointLabel];

        self.meltingPointLabel = [[DynoTableLabel alloc] initWithFrame: CGRectMake(510, 0, 105, 42) andColor: self.element.seriesColor];
        [self.contentView addSubview: self.meltingPointLabel];

        self.densityLabel = [[DynoTableLabel alloc] initWithFrame: CGRectMake(616, 0, 105, 42) andColor: self.element.seriesColor];
        [self.contentView addSubview: self.densityLabel];

        self.seriesLabel = [[DynoTableLabel alloc] initWithFrame: CGRectMake(722, 0, 160, 42) andColor: self.element.seriesColor];
        [self.contentView addSubview: self.seriesLabel];

        self.periodLabel = [[DynoTableLabel alloc] initWithFrame: CGRectMake(883, 0, 72, 42) andColor: self.element.seriesColor];
        [self.contentView addSubview: self.periodLabel];

        self.groupLabel = [[DynoTableLabel alloc] initWithFrame: CGRectMake(956, 0, 68, 42) andColor: self.element.seriesColor];
        [self.contentView addSubview: self.groupLabel];
        
        [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(colorChanged:) name: NOTIFICATION_SERIES_COLOR_CHANGED object: nil];
    }
    return self;
}

- (void)modifyLabel: (DynoTableLabel *)aLabel withStandardConditionColor: (UIColor *)aStandardConditionColor seriesColor: (UIColor *)aSeriesColor {
    aLabel.font = [UIFont systemFontOfSize: 16.0];
    aLabel.textColor = aStandardConditionColor;
    aLabel.backgroundColor = aSeriesColor;
    aLabel.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleHeight;
}

- (void)modifyCellProperties {
    UIColor *seriesColor = self.element.seriesColor;
    UIColor *selectedColor = [UIColor reverseColorOf: seriesColor];
    self.selectedBackgroundView = [[UIImageView alloc] initWithImage: [UIImage imageWithColor: selectedColor size:self.frame.size]];

    [self modifyLabel: self.atomicNumberLabel withStandardConditionColor: self.element.standardConditionColor seriesColor: self.element.seriesColor];
    self.atomicNumberLabel.text = [NSString stringWithFormat: @"%@", self.element.atomicNumber];
    self.atomicNumberLabel.textAlignment = NSTextAlignmentRight;

    [self modifyLabel: self.symbolLabel withStandardConditionColor: self.element.standardConditionColor seriesColor: self.element.seriesColor];
    self.symbolLabel.font = [UIFont systemFontOfSize:26.0];
    self.symbolLabel.text = [NSString stringWithFormat: @"%@", self.element.symbol];
    self.symbolLabel.textAlignment = NSTextAlignmentCenter;

    [self modifyLabel: self.nameLabel withStandardConditionColor: self.element.standardConditionColor seriesColor: self.element.seriesColor];
    self.nameLabel.text = [NSString stringWithFormat: @"%@", self.element.name];
    self.nameLabel.textAlignment = NSTextAlignmentLeft;

    [self modifyLabel: self.atomicMassLabel withStandardConditionColor: self.element.standardConditionColor seriesColor: self.element.seriesColor];
    self.atomicMassLabel.text = [NSString stringWithFormat: @"%@", self.element.atomicMass];
    self.atomicMassLabel.textAlignment = NSTextAlignmentRight;

    [self modifyLabel: self.boilingPointLabel withStandardConditionColor: self.element.standardConditionColor seriesColor: self.element.seriesColor];
    self.boilingPointLabel.text = [NSString stringWithFormat: @"%@", self.element.boilingPoint];
    self.boilingPointLabel.textAlignment = NSTextAlignmentRight;

    [self modifyLabel: self.meltingPointLabel withStandardConditionColor: self.element.standardConditionColor seriesColor: self.element.seriesColor];
    self.meltingPointLabel.text = [NSString stringWithFormat: @"%@", self.element.meltingPoint];
    self.meltingPointLabel.textAlignment = NSTextAlignmentRight;

    [self modifyLabel: self.densityLabel withStandardConditionColor: self.element.standardConditionColor seriesColor: self.element.seriesColor];
    self.densityLabel.text = [NSString stringWithFormat: @"%@", self.element.density];

    [self modifyLabel: self.seriesLabel withStandardConditionColor: self.element.standardConditionColor seriesColor: self.element.seriesColor];
    self.seriesLabel.text = [NSString stringWithFormat: @"%@", self.element.series];
    self.seriesLabel.textAlignment = NSTextAlignmentLeft;

    [self modifyLabel: self.periodLabel withStandardConditionColor: self.element.standardConditionColor seriesColor: self.element.seriesColor];
    self.periodLabel.text = [NSString stringWithFormat: @"%@", self.element.period];
    self.periodLabel.textAlignment = NSTextAlignmentRight;

    [self modifyLabel: self.groupLabel withStandardConditionColor: self.element.standardConditionColor seriesColor: self.element.seriesColor];
    self.groupLabel.text = [NSString stringWithFormat: @"%@", self.element.group];
    self.groupLabel.textAlignment = NSTextAlignmentRight;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver: self name: NOTIFICATION_SERIES_COLOR_CHANGED object: nil];
}

@end
