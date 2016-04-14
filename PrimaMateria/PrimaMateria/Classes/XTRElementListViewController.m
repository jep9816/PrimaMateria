//
//  XTRElementListViewController.m
//  PrimaMateria
//
//  Created by Jerry Porter on 11/21/11.
//  Copyright (c) 2016 xTrensa. All rights reserved.
//

@interface XTRElementListViewController () {
    UITableView *tableView;
}
- (void)setupTableView;
- (void)showElementPanelForElementAtIndex: (int) anIndex;
@end

@implementation XTRElementListViewController

#pragma mark Private Methods

- (void)showElementPanelForElementAtIndex: (int) anIndex {
    [XTRPropertiesStore storeViewTitle: self.title];
    [XTRPropertiesStore storeAtomicNumber:@(anIndex)];
    [self performSegueWithIdentifier: SHOW_INSPECTOR_FROM_ELEMENT_LIST sender: self];
}

- (void)setupTableView {
    tableView = [[UITableView alloc] initWithFrame:self.swapView.frame style: UITableViewStylePlain];
    tableView.alwaysBounceVertical = NO;
    tableView.alwaysBounceHorizontal = NO;
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.backgroundColor = UIColor.blackColor;
    [self.view addSubview: tableView];
}

#pragma mark - Action Methods

- (IBAction) sortTableView: (id) sender {
    BOOL toggleState = [sender toggleState];
    
    if (tableView != nil) {
        [tableView removeFromSuperview];
        tableView = nil;
    }
    
    [[XTRDataSource sharedInstance] sortByColumnPosition:[sender tag] andOrdering: toggleState];
    [self setupTableView];
    [tableView reloadData];
}

#pragma mark - UITableView DataSource Methods

- (UITableViewCell *) tableView: (UITableView *) aTableView cellForRowAtIndexPath: (NSIndexPath *) indexPath {
    NSInteger row = indexPath.row;
    XTRElement *element = [[XTRDataSource sharedInstance] sortedElementAtIndex: row];
    XTRElementTableViewCell *cell = [aTableView dequeueReusableCellWithIdentifier: @"XTRElementTableViewCell"];
    
    if (cell == nil) {
        cell = [[XTRElementTableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier: @"XTRElementTableViewCell" andElement: element];
    }
    
    [cell modifyCellProperties];
    
    return cell;
}

- (NSInteger) numberOfSectionsInTableView: (UITableView *) aTableView {
    return 1;
}

- (NSInteger) tableView: (UITableView *) aTableView numberOfRowsInSection: (NSInteger) section {
    return [XTRDataSource sharedInstance].sortedElementList.count;
}

#pragma mark - UITableView Delegate Methods

- (void)tableView: (UITableView *)aTableView didSelectRowAtIndexPath: (NSIndexPath *) indexPath {
    XTRElement *element = [[XTRDataSource sharedInstance] sortedElementAtIndex:(NSUInteger) indexPath.row];
    [aTableView deselectRowAtIndexPath: indexPath animated: YES];
    [self showElementPanelForElementAtIndex: (element.atomicNumber.intValue - 1)];
}

- (CGFloat)tableView:(UITableView *)aTableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 42.0;
}

#pragma mark - View Management Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.atomicNumberButton toggleState];
    [self.swapView removeFromSuperview];
    [self setupTableView];
}

- (BOOL) shouldAutorotateToInterfaceOrientation: (UIInterfaceOrientation) interfaceOrientation {
    return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}


#pragma mark - Memory Management Methods

- (void)dealloc {
    self.atomicNumberButton = nil;
    self.swapView = nil;
}

@end
