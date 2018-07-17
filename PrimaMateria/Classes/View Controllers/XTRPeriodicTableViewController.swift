//
//  XTRPeriodicTableViewController.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 4/15/16.
//  Copyright © 2018 xTrensa. All rights reserved.
//

import UIKit

class XTRPeriodicTableViewController: UIViewController {
    
    @IBOutlet var swapView: UIView!
    @IBOutlet var navigationBar: UINavigationBar!
    @IBOutlet var molecularCalculatorSwitch: UISwitch!
    
    var molecularCalculatorState: Bool = false
    var elementBalloonViewController: XTRElementBalloonViewController!
    var molecularCalculatorViewController: XTRMolecularCalculatorViewController!
    
    // MARK: - Initialization Methods
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    // MARK: - Internal Methods
    
    func showElementPanelForElementAtIndex(_ anIndex: Int) {
        XTRPropertiesStore.viewTitle = title!
        XTRPropertiesStore.atomicNumber = anIndex
        performSegue(withIdentifier: SegueName.showInspectorFromPeriodicTable, sender: self)
    }
    
    func setupPopUp() {
        let contentSize = CGSize(width: 324.0, height: 210.0)
        
        elementBalloonViewController = XTRAppDelegate.storyboard().instantiateViewController(withIdentifier: XTRElementBalloonViewController.nameOfClass) as! XTRElementBalloonViewController
        elementBalloonViewController.preferredContentSize = contentSize
        elementBalloonViewController.modalPresentationStyle = .popover
    }
    
    func toggleMolecularCalculatorState(_ aFlag: Bool) {
        if aFlag {
            molecularCalculatorState = true
            view.addSubview(molecularCalculatorViewController.view)
        } else {
            molecularCalculatorState = false
            molecularCalculatorViewController.view.removeFromSuperview()
            molecularCalculatorViewController.viewWillDisappear(true)
        }
    }
    
    // MARK: - Action Methods
    
    @IBAction func showPopupForButton(_ sender: UIButton) {
        guard let popoverController = elementBalloonViewController.popoverPresentationController else { return }
        
        XTRPropertiesStore.viewTitle = title!
        XTRPropertiesStore.atomicNumber = sender.tag
        popoverController.sourceRect = CGRect(x: 0, y: 0, width: 52, height: 54)
        popoverController.sourceView = sender
        popoverController.backgroundColor = XTRColorFactory.popupArrowColor
        
        present(elementBalloonViewController, animated: true, completion: nil)
    }
    
    @IBAction func showMolecularCalculator(_ sender: UISwitch) {
        toggleMolecularCalculatorState(sender.isOn)
    }
    
    @IBAction func showElementInspector(_ sender: UIButton) {
        if molecularCalculatorState {
            let element = XTRDataSource.sharedInstance().elementAtIndex(sender.tag)
            molecularCalculatorViewController.setElement(element)
        } else {
            if XTRPropertiesStore.elementBubblesState {
                showPopupForButton(sender)
            } else {
                showElementPanelForElementAtIndex(sender.tag)
            }
        }
    }
    
    // MARK: mark - Notification Methods
    
    @objc func closeBubble(_ aNotification: Notification) {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - View Management Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let titleString = NSLocalizedString(PERIODIC_VIEW_TITLE, comment: "")
        title = titleString
        navigationBar.topItem?.title = titleString
        
        molecularCalculatorViewController = XTRAppDelegate.storyboard().instantiateViewController(withIdentifier: XTRMolecularCalculatorViewController.nameOfClass) as! XTRMolecularCalculatorViewController
        molecularCalculatorViewController.view.frame = swapView.frame
        swapView.removeFromSuperview()
        setupPopUp()
        toggleMolecularCalculatorState(false)
        
        NotificationCenter.default.addObserver(self, selector: #selector(closeBubble(_:)), name: .inspectorDismissedNotification, object: nil)
        navigationController?.navigationBar.prefersLargeTitles = true
        molecularCalculatorSwitch.backgroundColor = XTRColorFactory.switchBackgroundColor
        molecularCalculatorSwitch.cornerRadius = SWITCH_CORNER_RADIUS
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscape
    }
    
    // MARK: - Memory Management Methods
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: .inspectorDismissedNotification, object: nil)
        swapView = nil
        molecularCalculatorSwitch = nil
        navigationBar = nil
    }
    
}
