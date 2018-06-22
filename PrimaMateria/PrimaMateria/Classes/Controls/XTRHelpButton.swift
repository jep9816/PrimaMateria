//
//  XTRHelpButton.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 4/14/16.
//  Copyright ©2018 xTrensa. All rights reserved.
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
        backgroundColor = UIColor.yellow
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
        let aFrame = bounds
        let aRect : CGRect? = (label == "periodicTable") ? CGRect(x: 5, y: 5, width: aFrame.size.width - 15, height: aFrame.size.height) : CGRect(x: 0, y: 0, width: aFrame.size.width - 5, height: aFrame.size.height - 5)
        
        content.preferredContentSize = CGSize(width: 410, height: 338)
        content.modalPresentationStyle = .popover
        content.popoverPresentationController!.sourceRect = aRect!
        content.popoverPresentationController!.sourceView = self
        controller.present(content, animated:true, completion:nil)
        content.popoverPresentationController!.backgroundColor = XTRColorFactory.popupArrowColor
        NotificationCenter.default.post(name: .elementHelpSelectedNotification, object: label)
    }
    
}