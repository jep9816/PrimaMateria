//
//  UIColor-Extensions.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 4/22/16.
//  Copyright © 2016 xTrensa. All rights reserved.
//

extension UIColor {
    func inverseColor() -> UIColor {
        var r:CGFloat = 0.0; var g:CGFloat = 0.0; var b:CGFloat = 0.0; var a:CGFloat = 0.0;
        if self.getRed(&r, green: &g, blue: &b, alpha: &a) {
            return UIColor(red: 1.0-r, green: 1.0 - g, blue: 1.0 - b, alpha: a)
        }
        return self
    }

    /*class func reverseColorOf(oldColor: UIColor) -> UIColor {
        let oldCGColor: CGColorRef = oldColor.CGColor
        let numberOfComponents: Int = CGColorGetNumberOfComponents(oldCGColor)
        // can not invert - the only component is the alpha
        if numberOfComponents == 1 {
            return UIColor(CGColor: oldCGColor)
        }
        let oldComponentColors: UnsafePointer<CGFloat> = CGColorGetComponents(oldCGColor)
        var newComponentColors = [CGFloat]()
        let i: Int = numberOfComponents - 1
        newComponentColors[i] = oldComponentColors[i]
        // alpha
        
        for index in (0...i).reverse() {
            newComponentColors[index] = 1 - oldComponentColors[index]
        }
        
        //        while --i >= 0 {
        //            newComponentColors[i] = 1 - oldComponentColors[i]
        //        }
        let newCGColor: CGColorRef = CGColorCreate(CGColorGetColorSpace(oldCGColor), newComponentColors)!
        var newColor: UIColor = UIColor(CGColor: newCGColor)
        
        //=====For the GRAY colors 'Middle level colors'
        var white: CGFloat = 0
        oldColor.getWhite(&white, alpha: nil)
        if(white>0.3 && white < 0.67) {
            if(white >= 0.5) {
                newColor = UIColor.darkGrayColor()
            } else if (white < 0.5) {
                newColor = UIColor.blackColor()
            }
        }
        return newColor;
    }*/
}
