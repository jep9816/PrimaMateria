//
//  XTRHelpButton.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 4/14/16.
//  Copyright ©2021 xTrensa. All rights reserved.
//

import UIKit
import SwiftUI

class XTRHelpButton: UIButton, UIPopoverPresentationControllerDelegate {

    // MARK: - Initialization Methods

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        setupColors()
        NotificationCenter.default.addObserver(self, selector: #selector(changeAppearance(notification:)), name: .notificationAppearanceChanged, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(atomicStructureZoomed(_:)), name: .notificationAtomicStructureZoomed, object: nil)
    }

    // MARK: - Internal Methods

    func viewController() -> UIViewController {
        var responder: UIResponder? = self

        while !responder!.isKind(of: UIViewController.classForCoder()) {
            responder = responder!.next!

            if responder == nil {
                break
            }
        }

        return responder as! UIViewController
    }

    func setupColors() {
        cornerRadius = VIEW_CORNER_RADIUS
        masksToBounds = true
        borderColor = XTRColorFactory.helpButtonBorderColor
        borderWidth = 2.0
        setTitleShadowColor(UIColor.clear, for: UIControl.State())

        if var titleFrame = titleLabel?.frame {
            titleFrame.size = bounds.size
            titleFrame.origin = .zero
            titleLabel!.frame = titleFrame
            titleLabel!.textAlignment = .center
        }
    }

    // MARK: - Misc Methods

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let label = title(for: .disabled) else { return }

        let controller = viewController()
        
        // SwiftUI implementation
        let helpBalloon = XTRHelpBalloonView()
        helpBalloon.webViewStateModel.pageTitle = NSLocalizedString("help", comment: "Help")
        let environment: HelpBallonEnvironment = HelpBallonEnvironment()
        environment.elementTipPath = elementTipPath(documentName: label)
        let helpBalloonViewController = UIHostingController(rootView: helpBalloon.environmentObject(environment))
        helpBalloonViewController.preferredContentSize = helpBalloonViewController.sizeThatFits(in: XTRHelpBalloonViewConfig.preferredContentSize)
        helpBalloonViewController.modalPresentationStyle = .popover

        // Legacy implementation
        //let helpBalloonViewController = XTRHelpBalloonViewController.loadFromNib()
        
        //helpBalloonViewController.modalPresentationStyle = .popover
        //helpBalloonViewController.preferredContentSize = XTRHelpBalloonViewControllerConfig.preferredContentSize
        
        controller.present(helpBalloonViewController, animated: XTRPropertiesStore.showTransitionsState, completion: nil)
        let presentationController = helpBalloonViewController.popoverPresentationController
        presentationController?.sourceRect = bounds
        presentationController?.sourceView = self
        presentationController?.backgroundColor = XTRColorFactory.popupArrowColor
        NotificationCenter.default.post(name: .elementHelpSelectedNotification, object: label)
    }

    deinit {
        NotificationCenter.default.removeObserver(self, name: .notificationAppearanceChanged, object: nil)
        NotificationCenter.default.removeObserver(self, name: .notificationAtomicStructureZoomed, object: nil)
    }

    func elementTipPath(documentName: String) -> String {
        guard let path = Bundle.main.path(forResource: documentName, ofType: FileType.html, inDirectory: "ElementTipHelp/\(XTRPropertiesStore.currentLanguageCode)") else { return "" }
        return path
    }

}

extension XTRHelpButton {

    @objc func atomicStructureZoomed(_ aNotification: Notification) {
        let flag = aNotification.object as! Bool

        isUserInteractionEnabled = flag
    }

    @objc func changeAppearance(notification: NSNotification) {
        borderColor = XTRColorFactory.helpButtonBorderColor
    }

}
