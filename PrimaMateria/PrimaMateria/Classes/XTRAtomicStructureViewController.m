//
//  XTRAtomicStructureViewController.m
//  PrimaMateria
//
//  Created by Jerry Porter on 11/21/11.
//  Copyright 2016 xTrensa. All rights reserved.
//

#import "PrimaMateria.h"

typedef enum ViewTypes {
    kCrystalStructureView = 0,
    kShellModelView = 1
}
SwapViews;

@implementation XTRAtomicStructureViewController
@synthesize crystalStructureView, shellModelView, atomicRadiusLabel, atomicVolumeLabel;
@synthesize covalentRadiusLabel, crossSectionLabel, ionicRadiusLabel, oxidationStatesLabel;
@synthesize numberOfNeutronsLabel, numberOfProtonsLabel, numberOfElectronsLabel;
@synthesize valenceLabel, fillingOrbitalLabel, kShellElectronsLabel;
@synthesize lShellElectronsLabel, mShellElectronsLabel, nShellElectronsLabel;
@synthesize oShellElectronsLabel, pShellElectronsLabel, qShellElectronsLabel;
@synthesize shell1sLabel, shell2sLabel, shell2pLabel, shell3sLabel;
@synthesize shell3pLabel, shell3dLabel, shell4sLabel, shell4pLabel;
@synthesize shell4dLabel, shell4fLabel, shell5sLabel, shell5pLabel;
@synthesize shell5dLabel, shell5fLabel, shell6sLabel, shell6pLabel;
@synthesize shell6dLabel, shell7sLabel, shell7pLabel;
@synthesize shellModelInfoLabel;
@synthesize overlayView;

#pragma mark Misc Methods

- (void) setupUI {
    if (self.element != nil) {
        crystalStructureView.image = self.element.crystalStructureImage;
        shellModelView.image = self.element.shellModelImage;

        atomicRadiusLabel.text = [NSString stringWithFormat: @"%@", self.element.atomicRadius];
        atomicVolumeLabel.text = [NSString stringWithFormat: @"%@", self.element.atomicVolume];
        covalentRadiusLabel.text = [NSString stringWithFormat: @"%@", self.element.covalentRadius];
        crossSectionLabel.text = [NSString stringWithFormat: @"%@", [self.element valueForKey: ELEMENT_COVALENT_RADIUS]];
        ionicRadiusLabel.text = [NSString stringWithFormat: @"%@", [self.element valueForKey: ELEMENT_IONIC_RADIUS]];
        oxidationStatesLabel.text = [NSString stringWithFormat: @"%@", [self.element valueForKey: ELEMENT_OXIDATION_STATES]];
        numberOfElectronsLabel.text = [NSString stringWithFormat: @"%@", [self.element valueForKey: ELEMENT_NUMBER_OF_ELECTRONS]];
        numberOfNeutronsLabel.text = [NSString stringWithFormat: @"%@", [self.element valueForKey: ELEMENT_NUMBER_OF_NEUTRONS]];
        numberOfProtonsLabel.text = [NSString stringWithFormat: @"%@", [self.element valueForKey: ELEMENT_NUMBER_OF_PROTONS]];
        
        shellModelInfoLabel.backgroundColor = self.element.seriesColor;
        shellModelInfoLabel.text = [NSString stringWithFormat: @"%@P\n%@N", numberOfProtonsLabel.text, numberOfNeutronsLabel.text];

        valenceLabel.text = self.element.valence;
        fillingOrbitalLabel.text = self.element.fillingOrbital;

        kShellElectronsLabel.text = self.element.kShellElectrons;
        lShellElectronsLabel.text = self.element.lShellElectrons;
        mShellElectronsLabel.text = self.element.mShellElectrons;
        nShellElectronsLabel.text = self.element.nShellElectrons;
        oShellElectronsLabel.text = self.element.oShellElectrons;
        pShellElectronsLabel.text = self.element.pShellElectrons;
        qShellElectronsLabel.text = self.element.qShellElectrons;

        shell1sLabel.text = self.element.shell1s;

        shell2sLabel.text = self.element.shell2s;
        shell2pLabel.text = self.element.shell2p;

        shell3sLabel.text = self.element.shell3s;
        shell3pLabel.text = self.element.shell3p;
        shell3dLabel.text = self.element.shell3d;

        shell4sLabel.text = self.element.shell4s;
        shell4pLabel.text = self.element.shell4p;
        shell4dLabel.text = self.element.shell4d;
        shell4fLabel.text = self.element.shell4f;

        shell5sLabel.text = self.element.shell5s;
        shell5pLabel.text = self.element.shell5p;
        shell5dLabel.text = self.element.shell5d;
        shell5fLabel.text = self.element.shell5f;

        shell6sLabel.text = self.element.shell6s;
        shell6pLabel.text = self.element.shell6p;
        shell6dLabel.text = self.element.shell6d;

        shell7sLabel.text = self.element.shell7s;
        shell7pLabel.text = self.element.shell7p;
    }
}

#pragma mark - Action Methods

- (IBAction) swapViews: (id) sender {
    switch ([sender selectedSegmentIndex]) {
        case kCrystalStructureView:
            crystalStructureView.hidden = NO;
            shellModelView.hidden = YES;
            shellModelInfoLabel.hidden = YES;
            overlayView.hidden = YES;
            break;

        case kShellModelView:
            crystalStructureView.hidden = YES;
            shellModelView.hidden = NO;
            shellModelInfoLabel.hidden = NO;
            overlayView.hidden = NO;
            break;

        default:
            break;
    }
}

#pragma mark - View Management Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    crystalStructureView.hidden = NO;
    shellModelView.hidden = YES;
    shellModelInfoLabel.layer.cornerRadius = 30.0f;
    shellModelInfoLabel.layer.borderWidth = 1.0f;
    shellModelInfoLabel.hidden = YES;
    overlayView.hidden = YES;
}

- (BOOL) shouldAutorotateToInterfaceOrientation: (UIInterfaceOrientation) interfaceOrientation {
    return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

#pragma mark - Memory Management Methods

- (void) dealloc {
    crystalStructureView = nil;
    shellModelView = nil;
    atomicRadiusLabel = nil;
    atomicVolumeLabel = nil;
    covalentRadiusLabel = nil;
    crossSectionLabel = nil;
    ionicRadiusLabel = nil;
    oxidationStatesLabel = nil;
    numberOfNeutronsLabel = nil;
    numberOfProtonsLabel = nil;
    numberOfElectronsLabel = nil;
    valenceLabel = nil;
    fillingOrbitalLabel = nil;
    kShellElectronsLabel = nil;
    lShellElectronsLabel = nil;
    mShellElectronsLabel = nil;
    nShellElectronsLabel = nil;
    oShellElectronsLabel = nil;
    pShellElectronsLabel = nil;
    qShellElectronsLabel = nil;
    shell1sLabel = nil;
    shell2sLabel = nil;
    shell2pLabel = nil;
    shell3sLabel = nil;
    shell3pLabel = nil;
    shell3dLabel = nil;
    shell4sLabel = nil;
    shell4pLabel = nil;
    shell4dLabel = nil;
    shell4fLabel = nil;
    shell5sLabel = nil;
    shell5pLabel = nil;
    shell5dLabel = nil;
    shell5fLabel = nil;
    shell6sLabel = nil;
    shell6pLabel = nil;
    shell6dLabel = nil;
    shell7sLabel = nil;
    shell7pLabel = nil;
}

@end
