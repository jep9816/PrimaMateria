//
//  UIView+LayerFlattening.swift
//  PlaneBalance
//
//  Created by Jerry Porter on 10/11/16.
//  Copyright ©2020 xTrensa. All rights reserved.
//

import UIKit

extension UIView { // Layer Flattening
    
    var borderColor: UIColor {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set(aValue) {
            layer.borderColor = aValue.cgColor
        }
    }
    
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set(aValue) {
            layer.borderWidth = aValue
        }
    }
    
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set(aValue) {
            layer.cornerRadius = aValue
        }
    }
    
    var masksToBounds: Bool {
        get {
            return layer.masksToBounds
        }
        set(aValue) {
            layer.masksToBounds = aValue
        }
    }
    
    var shadowColor: UIColor {
        get {
            return UIColor(cgColor: layer.shadowColor!)
        }
        set(aValue) {
            layer.shadowColor = aValue.cgColor
        }
    }
    
    var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set(aValue) {
            layer.shadowOffset = aValue
        }
    }
    
    var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set(aValue) {
            layer.shadowOpacity = aValue
        }
    }
    
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set(aValue) {
            layer.shadowRadius = aValue
        }
    }
    
    var maskedCorners: CACornerMask {
        get {
            return layer.maskedCorners
        }
        set(aValue) {
            layer.maskedCorners = aValue
        }
    }

}
