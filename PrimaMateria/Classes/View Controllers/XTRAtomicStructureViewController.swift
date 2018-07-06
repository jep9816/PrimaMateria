//
//  XTRAtomicStructureViewController.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 4/15/16.
//  Copyright © 2018 xTrensa. All rights reserved.
//

import SpriteKit
import GameplayKit

class XTRAtomicStructureViewController : XTRSwapableViewController {
    
    enum StructureViewTypes {
        static let kCrystalStructureView = 0
        static let kShellModelView = 1
    }
    
    @IBOutlet var crystalStructureView : SCNView!
    @IBOutlet var shellModelView : SKView!
    
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
    @IBOutlet var crystalStructureLabel : UILabel!
    
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
    @IBOutlet var overlayView : UIView!
    
    // MARK: - Initialization Methods
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    // MARK: - Internal Methods
    
    override func setupUI() {
        title = NSLocalizedString("atomicStructure", comment: "")
        guard let localElement = element else { return }
        let crystalStructure = localElement.value(forKeyPath: ELEMENT_CRYSTAL_STRUCTURE) as! String
        let scene = localElement.shellModelScene
        let scnScene = localElement.crystalStructureScene

        crystalStructureLabel.text = crystalStructure
        shellModelView.backgroundColor = localElement.seriesColor
        
        scene.scaleMode = .aspectFit
        shellModelView.presentScene(scene)
        crystalStructureView.scene = scnScene
        
        atomicRadiusLabel.text = "\(localElement.atomicRadius)"
        atomicVolumeLabel.text = "\(localElement.atomicVolume)"
        covalentRadiusLabel.text = "\(localElement.covalentRadius)"
        crossSectionLabel.text = "\(localElement.value(forKeyPath: ELEMENT_CROSS_SECTION)!)"
        ionicRadiusLabel.text = "\(localElement.value(forKeyPath: ELEMENT_IONIC_RADIUS)!)"
        oxidationStatesLabel.text = "\(localElement.value(forKeyPath: ELEMENT_OXIDATION_STATES)!)"
        numberOfElectronsLabel.text = "\(localElement.value(forKeyPath: ELEMENT_NUMBER_OF_ELECTRONS)!)"
        numberOfNeutronsLabel.text = "\(localElement.value(forKeyPath: ELEMENT_NUMBER_OF_NEUTRONS)!)"
        numberOfProtonsLabel.text = "\(localElement.value(forKeyPath: ELEMENT_NUMBER_OF_PROTONS)!)"
        
        valenceLabel.text = localElement.valence
        fillingOrbitalLabel.text = localElement.fillingOrbital
        
        kShellElectronsLabel.text = localElement.kShellElectrons
        lShellElectronsLabel.text = localElement.lShellElectrons
        mShellElectronsLabel.text = localElement.mShellElectrons
        nShellElectronsLabel.text = localElement.nShellElectrons
        oShellElectronsLabel.text = localElement.oShellElectrons
        pShellElectronsLabel.text = localElement.pShellElectrons
        qShellElectronsLabel.text = localElement.qShellElectrons
        
        shell1sLabel.text = localElement.shell1s
        
        shell2sLabel.text = localElement.shell2s
        shell2pLabel.text = localElement.shell2p
        
        shell3sLabel.text = localElement.shell3s
        shell3pLabel.text = localElement.shell3p
        shell3dLabel.text = localElement.shell3d
        
        shell4sLabel.text = localElement.shell4s
        shell4pLabel.text = localElement.shell4p
        shell4dLabel.text = localElement.shell4d
        shell4fLabel.text = localElement.shell4f
        
        shell5sLabel.text = localElement.shell5s
        shell5pLabel.text = localElement.shell5p
        shell5dLabel.text = localElement.shell5d
        shell5fLabel.text = localElement.shell5f
        
        shell6sLabel.text = localElement.shell6s
        shell6pLabel.text = localElement.shell6p
        shell6dLabel.text = localElement.shell6d
        
        shell7sLabel.text = localElement.shell7s
        shell7pLabel.text = localElement.shell7p
    }
    
    // MARK: - Action Methods
    
    @IBAction func swapViews(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case StructureViewTypes.kCrystalStructureView:
            crystalStructureView.isHidden = false
            shellModelView.isHidden = true
        case StructureViewTypes.kShellModelView:
            crystalStructureView.isHidden = true
            shellModelView.isHidden = false
        default:
            break
        }
    }
    
    // MARK: - View Management Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        crystalStructureView.isHidden = false
        crystalStructureView.allowsCameraControl = true
        crystalStructureView.autoenablesDefaultLighting = true
        
        shellModelView.isHidden = true
    }
    
    override var shouldAutorotate : Bool {
        return false
    }
    
    override var supportedInterfaceOrientations : UIInterfaceOrientationMask {
        return .landscape
    }
    
    // MARK: - Memory Management Methods
    
    deinit {
        crystalStructureView = nil
        crystalStructureLabel = nil
        shellModelView = nil
        atomicRadiusLabel = nil
        atomicVolumeLabel = nil
        covalentRadiusLabel = nil
        crossSectionLabel = nil
        ionicRadiusLabel = nil
        oxidationStatesLabel = nil
        numberOfNeutronsLabel = nil
        numberOfProtonsLabel = nil
        numberOfElectronsLabel = nil
        valenceLabel = nil
        fillingOrbitalLabel = nil
        kShellElectronsLabel = nil
        lShellElectronsLabel = nil
        mShellElectronsLabel = nil
        nShellElectronsLabel = nil
        oShellElectronsLabel = nil
        pShellElectronsLabel = nil
        qShellElectronsLabel = nil
        shell1sLabel = nil
        shell2sLabel = nil
        shell2pLabel = nil
        shell3sLabel = nil
        shell3pLabel = nil
        shell3dLabel = nil
        shell4sLabel = nil
        shell4pLabel = nil
        shell4dLabel = nil
        shell4fLabel = nil
        shell5sLabel = nil
        shell5pLabel = nil
        shell5dLabel = nil
        shell5fLabel = nil
        shell6sLabel = nil
        shell6pLabel = nil
        shell6dLabel = nil
        shell7sLabel = nil
        shell7pLabel = nil
    }
    
}
