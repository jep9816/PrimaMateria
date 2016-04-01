//
//  XTRElementListViewController.h
//  PrimaMateria
//
//  Created by Jerry Porter on 11/21/11.
//  Copyright 2016 xTrensa. All rights reserved.
//

@class DynoTableHeaderButton;

@interface XTRElementListViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) IBOutlet DynoTableHeaderButton *atomicNumberButton;
@property (nonatomic, strong) IBOutlet UIView *swapView;

- (IBAction)sortTableView : (id)sender;

@end
