//
//  SpectrumViewController.h
//  PrimaMateria
//
//  Created by Jerry Porter on 11/21/11.
//  Copyright 2016 xTrensa. All rights reserved.
//

@class XTRSwapableViewController;

@interface XTRSpectrumViewController : XTRSwapableViewController <UITableViewDelegate, UITableViewDataSource, CPTPlotDataSource>

@property (nonatomic, strong) CPTXYGraph *barChart;
@property (nonatomic, strong) IBOutlet CPTGraphHostingView *hostingView;
@property (nonatomic, strong) IBOutlet UIView *swapView;
@property (nonatomic, strong) NSArray *lineSpectraArray;
@property (nonatomic, strong) UITableView *tableView;

- (void)setupUI;

@end
