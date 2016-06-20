//
//  XTRTransitionController.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 5/18/16.
//  Copyright © 2016 xTrensa. All rights reserved.
//

import UIKit

@objc class XTRSimpleTransitionController : NSObject, UIViewControllerAnimatedTransitioning {

    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 0.35
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        //let fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)
        let toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
        transitionContext.containerView().addSubview(toViewController.view)
        toViewController.view.alpha = 0.0
        UIView.animateWithDuration(0.35, animations: {
            toViewController.view.alpha = 1.0
            }, completion: { (finished) in
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
        })
    }

}
