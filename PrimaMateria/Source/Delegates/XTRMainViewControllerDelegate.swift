//
//  XTRMainViewControllerDelegate.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 6/21/18.
//  Copyright ©2021 xTrensa. All rights reserved.
//

import Foundation
import UIKit

class XTRMainViewControllerDelegate: NSObject, UITabBarControllerDelegate {

    func tabBarController(_ tabBarController: UITabBarController, animationControllerForTransitionFrom fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let defaultState = XTRPropertiesStore.showTransitionsState

        // TODO: add ability to choose transition type
        if defaultState {
            // return XTRPopoutAnimationController()
            // return XTRSlideDownAnimationController()
            return XTRSimpleTransitionController()
        }

        return nil
    }

}
