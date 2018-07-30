//
//  XTRAtomicStructureViewController.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 4/15/16.
//  Copyright © 2018 xTrensa. All rights reserved.
//

import SpriteKit
import GameplayKit
import RxSwift
import RxCocoa

struct XTRAtomicStructureViewControllerConfig {
    
    enum StructureViewTypes {
        static let kCrystalStructureView = 0
        static let kShellModelView = 1
    }

}

class XTRAtomicStructureViewController: XTRSwapableViewController {
    
    @IBOutlet var segmentedControl: UISegmentedControl!
    @IBOutlet var crystalStructureView: SCNView!
    @IBOutlet var shellModelView: SKView!
    
    @IBOutlet var atomicRadiusLabel: UILabel!
    @IBOutlet var atomicVolumeLabel: UILabel!
    @IBOutlet var covalentRadiusLabel: UILabel!
    @IBOutlet var crossSectionLabel: UILabel!
    @IBOutlet var ionicRadiusLabel: UILabel!
    @IBOutlet var oxidationStatesLabel: UILabel!
    @IBOutlet var numberOfNeutronsLabel: UILabel!
    @IBOutlet var numberOfProtonsLabel: UILabel!
    @IBOutlet var numberOfElectronsLabel: UILabel!
    @IBOutlet var valenceLabel: UILabel!
    @IBOutlet var fillingOrbitalLabel: UILabel!
    @IBOutlet var crystalStructureLabel: UILabel!
    
    @IBOutlet var kShellElectronsLabel: UILabel!
    @IBOutlet var lShellElectronsLabel: UILabel!
    @IBOutlet var mShellElectronsLabel: UILabel!
    @IBOutlet var nShellElectronsLabel: UILabel!
    @IBOutlet var oShellElectronsLabel: UILabel!
    @IBOutlet var pShellElectronsLabel: UILabel!
    @IBOutlet var qShellElectronsLabel: UILabel!
    
    @IBOutlet var shell1sLabel: UILabel!
    
    @IBOutlet var shell2sLabel: UILabel!
    @IBOutlet var shell2pLabel: UILabel!
    
    @IBOutlet var shell3sLabel: UILabel!
    @IBOutlet var shell3pLabel: UILabel!
    @IBOutlet var shell3dLabel: UILabel!
    
    @IBOutlet var shell4sLabel: UILabel!
    @IBOutlet var shell4pLabel: UILabel!
    @IBOutlet var shell4dLabel: UILabel!
    @IBOutlet var shell4fLabel: UILabel!
    
    @IBOutlet var shell5sLabel: UILabel!
    @IBOutlet var shell5pLabel: UILabel!
    @IBOutlet var shell5dLabel: UILabel!
    @IBOutlet var shell5fLabel: UILabel!
    
    @IBOutlet var shell6sLabel: UILabel!
    @IBOutlet var shell6pLabel: UILabel!
    @IBOutlet var shell6dLabel: UILabel!
    
    @IBOutlet var shell7sLabel: UILabel!
    @IBOutlet var shell7pLabel: UILabel!
    @IBOutlet var overlayView: UIView!
    
    var disposeBag = DisposeBag()

    // MARK: - Initialization Methods
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    // MARK: - Internal Methods
    
    override func setupUI(element: XTRElementModel) {
        super.setupUI(element: element)
        
        title = NSLocalizedString("atomicStructure", comment: "")
        
        let crystalStructure = element.value(forKeyPath: ELEMENT_CRYSTAL_STRUCTURE) as! String
        let scene = element.shellModelScene
        let scnScene = element.crystalStructureScene

        setupSegmentedControlUI()

        crystalStructureLabel.text = crystalStructure
        shellModelView.backgroundColor = element.seriesColor
        
        scene.scaleMode = .aspectFit
        shellModelView.presentScene(scene)
        crystalStructureView.scene = scnScene
        
        atomicRadiusLabel.text = "\(element.atomicRadius)"
        atomicVolumeLabel.text = "\(element.atomicVolume)"
        covalentRadiusLabel.text = "\(element.covalentRadius)"
        crossSectionLabel.text = "\(element.value(forKeyPath: ELEMENT_CROSS_SECTION)!)"
        ionicRadiusLabel.text = "\(element.value(forKeyPath: ELEMENT_IONIC_RADIUS)!)"
        oxidationStatesLabel.text = "\(element.value(forKeyPath: ELEMENT_OXIDATION_STATES)!)"
        numberOfElectronsLabel.text = "\(element.value(forKeyPath: ELEMENT_NUMBER_OF_ELECTRONS)!)"
        numberOfNeutronsLabel.text = "\(element.value(forKeyPath: ELEMENT_NUMBER_OF_NEUTRONS)!)"
        numberOfProtonsLabel.text = "\(element.value(forKeyPath: ELEMENT_NUMBER_OF_PROTONS)!)"
        
        valenceLabel.text = element.valence
        fillingOrbitalLabel.text = element.fillingOrbital
        
        kShellElectronsLabel.text = element.kShellElectrons
        lShellElectronsLabel.text = element.lShellElectrons
        mShellElectronsLabel.text = element.mShellElectrons
        nShellElectronsLabel.text = element.nShellElectrons
        oShellElectronsLabel.text = element.oShellElectrons
        pShellElectronsLabel.text = element.pShellElectrons
        qShellElectronsLabel.text = element.qShellElectrons
        
        shell1sLabel.text = element.shell1s
        
        shell2sLabel.text = element.shell2s
        shell2pLabel.text = element.shell2p
        
        shell3sLabel.text = element.shell3s
        shell3pLabel.text = element.shell3p
        shell3dLabel.text = element.shell3d
        
        shell4sLabel.text = element.shell4s
        shell4pLabel.text = element.shell4p
        shell4dLabel.text = element.shell4d
        shell4fLabel.text = element.shell4f
        
        shell5sLabel.text = element.shell5s
        shell5pLabel.text = element.shell5p
        shell5dLabel.text = element.shell5d
        shell5fLabel.text = element.shell5f
        
        shell6sLabel.text = element.shell6s
        shell6pLabel.text = element.shell6p
        shell6dLabel.text = element.shell6d
        
        shell7sLabel.text = element.shell7s
        shell7pLabel.text = element.shell7p
    }
    
    func setupSegmentedControlUI() {
        segmentedControl.setTitle(NSLocalizedString("crystalStructure", comment: ""), forSegmentAt: 0)
        segmentedControl.setTitle(NSLocalizedString("shellModel", comment: ""), forSegmentAt: 1)
        segmentedControl.rx.selectedSegmentIndex.subscribe(onNext: { [weak self] selectedSegmentIndex in
            switch selectedSegmentIndex {
            case XTRAtomicStructureViewControllerConfig.StructureViewTypes.kCrystalStructureView:
                self?.crystalStructureView.isHidden = false
                self?.shellModelView.isHidden = true
            case XTRAtomicStructureViewControllerConfig.StructureViewTypes.kShellModelView:
                self?.crystalStructureView.isHidden = true
                self?.shellModelView.isHidden = false
            default:
                break
            }
        }).disposed(by: disposeBag)
    }

    // MARK: - Action Methods
    
    // MARK: - View Management Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        crystalStructureView.isHidden = false
        crystalStructureView.allowsCameraControl = true
        crystalStructureView.autoenablesDefaultLighting = true
        
        shellModelView.isHidden = true
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
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
