//
//  XTRHelpButton.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 4/14/16.
//  Copyright ©2021 xTrensa. All rights reserved.
//

import UIKit

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
        let content = XTRAppDelegate.storyboard().instantiateViewController(withIdentifier: XTRHelpBalloonViewController.nameOfClass) as! XTRHelpBalloonViewController

        content.preferredContentSize = CGSize(width: 410, height: 338)
        content.modalPresentationStyle = .popover
        controller.present(content, animated: XTRPropertiesStore.showTransitionsState, completion: nil)
        let presentationController = content.popoverPresentationController
        presentationController?.sourceRect = bounds
        presentationController?.sourceView = self
        presentationController?.backgroundColor = XTRColorFactory.popupArrowColor
        NotificationCenter.default.post(name: .elementHelpSelectedNotification, object: label)
    }

    deinit {
        NotificationCenter.default.removeObserver(self, name: .notificationAppearanceChanged, object: nil)
        NotificationCenter.default.removeObserver(self, name: .notificationAtomicStructureZoomed, object: nil)
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
