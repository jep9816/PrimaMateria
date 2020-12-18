//
//  UIImage+Extensions.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 4/22/16.
//  Copyright ©2020 xTrensa. All rights reserved.
//

import UIKit

extension UIImage {
    
    class func imageFromColor(_ color: UIColor, andSize size: CGSize) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()!
        context.setFillColor(color.cgColor)
        context.fill(rect)
        
        let img = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return img
    }
    
}
