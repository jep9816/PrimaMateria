//
//  XTRAtomicStructureViewController.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 4/15/16.
//  Copyright ©2023 xTrensa. All rights reserved.
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
    @IBOutlet var crystalStructureExpandButton: UIButton!
    @IBOutlet var shellModelExpandButton: UIButton!

    var overlayView: XTROverlayView!
    var crystalStructureContent: XTRZoomContentView!
    var shellModelContent: XTRZoomContentView!
    var crystalStructureString: String!

    let contentRect = CGRect(x: 154, y: 10, width: 716, height: 748)
    let localRect = CGRect(x: 0, y: 32, width: 716, height: 716)

    // MARK: - Initialization Methods

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    // MARK: - Internal Methods

    override func setupUIForAnimation(element: XTRElementModel) {
        super.setupUIForAnimation(element: element)

        setupAtomicStructureUI(element: element)
        setupLabels(element: element)
    }

    override func setupUI(element: XTRElementModel) {
        super.setupUI(element: element)

        setupAtomicStructureUI(element: element)
        setupLabels(element: element)
    }

    func setupAtomicStructureUI(element: XTRElementModel) {
        let crystalStructureScene = element.crystalStructureScene
        let shellModelScene = element.shellModelScene

        crystalStructureString = element.value(forKeyPath: ELEMENT_CRYSTAL_STRUCTURE) as? String
        crystalStructureLabel.text = crystalStructureString
        crystalStructureView.scene = crystalStructureScene

        shellModelScene.scaleMode = .aspectFit
        shellModelView.presentScene(shellModelScene)
        shellModelView.backgroundColor = element.seriesColor
    }

    func setupSegmentedControlUI() {
        segmentedControl.cornerRadius = VIEW_CORNER_RADIUS
        segmentedControl.masksToBounds = true
        segmentedControl.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        segmentedControl.setTitle(NSLocalizedString("crystalStructure", comment: ""), forSegmentAt: 0)
        segmentedControl.setTitle(NSLocalizedString("shellModel", comment: ""), forSegmentAt: 1)
    }

    func setupLabels(element: XTRElementModel) {
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

        shell1sLabel.text = element.electronConfigurationModel?.shell1s

        shell2sLabel.text = element.electronConfigurationModel?.shell2s
        shell2pLabel.text = element.electronConfigurationModel?.shell2p

        shell3sLabel.text = element.electronConfigurationModel?.shell3s
        shell3pLabel.text = element.electronConfigurationModel?.shell3p
        shell3dLabel.text = element.electronConfigurationModel?.shell3d

        shell4sLabel.text = element.electronConfigurationModel?.shell4s
        shell4pLabel.text = element.electronConfigurationModel?.shell4p
        shell4dLabel.text = element.electronConfigurationModel?.shell4d
        shell4fLabel.text = element.electronConfigurationModel?.shell4f

        shell5sLabel.text = element.electronConfigurationModel?.shell5s
        shell5pLabel.text = element.electronConfigurationModel?.shell5p
        shell5dLabel.text = element.electronConfigurationModel?.shell5d
        shell5fLabel.text = element.electronConfigurationModel?.shell5f

        shell6sLabel.text = element.electronConfigurationModel?.shell6s
        shell6pLabel.text = element.electronConfigurationModel?.shell6p
        shell6dLabel.text = element.electronConfigurationModel?.shell6d

        shell7sLabel.text = element.electronConfigurationModel?.shell7s
        shell7pLabel.text = element.electronConfigurationModel?.shell7p
    }

    func setupRx() {
        Observable.merge([mapToObserver(button: crystalStructureExpandButton)]).subscribe(onNext: { [weak self] sender in
            self?.presentCrystalStructureContent(sender: sender)
        }).disposed(by: disposeBag)

        Observable.merge([mapToObserver(button: shellModelExpandButton)]).subscribe(onNext: { [weak self] sender in
            self?.presentShellModelContent(sender: sender)
        }).disposed(by: disposeBag)

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
        title = NSLocalizedString("atomicStructure", comment: "")

        setupSegmentedControlUI()

        crystalStructureExpandButton.cornerRadius = VIEW_CORNER_RADIUS
        crystalStructureExpandButton.masksToBounds = true
        crystalStructureExpandButton.borderColor = XTRColorFactory.helpButtonBorderColor
        crystalStructureExpandButton.borderWidth = 2.0

        shellModelExpandButton.cornerRadius = VIEW_CORNER_RADIUS
        shellModelExpandButton.masksToBounds = true
        shellModelExpandButton.borderColor = XTRColorFactory.helpButtonBorderColor
        shellModelExpandButton.borderWidth = 2.0

        if overlayView != nil {
            if shellModelContent != nil {
                shellModelContent.removeFromSuperview()
                shellModelContent = nil
            }
            if crystalStructureContent != nil {
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
        overlayView.isUserInteractionEnabled = true

        setupRx()

        view.addSubview(overlayView)
        view.sendSubviewToBack(overlayView)
    }

    func createZoomView(frame: CGRect, type: Int) {
        let rect = self.view.convert(self.shellModelView.frame, to: self.view.window)

        if type == XTRAtomicStructureViewControllerConfig.StructureViewTypes.kCrystalStructureView {
            let gesture = UITapGestureRecognizer(target: self, action: #selector(dismissCrystalStructureContent(sender:)))
            let titleString = "\(element?.name ?? "") - \(NSLocalizedString("crystalStructure", comment: "")) - \(crystalStructureString!)"
            crystalStructureContent = XTRZoomContentView.instantiateFromXib()
            crystalStructureContent.title = titleString
            crystalStructureContent.frame = rect

            let localCrystalStructureView = SCNView()
            localCrystalStructureView.frame = localRect
            localCrystalStructureView.scene = element?.crystalStructureScene
            localCrystalStructureView.allowsCameraControl = true
            localCrystalStructureView.autoenablesDefaultLighting = true
            overlayView.addGestureRecognizer(gesture)

            crystalStructureContent.addContent(localCrystalStructureView)
        } else {
            let gesture = UITapGestureRecognizer(target: self, action: #selector(dismissShellModelContent(sender:)))
            let titleString = "\(element?.name ?? "")) - \(NSLocalizedString("shellModel", comment: ""))"

            shellModelContent = XTRZoomContentView.instantiateFromXib()
            shellModelContent.title = titleString
            shellModelContent.frame = rect

            let localShellModelScene = XTRShellModelScene(size: CGSize(width: 716, height: 716), element: element!)
            localShellModelScene.scaleMode = .aspectFill

            let localShellModelView = SKView()
            localShellModelView.frame = localRect
            localShellModelView.presentScene(localShellModelScene)
            overlayView.addGestureRecognizer(gesture)

            shellModelContent.addContent(localShellModelView)
        }
    }

    func toggleUserInteractions(flag: Bool) {
        segmentedControl.isUserInteractionEnabled = flag
        NotificationCenter.default.post(name: .notificationAtomicStructureZoomed, object: flag)
    }

    func present(content: XTRZoomContentView) {
        toggleUserInteractions(flag: false)

        overlayView.addSubview(content)
        overlayView.backgroundColor = UIColor.clear.withAlphaComponent(0.0)
        overlayView.isHidden = false

        content.alpha = 0.0
        content.isHidden = false

        view.bringSubviewToFront(self.overlayView)

        UIView.animate(withDuration: 1, animations: { [weak self] in
            self?.overlayView.backgroundColor = UIColor.clear.withAlphaComponent(0.6)
            content.alpha = 1.0
            content.frame = (self?.contentRect)!
        }, completion: nil)
    }

    func dismiss(content: XTRZoomContentView, localView: UIView) {
        UIView.animate(withDuration: 1, animations: {
            self.overlayView.backgroundColor = UIColor.clear.withAlphaComponent(0.0)
            content.alpha = 0.0
            content.frame = self.view.convert(localView.frame, to: self.view.window)
        }, completion: { _ in
            self.view.sendSubviewToBack(self.overlayView)
            content.isHidden = true
            self.overlayView.isHidden = true
            content.removeFromSuperview()
        })

        toggleUserInteractions(flag: true)
    }

    @objc func presentCrystalStructureContent(sender: UIButton) {
        createZoomView(frame: self.crystalStructureView.frame, type: XTRAtomicStructureViewControllerConfig.StructureViewTypes.kCrystalStructureView)
        crystalStructureExpandButton.setImage(#imageLiteral(resourceName: "CompressButton"), for: UIControl.State())
        present(content: crystalStructureContent)
    }

    @objc func dismissCrystalStructureContent(sender: UIGestureRecognizer) {
        if crystalStructureContent != nil {
            dismiss(content: crystalStructureContent, localView: crystalStructureView)
            crystalStructureExpandButton.setImage(#imageLiteral(resourceName: "ExpandButton"), for: UIControl.State())
            crystalStructureContent = nil
        }
    }

    @objc func presentShellModelContent(sender: UIButton) {
        createZoomView(frame: self.shellModelView.frame, type: XTRAtomicStructureViewControllerConfig.StructureViewTypes.kShellModelView)
        shellModelExpandButton.setImage(#imageLiteral(resourceName: "CompressButton"), for: UIControl.State())
        present(content: shellModelContent)
    }

    @objc func dismissShellModelContent(sender: UIGestureRecognizer) {
        if shellModelContent != nil {
            dismiss(content: shellModelContent, localView: shellModelView)
            shellModelExpandButton.setImage(#imageLiteral(resourceName: "ExpandButton"), for: UIControl.State())
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

    private func deinitShellLabels() {
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

    deinit {
        crystalStructureView = nil
        crystalStructureLabel = nil
        crystalStructureExpandButton = nil
        shellModelView = nil
        shellModelExpandButton = nil
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
        deinitShellLabels()
    }

}
