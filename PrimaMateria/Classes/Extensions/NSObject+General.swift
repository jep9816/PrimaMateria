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
        
        if let doubleString = value(forKeyPath: key!) as! String? {
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

extension String {
    
    func image(size: CGSize) -> UIImage? {
        //let size = CGSize(width: 40, height: 40)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        UIColor.clear.set()
        let rect = CGRect(origin: .zero, size: size)
        UIRectFill(CGRect(origin: .zero, size: size))
        (self as AnyObject).draw(in: rect, withAttributes: [.font: UIFont.systemFont(ofSize: 40)])
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    func capitalizingFirstLetter() -> String {
        return prefix(1).uppercased() + dropFirst()
    }
    
    func lowercasingFirstLetter() -> String {
        return prefix(1).lowercased() + dropFirst()
    }

    var camelCasedString: String {
        return self.components(separatedBy: " ")
            .map { return $0.lowercased().capitalizingFirstLetter() }
            .joined()
    }
    
}
