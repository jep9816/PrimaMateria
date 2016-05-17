//
//  HelpButton.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 4/14/16.
//  Copyright © 2016 xTrensa. All rights reserved.
//

@objc class HelpButton : UIButton, UIPopoverPresentationControllerDelegate {
    
    // MARK: - Initialization Methods
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)!
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 8.0
        self.layer.masksToBounds = true
    }
    
    // MARK: - Internal Methods
    
    func viewController() -> UIViewController {
        var responder: UIResponder? = self
        
        while !(responder!.isKindOfClass(UIViewController.classForCoder())) {
            responder = responder!.nextResponder()!
            if responder == nil {
                break
            }
        }
        return responder as! UIViewController
    }
    
    func setupColors() {
        self.backgroundColor = UIColor.yellowColor()
        self.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        self.titleEdgeInsets = UIEdgeInsetsMake(0, -5, 0, 0);
    }
    
    // MARK: - Misc Methods
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let label : String? = self.titleForState(UIControlState.Disabled)!
        
        if(label != nil) {
            let controller : UIViewController = self.viewController();
            let content : XTRHelpBalloonViewController = XTRAppDelegate.storyboard().instantiateViewControllerWithIdentifier("XTRHelpBalloonViewController") as! XTRHelpBalloonViewController
            let aFrame : CGRect = self.bounds
            let aRect : CGRect?
            
            if(label == "periodicTable") {
                aRect = CGRectMake(5, 5, aFrame.size.width - 15, aFrame.size.height);
            } else {
                aRect = CGRectMake(0, 0, aFrame.size.width - 5, aFrame.size.height - 5);
            }
            
            content.preferredContentSize = CGSizeMake(410, 338);
            content.modalPresentationStyle = UIModalPresentationStyle.Popover;
            content.popoverPresentationController!.sourceRect = aRect!;
            content.popoverPresentationController!.sourceView = self;
            controller.presentViewController(content, animated:true, completion:nil)
            content.popoverPresentationController!.backgroundColor = XTRColorFactory.popupArrowColor()
            NSNotificationCenter.defaultCenter().postNotificationName(NOTIFICATION_ELEMENT_HELP_SELECTED, object: label)
        }
    }
}
