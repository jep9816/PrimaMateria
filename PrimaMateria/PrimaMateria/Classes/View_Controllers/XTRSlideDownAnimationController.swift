//
//  XTRSlideDownAnimationController.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 5/18/16.
//  Copyright © 2018 xTrensa. All rights reserved.
//

import UIKit

class XTRSlideDownAnimationController : NSObject, UIViewControllerAnimatedTransitioning {
    
    let duration :TimeInterval = 0.5
    
    // ---- UIViewControllerAnimatedTransitioning methods
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning)  {
        animatePresentationWithTransitionContext(transitionContext)
    }
    
    // ---- Helper methods
    
    func animatePresentationWithTransitionContext(_ transitionContext: UIViewControllerContextTransitioning) {
        guard let presentedController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to),
            let presentedControllerView = transitionContext.view(forKey: UITransitionContextViewKey.to) else { return }
        let containerView : UIView = transitionContext.containerView
        
        // Position the presented view off the top of the container view
        presentedControllerView.frame = transitionContext.finalFrame(for: presentedController)
        presentedControllerView.center.y -= containerView.bounds.size.height
        
        containerView.addSubview(presentedControllerView)
        
        // Animate the presented view to it's final position
        UIView.animate(withDuration: duration, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.0, options: .allowUserInteraction, animations: {
            presentedControllerView.center.y += containerView.bounds.size.height
        }, completion: {(completed: Bool) -> Void in
            transitionContext.completeTransition(completed)
        })
    }
    
}
