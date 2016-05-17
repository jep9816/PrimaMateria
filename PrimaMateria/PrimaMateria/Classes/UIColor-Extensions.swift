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
}
