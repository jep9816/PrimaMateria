//
//  XTRElementInspectorViewController.m
//  PrimaMateria
//
//  Created by Jerry Porter on 11/21/11.
//  Copyright 2016 xTrensa. All rights reserved.
//

#import "PrimaMateria.h"

typedef NS_ENUM(NSInteger, InspectorViewTypes) {
    kAtomicStructureView  = 0,
    kElementPropertiesView = 1,
    kNuclidesIsotopesView = 2,
    kSpectrumView = 3,
    kGeneralInfoView = 4
};

@interface XTRElementInspectorViewController ()
- (void)assignAtomicSymbolTextFieldProperties;
- (void)assignOtherLabels;
- (void)assignNavigationHints;
- (void)setupPageItemView;
- (void)animateForDirection: (NSString *)direction;
@end

@implementation XTRElementInspectorViewController

#pragma mark Private Methods

- (void)assignAtomicSymbolTextFieldProperties {
    self.atomicSymbolLabel.text = self.element.symbol;
    self.atomicSymbolLabel.textColor = self.element.standardConditionColor;
    self.atomicSymbolLabel.backgroundColor = self.element.seriesColor;
}

- (void)assignOtherLabels {    
    self.atomicNumberLabel.text = self.element.atomicNumber.stringValue;
    self.titleItem.title = self.element.nameString;
    self.periodLabel.text = self.element.periodString;
    self.groupLabel.text = self.element.groupString;
    self.seriesLabel.text = self.element.seriesString;
    self.casRegNoLabel.text = self.element.casRegNoString;
}

- (void)assignNavigationHints {
    NSInteger atomicNumber = self.element.atomicNumber.integerValue;
    UILabel *currentLabel = (UILabel *)(self.pageItemView.subviews)[atomicNumber + 1];
    currentLabel.font = [UIFont systemFontOfSize: 12.0];
    currentLabel.textColor = UIColor.whiteColor;
    
    NSInteger nextAtomicNumber = (self.element.atomicNumber).intValue + 1;
    if (nextAtomicNumber >[XTRDataSource sharedInstance].elementCount)
        nextAtomicNumber = 1;
    if(nextAtomicNumber - 1 < [XTRDataSource sharedInstance].elementCount) {
        UILabel *localNextLabel = (UILabel *)(self.pageItemView.subviews)[nextAtomicNumber + 1];
        localNextLabel.font = [UIFont systemFontOfSize:10.0];
        localNextLabel.textColor = UIColor.darkGrayColor;
    }
    
    XTRElement *nextElement = [[XTRDataSource sharedInstance] elementAtIndex:nextAtomicNumber -1];
    NSString *nextTitle = [NSString stringWithFormat: @"%@ ▶︎ ", nextElement.name];
    [self.nextButton setTitle:nextTitle forState: UIControlStateNormal];
    [self.nextButton setTitle:nextTitle forState: UIControlStateHighlighted];
    [self.nextButton setTitle:nextTitle forState: UIControlStateSelected];
    
    self.nextLabel.text = [NSString stringWithFormat: @"Swipe Right for %@ ", nextElement.name];
    
    NSInteger previousAtomicNumber = self.element.atomicNumber.intValue - 1;
    if (previousAtomicNumber < 1)
        previousAtomicNumber = [XTRDataSource sharedInstance].elementCount;
    if(previousAtomicNumber > 0) {
        UILabel *localPreviousLabel = (UILabel *)(self.pageItemView.subviews)[previousAtomicNumber + 1];
        localPreviousLabel.font = [UIFont systemFontOfSize:10.0];
        localPreviousLabel.textColor = UIColor.darkGrayColor;
    }
    
    XTRElement *previousElement = [[XTRDataSource sharedInstance] elementAtIndex:previousAtomicNumber -1];
    NSString *previousTitle = [NSString stringWithFormat: @" ◀︎ %@", previousElement.name];
    [self.previousButton setTitle:previousTitle forState: UIControlStateNormal];
    [self.previousButton setTitle:previousTitle forState: UIControlStateHighlighted];
    [self.previousButton setTitle:previousTitle forState: UIControlStateSelected];
    self.previousLabel.text = [NSString stringWithFormat: @" Swipe Left for %@", previousElement.name];
}

- (void)setupPageItemView {
    CGRect rect = CGRectMake(4, 30, 8, 8);
    for (int i = 0; i < [XTRDataSource sharedInstance].elementCount; i++) {
        UILabel *label = [[UILabel alloc] initWithFrame: rect];
        label.text = @"●";
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:10.0];
        label.textColor = UIColor.darkGrayColor;
        label.backgroundColor = UIColor.clearColor;
        [self.pageItemView addSubview: label];
        rect = CGRectMake(label.frame.origin.x + 8.6, 30, 8, 8);
    }
    [self.view bringSubviewToFront: self.pageItemView];
}

- (void)addChildViewController: (UIViewController *)aViewController {
    [super addChildViewController: aViewController];
    aViewController.view.frame = self.swapView.frame;
    aViewController.view.bounds = self.swapView.bounds;
    aViewController.view.hidden = YES;
    [self.view addSubview: aViewController.view];
}

- (void)animateForDirection: (NSString *)direction {
    [self setupUI];
    BOOL defaultState = [XTRPropertiesStore retreiveShowTransitionsState];
    
    if (defaultState) {
        UIView *currentView = self.view;
        UIView *theWindow = currentView.superview;
        
        [currentView removeFromSuperview];
        
        CATransition *animation = [CATransition animation];
        animation.duration = 1.0;
        animation.type = kCATransitionReveal;
        animation.subtype = [direction isEqualToString: @"Next"] ? kCATransitionFromLeft : kCATransitionFromRight;
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        [theWindow.layer addAnimation:animation forKey: @"SwitchInspectorView"];
        [theWindow addSubview:currentView];
        [theWindow.layer removeAnimationForKey: @"SwitchInspectorView"];
    }
}

#pragma mark - Misc Methods

- (void)setupUI {
    if (self.element != nil) {
        [self assignAtomicSymbolTextFieldProperties];
        [self assignOtherLabels];
        [self assignNavigationHints];
        for (XTRSwapableViewController *controller in self.childViewControllers) {
            controller.element = self.element;
            [controller setupUI];
        }
    }
    [self.view bringSubviewToFront: self.pageItemView];
}

#pragma mark - Action Methods

- (IBAction) dismiss: (id) sender {
    [self dismissViewControllerAnimated: YES completion: nil];
    [[NSNotificationCenter defaultCenter] postNotificationName: NOTIFICATION_INSPECTOR_DISMISSED object: nil];
}

- (IBAction) swapViews: (UISegmentedControl *) sender {
    UIViewController *viewController = (self.childViewControllers)[sender.selectedSegmentIndex];
    for (XTRSwapableViewController *controller in self.childViewControllers)
        controller.view.hidden = YES;
    viewController.view.hidden = NO;
}

- (IBAction) nextElement: (id) sender {
    NSInteger atomicNumber = (self.element.atomicNumber).intValue + 1;
    if (atomicNumber >[XTRDataSource sharedInstance].elementCount)
        atomicNumber = 1;
    self.element = [[XTRDataSource sharedInstance] elementAtIndex:atomicNumber -1];
    [self animateForDirection: @"Next"];    
}

- (IBAction) previousElement: (id) sender {
    NSInteger atomicNumber = (self.element.atomicNumber).intValue - 1;
    if (atomicNumber < 1)
        atomicNumber = [XTRDataSource sharedInstance].elementCount;
    self.element = [[XTRDataSource sharedInstance] elementAtIndex:atomicNumber -1];
    [self animateForDirection: @"Previous"];    
}

#pragma mark - View Management Methods

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    NSNumber *atomicNumber = [XTRPropertiesStore retreiveAtomicNumber];
    self.barButtonItem.title = [NSString stringWithFormat: @"◀︎ %@", [XTRPropertiesStore retreiveViewTitle]];
    self.element = [[XTRDataSource sharedInstance] elementAtIndex:atomicNumber.intValue];
    [self setupUI];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self dismissViewControllerAnimated: YES completion: nil];
    [super viewWillDisappear: animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.nextButton.titleLabel.textAlignment = NSTextAlignmentRight;
    self.previousButton.titleLabel.textAlignment = NSTextAlignmentLeft;
    [self.swapView removeFromSuperview];
    
    UIStoryboard *storyboard = [XTRAppDelegate storyboard];
    [self addChildViewController: [storyboard instantiateViewControllerWithIdentifier: NSStringFromClass([XTRAtomicStructureViewController class])]];
    [self addChildViewController: [storyboard instantiateViewControllerWithIdentifier: NSStringFromClass([XTRElementPropertiesViewController class])]];
    [self addChildViewController: [storyboard instantiateViewControllerWithIdentifier: NSStringFromClass([XTRNuclidesIsotopesViewController class])]];
    [self addChildViewController: [storyboard instantiateViewControllerWithIdentifier: NSStringFromClass([XTRSpectrumViewController class])]];
    [self addChildViewController: [storyboard instantiateViewControllerWithIdentifier: NSStringFromClass([XTRGeneralInfoViewController class])]];
    ((UIViewController *)(self.childViewControllers)[kAtomicStructureView]).view.hidden = NO;
    
    UISwipeGestureRecognizer *swipeNextElement = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(nextElement:)];
    swipeNextElement.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swipeNextElement];
    
    UISwipeGestureRecognizer *swipePreviousElement = [[UISwipeGestureRecognizer alloc] initWithTarget:self  action:@selector(previousElement:)];
    swipePreviousElement.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:swipePreviousElement];
    [self setupPageItemView];
}

- (BOOL) shouldAutorotateToInterfaceOrientation: (UIInterfaceOrientation) interfaceOrientation {
    return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

#pragma mark - Memory Management Methods

- (void)dealloc {
    self.atomicNumberLabel = nil;
    self.atomicSymbolLabel = nil;
    self.barButtonItem = nil;
    self.periodLabel = nil;
    self.groupLabel = nil;
    self.seriesLabel = nil;
    self.casRegNoLabel = nil;
    self.swapView = nil;
    self.nextButton = nil;
    self.previousButton = nil;
    self.nextLabel = nil;
    self.previousLabel = nil;
    self.titleItem = nil;
}

@end
