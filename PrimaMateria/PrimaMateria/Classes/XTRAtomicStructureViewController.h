//
//  AtomicStructureViewController.h
//  PrimaMateria
//
//  Created by Jerry Porter on 11/21/11.
//  Copyright 2016 xTrensa. All rights reserved.
//

@class XTRElement;
@class XTRSwapableViewController;

@interface XTRAtomicStructureViewController : XTRSwapableViewController

@property (nonatomic, strong) IBOutlet UIImageView *crystalStructureView;
@property (nonatomic, strong) IBOutlet UIImageView *shellModelView;

@property (nonatomic, strong) IBOutlet UILabel *atomicRadiusLabel;
@property (nonatomic, strong) IBOutlet UILabel *atomicVolumeLabel;
@property (nonatomic, strong) IBOutlet UILabel *covalentRadiusLabel;
@property (nonatomic, strong) IBOutlet UILabel *crossSectionLabel;
@property (nonatomic, strong) IBOutlet UILabel *ionicRadiusLabel;
@property (nonatomic, strong) IBOutlet UILabel *oxidationStatesLabel;
@property (nonatomic, strong) IBOutlet UILabel *numberOfNeutronsLabel;
@property (nonatomic, strong) IBOutlet UILabel *numberOfProtonsLabel;
@property (nonatomic, strong) IBOutlet UILabel *numberOfElectronsLabel;
@property (nonatomic, strong) IBOutlet UILabel *valenceLabel;
@property (nonatomic, strong) IBOutlet UILabel *fillingOrbitalLabel;

@property (nonatomic, strong) IBOutlet UILabel *kShellElectronsLabel;
@property (nonatomic, strong) IBOutlet UILabel *lShellElectronsLabel;
@property (nonatomic, strong) IBOutlet UILabel *mShellElectronsLabel;
@property (nonatomic, strong) IBOutlet UILabel *nShellElectronsLabel;
@property (nonatomic, strong) IBOutlet UILabel *oShellElectronsLabel;
@property (nonatomic, strong) IBOutlet UILabel *pShellElectronsLabel;
@property (nonatomic, strong) IBOutlet UILabel *qShellElectronsLabel;

@property (nonatomic, strong) IBOutlet UILabel *shell1sLabel;

@property (nonatomic, strong) IBOutlet UILabel *shell2sLabel;
@property (nonatomic, strong) IBOutlet UILabel *shell2pLabel;

@property (nonatomic, strong) IBOutlet UILabel *shell3sLabel;
@property (nonatomic, strong) IBOutlet UILabel *shell3pLabel;
@property (nonatomic, strong) IBOutlet UILabel *shell3dLabel;

@property (nonatomic, strong) IBOutlet UILabel *shell4sLabel;
@property (nonatomic, strong) IBOutlet UILabel *shell4pLabel;
@property (nonatomic, strong) IBOutlet UILabel *shell4dLabel;
@property (nonatomic, strong) IBOutlet UILabel *shell4fLabel;

@property (nonatomic, strong) IBOutlet UILabel *shell5sLabel;
@property (nonatomic, strong) IBOutlet UILabel *shell5pLabel;
@property (nonatomic, strong) IBOutlet UILabel *shell5dLabel;
@property (nonatomic, strong) IBOutlet UILabel *shell5fLabel;

@property (nonatomic, strong) IBOutlet UILabel *shell6sLabel;
@property (nonatomic, strong) IBOutlet UILabel *shell6pLabel;
@property (nonatomic, strong) IBOutlet UILabel *shell6dLabel;

@property (nonatomic, strong) IBOutlet UILabel *shell7sLabel;
@property (nonatomic, strong) IBOutlet UILabel *shell7pLabel;
@property (nonatomic, strong) IBOutlet UILabel *shellModelInfoLabel;
@property (nonatomic, strong) IBOutlet UIView *overlayView;

- (IBAction)swapViews : (id)sender;
- (void) setupUI;

@end
