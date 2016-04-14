//
//  XTRElementBalloonViewController.m
//  PrimaMateria
//
//  Created by Jerry Porter on 11/21/11.
//  Copyright (c) 2016 xTrensa. All rights reserved.
//

@interface XTRElementBalloonViewController ()
- (void)setupUI;
@end

@implementation XTRElementBalloonViewController

#pragma mark Private Methods

- (void)setupUI {
    NSNumber *atomicNumber = [XTRPropertiesStore retreiveAtomicNumber];
    XTRElement *element = [[XTRDataSource sharedInstance] elementAtIndex:atomicNumber.intValue];
    if (element != nil) {
        self.elementNameLabel.text = [NSString stringWithFormat: @" %@",element.name];
        self.elementNameLabel.textColor = element.standardConditionColor;
        self.elementNameLabel.backgroundColor = element.seriesColor;
        self.atomicNumberLabel.text = [NSString stringWithFormat: @" %@",element.atomicNumber.stringValue];
        self.atomicMassLabel.text = [NSString stringWithFormat: @" %@",element.atomicMassAggregate];
        self.boilingPointLabel.text = [NSString stringWithFormat: @" %@",element.boilingPointString];
        self.meltingPointLabel.text = [NSString stringWithFormat: @" %@",element.meltingPointString];
    }
}

#pragma mark - Action Methods

- (IBAction)showDetails: (id) sender {
    [XTRPropertiesStore storeViewTitle: PERIODIC_VIEW_TITLE];
    [XTRPropertiesStore storeAtomicNumber:[XTRPropertiesStore retreiveAtomicNumber]];
    [self performSegueWithIdentifier: SHOW_INSPECTOR_FROM_ELEMENT_BALLOON sender: self];
}

#pragma mark - View Management Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    self.wrapperView.layer.cornerRadius = 10.0f;
    self.wrapperView.clipsToBounds = YES;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    [self setupUI];
}

- (BOOL) shouldAutorotateToInterfaceOrientation: (UIInterfaceOrientation) interfaceOrientation {
    return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

#pragma mark - Memory Management Methods

- (void)dealloc {
    self.elementNameLabel = nil;
    self.atomicNumberLabel = nil;
    self.atomicMassLabel = nil;
    self.boilingPointLabel = nil;
    self.meltingPointLabel = nil;
    self.wrapperView = nil;
}

@end
