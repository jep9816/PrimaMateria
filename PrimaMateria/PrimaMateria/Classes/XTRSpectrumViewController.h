//
//  SpectrumViewController.h
//  PrimaMateria
//
//  Created by Jerry Porter on 11/21/11.
//  Copyright 2016 xTrensa. All rights reserved.
//

@interface XTRSpectrumViewController : XTRSwapableViewController <UITableViewDelegate, UITableViewDataSource, CPTPlotDataSource>
@property (nonatomic, strong) IBOutlet CPTGraphHostingView *hostingView;
@property (nonatomic, strong) IBOutlet UIView *swapView;

@property (nonatomic, strong) CPTXYGraph *barChart;
@property (nonatomic, strong) NSArray<NSDictionary *> *lineSpectraArray;
@property (nonatomic, strong) UITableView *tableView;

- (void)setupUI;

@end
