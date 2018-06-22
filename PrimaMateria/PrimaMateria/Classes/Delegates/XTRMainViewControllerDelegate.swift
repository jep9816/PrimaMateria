//
//  XTRMainViewControllerDelegate.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 6/21/18.
//  Copyright © 2018 xTrensa. All rights reserved.
//

class XTRMainViewControllerDelegate : NSObject, UITabBarControllerDelegate {

    func tabBarController(_ tabBarController: UITabBarController, animationControllerForTransitionFrom fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let defaultState = XTRPropertiesStore.showTransitionsState
        
        if defaultState {
            //return XTRPopoutAnimationController()
            // XTRSlideDownAnimationController()
            return XTRSimpleTransitionController()
        }
        return nil
    }

}
