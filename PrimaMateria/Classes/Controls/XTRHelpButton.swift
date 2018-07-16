//
//  XTRHelpButton.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 4/14/16.
//  Copyright © 2018 xTrensa. All rights reserved.
//

class XTRHelpButton : UIButton, UIPopoverPresentationControllerDelegate {
    
    // MARK: - Initialization Methods
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)!
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupColors()
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
        backgroundColor = XTRColorFactory.helpBackgroundColor
        setTitleColor(UIColor.black, for: UIControlState())
        layer.cornerRadius = 8.0
        layer.masksToBounds = true
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 1.0
        
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
        controller.present(content, animated: true, completion: nil)
        let presentationController = content.popoverPresentationController
        presentationController?.sourceRect = bounds
        presentationController?.sourceView = self
        presentationController?.backgroundColor = XTRColorFactory.popupArrowColor
        NotificationCenter.default.post(name: .elementHelpSelectedNotification, object: label)
    }
    
}
