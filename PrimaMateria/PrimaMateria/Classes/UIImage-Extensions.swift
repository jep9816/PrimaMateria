//
//  UIImage-Extensions.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 4/22/16.
//  Copyright © 2016 xTrensa. All rights reserved.
//

extension UIImage {
    class func imageFromColor(color: UIColor, andSize size: CGSize) -> UIImage {
        let rect : CGRect = CGRectMake(0, 0, size.width, size.height);
        UIGraphicsBeginImageContext(rect.size);
        let context : CGContextRef = UIGraphicsGetCurrentContext()!;
        CGContextSetFillColorWithColor(context, color.CGColor);
        CGContextFillRect(context, rect);
        
        let img : UIImage = UIGraphicsGetImageFromCurrentImageContext()!;
        UIGraphicsEndImageContext();
        
        return img;
    }
}
