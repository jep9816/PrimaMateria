//
//  XTRPopoutAnimationController.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 5/18/16.
//  Copyright ©2023 xTrensa. All rights reserved.
//

import UIKit

class XTRPopoutAnimationController: NSObject, UIViewControllerAnimatedTransitioning {

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.35
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let fromViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)!
        let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!
        let containerView = transitionContext.containerView

        let animationDuration = transitionDuration(using: transitionContext)

        // take a snapshot of the detail ViewController so we can do whatever with it (cause it's only a view), and don't have to care about breaking constraints
        let snapshotView = toViewController.view.resizableSnapshotView(from: toViewController.view.frame, afterScreenUpdates: true, withCapInsets: UIEdgeInsets.zero)
        snapshotView!.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        snapshotView!.center = fromViewController.view.center
        containerView.addSubview(snapshotView!)

        // hide the detail view until the snapshot is being animated
        toViewController.view.alpha = 0.0
        containerView.addSubview(toViewController.view)

        UIView.animate(withDuration: animationDuration, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 20.0, options: [], animations: { () -> Void in
            snapshotView!.transform = CGAffineTransform.identity
        }, completion: { (finished) -> Void in
            snapshotView!.removeFromSuperview()
            toViewController.view.alpha = 1.0
            transitionContext.completeTransition(finished)
        })
    }

}
