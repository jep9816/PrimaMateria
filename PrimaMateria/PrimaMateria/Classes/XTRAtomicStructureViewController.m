//
//  XTRAtomicStructureViewController.m
//  PrimaMateria
//
//  Created by Jerry Porter on 11/21/11.
//  Copyright 2016 xTrensa. All rights reserved.
//

typedef NS_ENUM(NSInteger, StructureViewTypes) {
    kCrystalStructureView = 0,
    kShellModelView = 1
};

@implementation XTRAtomicStructureViewController

#pragma mark Misc Methods

- (void)setupUI {
    if (self.element != nil) {
        self.crystalStructureView.image = self.element.crystalStructureImage;
        self.shellModelView.image = self.element.shellModelImage;

        self.atomicRadiusLabel.text = [NSString stringWithFormat: @"%@", self.element.atomicRadius];
        self.atomicVolumeLabel.text = [NSString stringWithFormat: @"%@", self.element.atomicVolume];
        self.covalentRadiusLabel.text = [NSString stringWithFormat: @"%@", self.element.covalentRadius];
        self.crossSectionLabel.text = [NSString stringWithFormat: @"%@", [self.element valueForKey: ELEMENT_COVALENT_RADIUS]];
        self.ionicRadiusLabel.text = [NSString stringWithFormat: @"%@", [self.element valueForKey: ELEMENT_IONIC_RADIUS]];
        self.oxidationStatesLabel.text = [NSString stringWithFormat: @"%@", [self.element valueForKey: ELEMENT_OXIDATION_STATES]];
        self.numberOfElectronsLabel.text = [NSString stringWithFormat: @"%@", [self.element valueForKey: ELEMENT_NUMBER_OF_ELECTRONS]];
        self.numberOfNeutronsLabel.text = [NSString stringWithFormat: @"%@", [self.element valueForKey: ELEMENT_NUMBER_OF_NEUTRONS]];
        self.numberOfProtonsLabel.text = [NSString stringWithFormat: @"%@", [self.element valueForKey: ELEMENT_NUMBER_OF_PROTONS]];
        
        self.shellModelInfoLabel.backgroundColor = self.element.seriesColor;
        self.shellModelInfoLabel.text = [NSString stringWithFormat: @"%@P\n%@N", self.numberOfProtonsLabel.text, self.numberOfNeutronsLabel.text];

        self.valenceLabel.text = self.element.valence;
        self.fillingOrbitalLabel.text = self.element.fillingOrbital;

        self.kShellElectronsLabel.text = self.element.kShellElectrons;
        self.lShellElectronsLabel.text = self.element.lShellElectrons;
        self.mShellElectronsLabel.text = self.element.mShellElectrons;
        self.nShellElectronsLabel.text = self.element.nShellElectrons;
        self.oShellElectronsLabel.text = self.element.oShellElectrons;
        self.pShellElectronsLabel.text = self.element.pShellElectrons;
        self.qShellElectronsLabel.text = self.element.qShellElectrons;

        self.shell1sLabel.text = self.element.shell1s;

        self.shell2sLabel.text = self.element.shell2s;
        self.shell2pLabel.text = self.element.shell2p;

        self.shell3sLabel.text = self.element.shell3s;
        self.shell3pLabel.text = self.element.shell3p;
        self.shell3dLabel.text = self.element.shell3d;

        self.shell4sLabel.text = self.element.shell4s;
        self.shell4pLabel.text = self.element.shell4p;
        self.shell4dLabel.text = self.element.shell4d;
        self.shell4fLabel.text = self.element.shell4f;

        self.shell5sLabel.text = self.element.shell5s;
        self.shell5pLabel.text = self.element.shell5p;
        self.shell5dLabel.text = self.element.shell5d;
        self.shell5fLabel.text = self.element.shell5f;

        self.shell6sLabel.text = self.element.shell6s;
        self.shell6pLabel.text = self.element.shell6p;
        self.shell6dLabel.text = self.element.shell6d;

        self.shell7sLabel.text = self.element.shell7s;
        self.shell7pLabel.text = self.element.shell7p;
    }
}

#pragma mark - Action Methods

- (IBAction) swapViews: (id) sender {
    switch ([sender selectedSegmentIndex]) {
        case kCrystalStructureView:
            self.crystalStructureView.hidden = NO;
            self.shellModelView.hidden = YES;
            self.shellModelInfoLabel.hidden = YES;
            self.overlayView.hidden = YES;
            break;

        case kShellModelView:
            self.crystalStructureView.hidden = YES;
            self.shellModelView.hidden = NO;
            self.shellModelInfoLabel.hidden = NO;
            self.overlayView.hidden = NO;
            break;

        default:
            break;
    }
}

#pragma mark - View Management Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.crystalStructureView.hidden = NO;
    self.shellModelView.hidden = YES;
    self.shellModelInfoLabel.layer.cornerRadius = 30.0f;
    self.shellModelInfoLabel.layer.borderWidth = 1.0f;
    self.shellModelInfoLabel.hidden = YES;
    self.overlayView.hidden = YES;
}

- (BOOL) shouldAutorotateToInterfaceOrientation: (UIInterfaceOrientation) interfaceOrientation {
    return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

#pragma mark - Memory Management Methods

- (void)dealloc {
    self.crystalStructureView = nil;
    self.shellModelView = nil;
    self.atomicRadiusLabel = nil;
    self.atomicVolumeLabel = nil;
    self.covalentRadiusLabel = nil;
    self.crossSectionLabel = nil;
    self.ionicRadiusLabel = nil;
    self.oxidationStatesLabel = nil;
    self.numberOfNeutronsLabel = nil;
    self.numberOfProtonsLabel = nil;
    self.numberOfElectronsLabel = nil;
    self.valenceLabel = nil;
    self.fillingOrbitalLabel = nil;
    self.kShellElectronsLabel = nil;
    self.lShellElectronsLabel = nil;
    self.mShellElectronsLabel = nil;
    self.nShellElectronsLabel = nil;
    self.oShellElectronsLabel = nil;
    self.pShellElectronsLabel = nil;
    self.qShellElectronsLabel = nil;
    self.shell1sLabel = nil;
    self.shell2sLabel = nil;
    self.shell2pLabel = nil;
    self.shell3sLabel = nil;
    self.shell3pLabel = nil;
    self.shell3dLabel = nil;
    self.shell4sLabel = nil;
    self.shell4pLabel = nil;
    self.shell4dLabel = nil;
    self.shell4fLabel = nil;
    self.shell5sLabel = nil;
    self.shell5pLabel = nil;
    self.shell5dLabel = nil;
    self.shell5fLabel = nil;
    self.shell6sLabel = nil;
    self.shell6pLabel = nil;
    self.shell6dLabel = nil;
    self.shell7sLabel = nil;
    self.shell7pLabel = nil;
}

@end
