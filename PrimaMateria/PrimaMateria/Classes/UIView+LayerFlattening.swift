//
//  UIView+LayerFlattening.swift
//  PlaneBalance
//
//  Created by Jerry Porter on 10/11/16.
//  This software constitutes proprietary information and copyrighted material
//  of Gulfstream Aerospace Corporation ("Gulfstream"), and is provided under
//  license and not sold. All rights reserved. Gulfstream retains all copyright,
//  trades secret, patent, and other intellectual property rights. No part of
//  this work may be reproduced, copied, decompiled, reverse assembled, reverse
//  engineered or used in the creation of derivative works.
//  Copyright ©2018 Gulfstream Aerospace Corporation. All rights reserved.
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
    
}
