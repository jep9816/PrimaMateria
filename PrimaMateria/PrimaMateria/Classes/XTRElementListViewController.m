//
//  XTRSecondViewController.m
//  PrimaMateria
//
//  Created by Jerry Porter on 11/21/11.
//  Copyright 2016 xTrensa. All rights reserved.
//

#import "PrimaMateria.h"

@interface XTRElementListViewController ()
- (DynoTableLabel *) tableCellLabelWithXPos: (float) xPos YPos: (float) yPos width: (float) aWidth height: (float) aHeight andElement: (XTRElement *) anElement;
- (void) addPropertiesToAtomicNumberCell: (DynoTableCell *) cell forTableView: (UITableView *) aTableView andElement: (XTRElement *) element;
- (void) addPropertiesToAtomicWeightCell: (DynoTableCell *) cell forTableView: (UITableView *) aTableView andElement:(XTRElement *) element;
- (void) addPropertiesToBoilingPointCell: (DynoTableCell *) cell forTableView: (UITableView *) aTableView andElement: (XTRElement *) element;
- (void) addPropertiesToDensityCell: (DynoTableCell *) cell forTableView: (UITableView *) aTableView andElement: (XTRElement *) element;
- (void) addPropertiesToGroupCell: (DynoTableCell *) cell forTableView: (UITableView *) aTableView andElement: (XTRElement *) element;
- (void) addPropertiesToMeltingPointCell: (DynoTableCell *) cell forTableView: (UITableView *) aTableView andElement: (XTRElement *) element;
- (void) addPropertiesToNameCell: (DynoTableCell *) cell forTableView: (UITableView *) aTableView andElement: (XTRElement *) element;
- (void) addPropertiesToPeriodCell: (DynoTableCell *) cell forTableView: (UITableView *) aTableView andElement: (XTRElement *) element;
- (void) addPropertiesToSeriesCell: (DynoTableCell *) cell forTableView: (UITableView *) aTableView andElement: (XTRElement *) element;
- (void) addPropertiesToSymbolCell: (DynoTableCell *) cell forTableView: (UITableView *) aTableView andElement: (XTRElement *) element;
- (void) setupTableView;
- (void) showElementPanelForElementAtIndex: (int) anIndex;
@end

@implementation XTRElementListViewController

#pragma mark Private Methods

- (void) showElementPanelForElementAtIndex: (int) anIndex {
    [XTRPropertiesStore storeViewTitle: self.title];
    [XTRPropertiesStore storeAtomicNumber:@(anIndex)];
    [self performSegueWithIdentifier: SHOW_INSPECTOR_FROM_ELEMENT_LIST sender: self];
}

- (DynoTableLabel *) tableCellLabelWithXPos: (float) xPos YPos: (float) yPos width: (float) aWidth height: (float) aHeight andElement: (XTRElement *) anElement {
    DynoTableLabel *label = [[DynoTableLabel alloc] initWithFrame: CGRectMake(xPos, yPos, aWidth, aHeight) andColor:anElement.seriesColor];
    label.font = [UIFont systemFontOfSize:16.0];
    label.textColor = anElement.standardConditionColor;
    label.backgroundColor = anElement.seriesColor;
    label.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleHeight;
    return label;
}

- (void) addPropertiesToAtomicNumberCell: (DynoTableCell *) cell forTableView: (UITableView *) aTableView andElement: (XTRElement *) element {
    DynoTableLabel *label = [self tableCellLabelWithXPos: 0.0 YPos: 0.0 width: 85.0 height: 42.0f andElement: element];
    [cell addColumn: 1];
    label.textAlignment = NSTextAlignmentRight;
    label.text = [NSString stringWithFormat: @"%@", element.atomicNumber];
    [cell.contentView addSubview: label];
}

- (void) addPropertiesToSymbolCell: (DynoTableCell *) cell forTableView: (UITableView *) aTableView andElement: (XTRElement *) element {
    DynoTableLabel *label = [[DynoTableLabel alloc] initWithFrame: CGRectMake(86.0, 0.0, 95.0, 42.0f) andColor:element.seriesColor];
    label.font = [UIFont systemFontOfSize:26.0];
    label.textColor = element.standardConditionColor;
    label.backgroundColor = element.seriesColor;
    label.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleHeight;
    [cell addColumn: 2];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = [NSString stringWithFormat: @"%@", element.symbol];
    [cell.contentView addSubview: label];
}

- (void) addPropertiesToNameCell: (DynoTableCell *) cell forTableView: (UITableView *) aTableView andElement: (XTRElement *) element {
    DynoTableLabel *label = [self tableCellLabelWithXPos: 182.0 YPos: 0.0 width: 125.0 height: 42.0f andElement: element];
    [cell addColumn: 3];
    label.textAlignment = NSTextAlignmentLeft;
    label.text = [NSString stringWithFormat: @"%@", element.name];
    [cell.contentView addSubview: label];
}

- (void) addPropertiesToAtomicWeightCell: (DynoTableCell *) cell forTableView: (UITableView *) aTableView andElement: (XTRElement *) element {
    DynoTableLabel *label = [self tableCellLabelWithXPos: 308.0 YPos: 0.0 width: 95.0 height: 42.0f andElement: element];
    [cell addColumn: 4];
    label.textAlignment = NSTextAlignmentRight;
    label.text = [NSString stringWithFormat: @"%@", element.atomicMass];
    [cell.contentView addSubview: label];
}

- (void) addPropertiesToBoilingPointCell: (DynoTableCell *) cell forTableView: (UITableView *) aTableView andElement: (XTRElement *) element {
    DynoTableLabel *label = [self tableCellLabelWithXPos: 404.0 YPos: 0.0 width: 105.0 height: 42.0f andElement: element];
    [cell addColumn: 5];
    label.textAlignment = NSTextAlignmentRight;
    label.text = [NSString stringWithFormat: @"%@", element.boilingPoint];
    [cell.contentView addSubview: label];
}

- (void) addPropertiesToMeltingPointCell: (DynoTableCell *) cell forTableView: (UITableView *) aTableView andElement: (XTRElement *) element {
    DynoTableLabel *label = [self tableCellLabelWithXPos: 510.0 YPos: 0.0 width: 105.0 height: 42.0f andElement: element];
    [cell addColumn: 6];
    label.textAlignment = NSTextAlignmentRight;
    label.text = [NSString stringWithFormat: @"%@", element.meltingPoint];
    [cell.contentView addSubview: label];
}

- (void) addPropertiesToDensityCell: (DynoTableCell *) cell forTableView: (UITableView *) aTableView andElement: (XTRElement *) element {
    DynoTableLabel *label = [self tableCellLabelWithXPos: 616.0 YPos: 0.0 width: 105.0 height: 42.0f andElement: element];
    [cell addColumn: 7];
    label.textAlignment = NSTextAlignmentRight;
    label.text = [NSString stringWithFormat: @"%@", element.density];
    [cell.contentView addSubview: label];
}

- (void) addPropertiesToSeriesCell: (DynoTableCell *) cell forTableView: (UITableView *) aTableView andElement: (XTRElement *) element {
    DynoTableLabel *label = [self tableCellLabelWithXPos: 722.0 YPos: 0.0 width: 160.0 height: 42.0f andElement: element];
    [cell addColumn: 8];
    label.textAlignment = NSTextAlignmentLeft;
    label.text = [NSString stringWithFormat: @"%@", element.series];
    [cell.contentView addSubview: label];
}

- (void) addPropertiesToPeriodCell: (DynoTableCell *) cell forTableView: (UITableView *) aTableView andElement: (XTRElement *) element {
    DynoTableLabel *label = [self tableCellLabelWithXPos: 883.0 YPos: 0.0 width: 72.0 height: 42.0f andElement: element];
    [cell addColumn: 10];
    label.textAlignment = NSTextAlignmentRight;
    label.text = [NSString stringWithFormat: @"%@", element.period];
    [cell.contentView addSubview: label];
}

- (void) addPropertiesToGroupCell: (DynoTableCell *) cell forTableView: (UITableView *) aTableView andElement: (XTRElement *) element {
    DynoTableLabel *label = [self tableCellLabelWithXPos: 956.0 YPos: 0.0 width: 68.0 height: 42.0f andElement: element];
    [cell addColumn: 9];
    label.textAlignment = NSTextAlignmentRight;
    label.text = [NSString stringWithFormat: @"%@", element.group];
    [cell.contentView addSubview: label];
}

- (void) setupTableView {
    self.tableView = [[UITableView alloc] initWithFrame:self.swapView.frame style: UITableViewStylePlain];
    self.tableView.alwaysBounceVertical = NO;
    self.tableView.alwaysBounceHorizontal = NO;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = UIColor.blackColor;
    self.tableView.rowHeight = 34.0f;
    [self.view addSubview: self.tableView];
}

#pragma mark - Action Methods

- (IBAction) sortTableView: (id) sender {
    BOOL toggleState = [sender toggleState];
	if (self.tableView != nil) {
		[self.tableView removeFromSuperview];
		self.tableView = nil;
	}
	[[XTRDataSource sharedInstance] sortByColumnPosition:[sender tag] andOrdering: toggleState];
	[self setupTableView];
	[self.tableView reloadData];
}

#pragma mark - UITableView DataSource Methods

- (UITableViewCell *) tableView: (UITableView *) aTableView cellForRowAtIndexPath: (NSIndexPath *) indexPath {
    NSInteger row = indexPath.row;
    NSString *MyIdentifier = [NSString stringWithFormat: @"Column %i", row];
    XTRElement *element = [[XTRDataSource sharedInstance] sortedElementAtIndex: row];
    DynoTableCell *cell = (DynoTableCell *)[aTableView dequeueReusableCellWithIdentifier: MyIdentifier];
    if (cell == nil) {
        cell = [[DynoTableCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier: MyIdentifier];
        [self addPropertiesToAtomicNumberCell: cell forTableView: aTableView andElement: element];
        [self addPropertiesToSymbolCell: cell forTableView: aTableView andElement: element];
        [self addPropertiesToNameCell: cell forTableView: aTableView andElement: element];
        [self addPropertiesToAtomicWeightCell: cell forTableView: aTableView andElement: element];
        [self addPropertiesToBoilingPointCell: cell forTableView: aTableView andElement: element];
        [self addPropertiesToMeltingPointCell: cell forTableView: aTableView andElement: element];
        [self addPropertiesToDensityCell: cell forTableView: aTableView andElement: element];
        [self addPropertiesToSeriesCell: cell forTableView: aTableView andElement: element];
        [self addPropertiesToPeriodCell: cell forTableView: aTableView andElement: element];
        [self addPropertiesToGroupCell: cell forTableView: aTableView andElement: element];
    }
    return cell;
}

- (NSInteger) numberOfSectionsInTableView: (UITableView *) aTableView {
    return 1;
}

- (NSInteger) tableView: (UITableView *) aTableView numberOfRowsInSection: (NSInteger) section {
    return [XTRDataSource sharedInstance].sortedElementList.count;
}

#pragma mark - UITableView Delegate Methods

- (void) tableView: (UITableView *) tableView didSelectRowAtIndexPath: (NSIndexPath *) indexPath {
    XTRElement *element = [[XTRDataSource sharedInstance] sortedElementAtIndex: indexPath.row];
    [self showElementPanelForElementAtIndex:(element.atomicNumber.intValue - 1)];
}

#pragma mark - View Management Methods

- (BOOL) shouldAutorotateToInterfaceOrientation: (UIInterfaceOrientation) interfaceOrientation {
    return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

- (void) viewDidLoad {
    [super viewDidLoad];
    [self.atomicNumberButton toggleState];
    self.title = @"Element List";
    [self.swapView removeFromSuperview];
    [self setupTableView];
}

#pragma mark - Memory Management Methods

- (void) dealloc {
    self.tableView.delegate = nil;
    self.tableView = nil;
    self.atomicNumberButton = nil;
    self.swapView = nil;
}

@end
