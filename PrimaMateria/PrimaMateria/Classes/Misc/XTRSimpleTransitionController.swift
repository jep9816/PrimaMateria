//
//  XTRTransitionController.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 5/18/16.
//  Copyright ©2018 xTrensa. All rights reserved.
//

import UIKit

class XTRSimpleTransitionController : NSObject, UIViewControllerAnimatedTransitioning {

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.35
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!
        
        transitionContext.containerView.addSubview(toViewController.view)
        toViewController.view.alpha = 0.0
        UIView.animate(withDuration: 0.35, animations: {
            toViewController.view.alpha = 1.0
            }, completion: { (finished) in
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }

}
