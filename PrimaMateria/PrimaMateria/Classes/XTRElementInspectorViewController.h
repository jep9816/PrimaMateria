//
//  XTRElementInspectorViewController.h
//  PrimaMateria
//
//  Created by Jerry Porter on 11/21/11.
//  Copyright (c) 2016 xTrensa. All rights reserved.
//

@interface XTRElementInspectorViewController : XTRSwapableViewController
@property (nonatomic, strong) IBOutlet UIBarButtonItem *barButtonItem;
@property (nonatomic, strong) IBOutlet UIButton *nextButton;
@property (nonatomic, strong) IBOutlet UIButton *previousButton;
@property (nonatomic, strong) IBOutlet UILabel *atomicNumberLabel;
@property (nonatomic, strong) IBOutlet UILabel *atomicSymbolLabel;
@property (nonatomic, strong) IBOutlet UILabel *casRegNoLabel;
@property (nonatomic, strong) IBOutlet UILabel *groupLabel;
@property (nonatomic, strong) IBOutlet UILabel *nextLabel;
@property (nonatomic, strong) IBOutlet UILabel *periodLabel;
@property (nonatomic, strong) IBOutlet UILabel *previousLabel;
@property (nonatomic, strong) IBOutlet UILabel *seriesLabel;
@property (nonatomic, strong) IBOutlet UINavigationItem *titleItem;
@property (nonatomic, strong) IBOutlet UIView *pageItemView;
@property (nonatomic, strong) IBOutlet UIView *swapView;

- (IBAction)swapViews : (UISegmentedControl *)sender;
- (IBAction)dismiss : (id)sender;
- (IBAction)nextElement : (id)sender;
- (IBAction)previousElement : (id)sender;

@end
