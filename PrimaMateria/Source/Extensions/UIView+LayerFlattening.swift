//
//  UIView+LayerFlattening.swift
//  PlaneBalance
//
//  Created by Jerry Porter on 10/11/16.
//  Copyright ©2023 xTrensa. All rights reserved.
//

import UIKit

extension UIView { // Layer Flattening

    var borderColor: UIColor {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue.cgColor
        }
    }

    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }

    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }

    var masksToBounds: Bool {
        get {
            return layer.masksToBounds
        }
        set {
            layer.masksToBounds = newValue
        }
    }

    var shadowColor: UIColor {
        get {
            return UIColor(cgColor: layer.shadowColor!)
        }
        set {
            layer.shadowColor = newValue.cgColor
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
        set {
            layer.shadowRadius = newValue
        }
    }

    var maskedCorners: CACornerMask {
        get {
            return layer.maskedCorners
        }
        set {
            layer.maskedCorners = newValue
        }
    }

}
