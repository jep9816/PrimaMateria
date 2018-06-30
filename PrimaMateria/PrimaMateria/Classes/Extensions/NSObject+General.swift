//
//  NSObject+General.swift
//  PlaneBalance
//
//  Created by Jerry Porter on 12/6/16.
//  Copyright © 2018 xTrensa. All rights reserved.
//

import UIKit

public extension NSObject { // General
    
    public class var nameOfClass: String {
        return String(describing: self)
    }
    
    public func double(_ key: String?) -> Double {
        var doubleValue = 0.0
        
        if let doubleString = value(forKeyPath: key!) as! String?  {
            if let doubleNumber = NumberFormatter().number(from: doubleString) {
                doubleValue = doubleNumber.doubleValue
            }
        }
        
        return doubleValue
    }
    
}

extension UILabel {
    
    var localizedText: String {
        set (key) {
            text = NSLocalizedString(key, comment: "")
        }
        get {
            return text!
        }
    }
    
}
