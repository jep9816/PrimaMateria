//
//  XTRSlideDownAnimationController.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 5/18/16.
//  Copyright © 2016 xTrensa. All rights reserved.
//

import UIKit

@objc class XTRSlideDownAnimationController : NSObject, UIViewControllerAnimatedTransitioning {
    let duration :NSTimeInterval = 0.5
    
    // ---- UIViewControllerAnimatedTransitioning methods
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return self.duration
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning)  {
        animatePresentationWithTransitionContext(transitionContext)
    }
    
    
    // ---- Helper methods
    
    func animatePresentationWithTransitionContext(transitionContext: UIViewControllerContextTransitioning) {
        guard let presentedController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey),
            let presentedControllerView = transitionContext.viewForKey(UITransitionContextToViewKey),
            let containerView : UIView = transitionContext.containerView() else { return }
        
        // Position the presented view off the top of the container view
        presentedControllerView.frame = transitionContext.finalFrameForViewController(presentedController)
        presentedControllerView.center.y -= containerView.bounds.size.height
        
        containerView.addSubview(presentedControllerView)
        
        // Animate the presented view to it's final position
        UIView.animateWithDuration(self.duration, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.0, options: .AllowUserInteraction, animations: {
            presentedControllerView.center.y += containerView.bounds.size.height
            }, completion: {(completed: Bool) -> Void in
                transitionContext.completeTransition(completed)
        })
    }
    
}
