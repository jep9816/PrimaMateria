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
import AVFoundation

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
    
    var overlayView: XTROverlayView!
    
    var crystalStructureContent: XTRZoomContentView!
    var localCrystalStructureView: SCNView!
    
    var shellModelContent: XTRZoomContentView!
    var localShellModelView: SKView!
    
    var disposeBag = DisposeBag()
    
    let contentRect = CGRect(x: 154, y: 10, width: 716, height: 748)
    let localRect = CGRect(x: 0, y: 32, width: 716, height: 716)
    let startRect = CGRect(x: 1200, y: 290, width: 322, height: 322)
    var crystalStructure: String!

    // MARK: - Initialization Methods
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    // MARK: - Internal Methods
    
    override func setupUI(element: XTRElementModel) {
        super.setupUI(element: element)
        
        let crystalStructureViewButton = UIButton(frame: CGRect(x: crystalStructureView.frame.size.width - 32, y: 0, width: 32, height: 32))
        let shellModelViewButton = UIButton(frame: CGRect(x: shellModelView.frame.size.width - 32, y: 0, width: 32, height: 32))
        let crystalStructureScene = element.crystalStructureScene
        let shellModelScene = element.shellModelScene

        title = NSLocalizedString("atomicStructure", comment: "")
        crystalStructure = element.value(forKeyPath: ELEMENT_CRYSTAL_STRUCTURE) as! String

        crystalStructureViewButton.setTitle("⏫", for: UIControlState())
        crystalStructureViewButton.addTarget(self, action: #selector(presentCrystalStructureContent(sender:)), for: .touchUpInside)
        
        shellModelViewButton.setTitle("⏫", for: UIControlState())
        shellModelViewButton.addTarget(self, action: #selector(presentShellModelContent(sender:)), for: .touchUpInside)
        
        setupSegmentedControlUI()
        
        crystalStructureLabel.text = crystalStructure
        
        crystalStructureView.scene = crystalStructureScene
        crystalStructureView.addSubview(crystalStructureViewButton)
        
        shellModelScene.scaleMode = .aspectFit
        shellModelView.presentScene(shellModelScene)
        shellModelView.backgroundColor = element.seriesColor
        shellModelView.addSubview(shellModelViewButton)
        
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
        let rect = UIScreen.main.bounds

        if overlayView != nil {
            if shellModelContent != nil {
                localShellModelView.removeFromSuperview()
                localShellModelView = nil
                shellModelContent.removeFromSuperview()
                shellModelContent = nil
            }
            if crystalStructureContent != nil {
                localCrystalStructureView.removeFromSuperview()
                localCrystalStructureView = nil
                crystalStructureContent.removeFromSuperview()
                crystalStructureContent = nil
            }
            
            overlayView.removeFromSuperview()
            overlayView = nil
        }
        
        crystalStructureView.isHidden = false
        crystalStructureView.allowsCameraControl = true
        crystalStructureView.autoenablesDefaultLighting = true
        
        shellModelView.isHidden = true
        overlayView = XTROverlayView(frame: CGRect(x: rect.origin.x, y: rect.origin.y - 148, width: rect.size.width, height: rect.size.height))

        view.addSubview(overlayView)
        view.sendSubview(toBack: overlayView)
    }
    
    @objc func doIt(sender: Any?) {
        print("doit  tapped")
    }

    func createZoomView(frame: CGRect, type: Int) {
        let rect = self.view.convert(self.shellModelView.frame, to: self.view.window)
        
        if type == XTRAtomicStructureViewControllerConfig.StructureViewTypes.kCrystalStructureView {
            let gesture = UITapGestureRecognizer(target: self, action: #selector(dismissCrystalStructureContent(sender:)))
            let titleString = "\(element?.name ?? "") - \(NSLocalizedString("crystalStructure", comment: "")) - \(crystalStructure!)"
            crystalStructureContent = XTRZoomContentView(frame: rect, title: titleString, gesture: gesture)

            localCrystalStructureView = SCNView()
            localCrystalStructureView.frame = localRect
            localCrystalStructureView.scene = element?.crystalStructureScene
            localCrystalStructureView.allowsCameraControl = true
            localCrystalStructureView.autoenablesDefaultLighting = true
            localCrystalStructureView.backgroundColor = #colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 0.7)

            crystalStructureContent.wrapper.addSubview(localCrystalStructureView)
        } else {
            let gesture = UITapGestureRecognizer(target: self, action: #selector(dismissShellModelContent(sender:)))
            let titleString = "\(element?.name ?? "")) - \(NSLocalizedString("shellModel", comment: ""))"

            shellModelContent = XTRZoomContentView(frame: rect, title: titleString, gesture: gesture)

            let localShellModelScene = XTRShellModelScene(size: CGSize(width: 716, height: 716), element: element!)
            localShellModelScene.scaleMode = .aspectFill

            localShellModelView = SKView()
            localShellModelView.frame = localRect
            localShellModelView.presentScene(localShellModelScene)
            localShellModelView.backgroundColor = #colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 0.7)

            shellModelContent.wrapper.addSubview(localShellModelView)
        }
    }
    
    func toggleUserInteractions(flag: Bool) {
        segmentedControl.isUserInteractionEnabled = flag
        NotificationCenter.default.post(name: .notificationAtomicStructureZoomed, object: flag)
    }
    
    func present(content: XTRZoomContentView, localView: UIView) {
        toggleUserInteractions(flag: false)
        overlayView.addSubview(content)
        overlayView.backgroundColor = UIColor.clear.withAlphaComponent(0.0)
        overlayView.isHidden = false
        
        content.alpha = 0.0
        content.isHidden = false
        
        view.bringSubview(toFront: self.overlayView)
        
        UIView.animate(withDuration: 1, animations: { [weak self] in
            self?.overlayView.backgroundColor = UIColor.clear.withAlphaComponent(0.6)
            content.alpha = 1.0
            content.frame = (self?.contentRect)!
            
            localView.frame = (self?.localRect)!
        }, completion: nil)
    }
    
    func dismiss(content: XTRZoomContentView, localView: UIView) {
        UIView.animate(withDuration: 1, animations: {
            self.overlayView.backgroundColor = UIColor.clear.withAlphaComponent(0.0)
            content.alpha = 0.0
            content.frame = self.view.convert(localView.frame, to: self.view.window)
        }, completion: { _ in
            self.view.sendSubview(toBack: self.overlayView)
            content.isHidden = true
            self.overlayView.isHidden = true
            content.removeFromSuperview()
        })
        
        toggleUserInteractions(flag: true)
    }
    
    @objc func presentCrystalStructureContent(sender: UIButton) {
        createZoomView(frame: self.crystalStructureView.frame, type: XTRAtomicStructureViewControllerConfig.StructureViewTypes.kCrystalStructureView)
        present(content: crystalStructureContent, localView: localCrystalStructureView)
    }
    
    @objc func dismissCrystalStructureContent(sender: UIGestureRecognizer) {
        if crystalStructureContent != nil {
            dismiss(content: crystalStructureContent, localView: crystalStructureView)
            crystalStructureContent = nil
        }
    }
    
    @objc func presentShellModelContent(sender: UIButton) {
        createZoomView(frame: self.shellModelView.frame, type: XTRAtomicStructureViewControllerConfig.StructureViewTypes.kShellModelView)
        present(content: shellModelContent, localView: localShellModelView)
    }
    
    @objc func dismissShellModelContent(sender: UIGestureRecognizer) {
        if shellModelContent != nil {
            dismiss(content: shellModelContent, localView: shellModelView)
            shellModelContent = nil
        }
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
