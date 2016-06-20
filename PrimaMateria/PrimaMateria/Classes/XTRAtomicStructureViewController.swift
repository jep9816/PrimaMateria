//
//  XTRAtomicStructureViewController.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 4/15/16.
//  Copyright © 2016 xTrensa. All rights reserved.
//

@objc class XTRAtomicStructureViewController : XTRSwapableViewController {
    
    enum StructureViewTypes: Int {
        case kCrystalStructureView
        case kShellModelView
    }
    
    @IBOutlet var crystalStructureView : UIImageView!
    @IBOutlet var shellModelView : UIImageView!
    
    @IBOutlet var atomicRadiusLabel : UILabel!
    @IBOutlet var atomicVolumeLabel : UILabel!
    @IBOutlet var covalentRadiusLabel : UILabel!
    @IBOutlet var crossSectionLabel : UILabel!
    @IBOutlet var ionicRadiusLabel : UILabel!
    @IBOutlet var oxidationStatesLabel : UILabel!
    @IBOutlet var numberOfNeutronsLabel : UILabel!
    @IBOutlet var numberOfProtonsLabel : UILabel!
    @IBOutlet var numberOfElectronsLabel : UILabel!
    @IBOutlet var valenceLabel : UILabel!
    @IBOutlet var fillingOrbitalLabel : UILabel!
    
    @IBOutlet var kShellElectronsLabel : UILabel!
    @IBOutlet var lShellElectronsLabel : UILabel!
    @IBOutlet var mShellElectronsLabel : UILabel!
    @IBOutlet var nShellElectronsLabel : UILabel!
    @IBOutlet var oShellElectronsLabel : UILabel!
    @IBOutlet var pShellElectronsLabel : UILabel!
    @IBOutlet var qShellElectronsLabel : UILabel!
    
    @IBOutlet var shell1sLabel : UILabel!
    
    @IBOutlet var shell2sLabel : UILabel!
    @IBOutlet var shell2pLabel : UILabel!
    
    @IBOutlet var shell3sLabel : UILabel!
    @IBOutlet var shell3pLabel : UILabel!
    @IBOutlet var shell3dLabel : UILabel!
    
    @IBOutlet var shell4sLabel : UILabel!
    @IBOutlet var shell4pLabel : UILabel!
    @IBOutlet var shell4dLabel : UILabel!
    @IBOutlet var shell4fLabel : UILabel!
    
    @IBOutlet var shell5sLabel : UILabel!
    @IBOutlet var shell5pLabel : UILabel!
    @IBOutlet var shell5dLabel : UILabel!
    @IBOutlet var shell5fLabel : UILabel!
    
    @IBOutlet var shell6sLabel : UILabel!
    @IBOutlet var shell6pLabel : UILabel!
    @IBOutlet var shell6dLabel : UILabel!
    
    @IBOutlet var shell7sLabel : UILabel!
    @IBOutlet var shell7pLabel : UILabel!
    @IBOutlet var shellModelInfoLabel : UILabel!
    @IBOutlet var overlayView : UIView!
    
    // MARK: - Initialization Methods
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    // MARK: - Internal Methods
    
    override func setupUI() {
        if (self.element != nil) {
            self.crystalStructureView.image = self.element!.crystalStructureImage();
            self.shellModelView.image = self.element!.shellModelImage();
            
            self.atomicRadiusLabel.text = String.init(format: "%@", arguments: [self.element!.atomicRadius()])
            self.atomicVolumeLabel.text = String.init(format: "%@", arguments: [self.element!.atomicVolume()])
            self.covalentRadiusLabel.text = String.init(format: "%@", arguments: [self.element!.covalentRadius()])
            self.crossSectionLabel.text = String.init(format: "%@", arguments: [self.element!.valueForKey(ELEMENT_COVALENT_RADIUS) as! String])
            self.ionicRadiusLabel.text = String.init(format: "%@", arguments: [self.element!.valueForKey(ELEMENT_IONIC_RADIUS) as! String])
            self.oxidationStatesLabel.text = String.init(format: "%@", arguments: [self.element!.valueForKey(ELEMENT_OXIDATION_STATES) as! String])
            self.numberOfElectronsLabel.text = String.init(format: "%@", arguments: [self.element!.valueForKey(ELEMENT_NUMBER_OF_ELECTRONS) as! String])
            self.numberOfNeutronsLabel.text = String.init(format: "%@", arguments: [self.element!.valueForKey(ELEMENT_NUMBER_OF_NEUTRONS) as! String])
            self.numberOfProtonsLabel.text = String.init(format: "%@", arguments: [self.element!.valueForKey(ELEMENT_NUMBER_OF_PROTONS) as! String])
            
            self.shellModelInfoLabel.backgroundColor = self.element!.seriesColor();
            self.shellModelInfoLabel.text = String.init(format: "%@P\n%N", arguments: [self.numberOfProtonsLabel.text!, self.numberOfNeutronsLabel.text!])
            
            self.valenceLabel.text = self.element!.valence();
            self.fillingOrbitalLabel.text = self.element!.fillingOrbital();
            
            self.kShellElectronsLabel.text = self.element!.kShellElectrons();
            self.lShellElectronsLabel.text = self.element!.lShellElectrons();
            self.mShellElectronsLabel.text = self.element!.mShellElectrons();
            self.nShellElectronsLabel.text = self.element!.nShellElectrons();
            self.oShellElectronsLabel.text = self.element!.oShellElectrons();
            self.pShellElectronsLabel.text = self.element!.pShellElectrons();
            self.qShellElectronsLabel.text = self.element!.qShellElectrons();
            
            self.shell1sLabel.text = self.element!.shell1s();
            
            self.shell2sLabel.text = self.element!.shell2s();
            self.shell2pLabel.text = self.element!.shell2p();
            
            self.shell3sLabel.text = self.element!.shell3s();
            self.shell3pLabel.text = self.element!.shell3p();
            self.shell3dLabel.text = self.element!.shell3d();
            
            self.shell4sLabel.text = self.element!.shell4s();
            self.shell4pLabel.text = self.element!.shell4p();
            self.shell4dLabel.text = self.element!.shell4d();
            self.shell4fLabel.text = self.element!.shell4f();
            
            self.shell5sLabel.text = self.element!.shell5s();
            self.shell5pLabel.text = self.element!.shell5p();
            self.shell5dLabel.text = self.element!.shell5d();
            self.shell5fLabel.text = self.element!.shell5f();
            
            self.shell6sLabel.text = self.element!.shell6s();
            self.shell6pLabel.text = self.element!.shell6p();
            self.shell6dLabel.text = self.element!.shell6d();
            
            self.shell7sLabel.text = self.element!.shell7s();
            self.shell7pLabel.text = self.element!.shell7p();
        }
    }
    
    // MARK: - Action Methods
    
    @IBAction func swapViews(sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case StructureViewTypes.kCrystalStructureView.rawValue:
            self.crystalStructureView.hidden = false;
            self.shellModelView.hidden = true;
            self.shellModelInfoLabel.hidden = true;
            self.overlayView.hidden = true;
        case StructureViewTypes.kShellModelView.rawValue:
            self.crystalStructureView.hidden = true;
            self.shellModelView.hidden = false;
            self.shellModelInfoLabel.hidden = false;
            self.overlayView.hidden = false;
        default:
            break
        }
    }
    
    // MARK: - View Management Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.crystalStructureView.hidden = false;
        self.shellModelView.hidden = true;
        self.shellModelInfoLabel.layer.cornerRadius = 30.0;
        self.shellModelInfoLabel.layer.borderWidth = 1.0;
        self.shellModelInfoLabel.hidden = true;
        self.overlayView.hidden = true;
    }
    
    override func shouldAutorotate() -> Bool {
        return true
    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return [UIInterfaceOrientationMask.LandscapeLeft, UIInterfaceOrientationMask.LandscapeRight]
    }
    
    // MARK: - Memory Management Methods
    
    deinit {
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
}
