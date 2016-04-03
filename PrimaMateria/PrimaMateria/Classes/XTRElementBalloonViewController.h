//
//  ElementBalloonViewController.h
//  PrimaMateria
//
//  Created by Jerry Porter on 11/21/11.
//  Copyright 2016 xTrensa. All rights reserved.
//

@interface XTRElementBalloonViewController : UIViewController

@property (nonatomic, strong) IBOutlet UILabel *elementNameLabel;
@property (nonatomic, strong) IBOutlet UILabel *atomicNumberLabel;
@property (nonatomic, strong) IBOutlet UILabel *atomicMassLabel;
@property (nonatomic, strong) IBOutlet UILabel *boilingPointLabel;
@property (nonatomic, strong) IBOutlet UILabel *meltingPointLabel;
@property (nonatomic, strong) IBOutlet UIView *wrapperView;

- (IBAction) showDetails: (id) sender;

@end
