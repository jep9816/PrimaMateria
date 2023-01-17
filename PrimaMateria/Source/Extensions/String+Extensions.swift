//
//  String+Extensions.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 10/23/19.
//  Copyright ©2023 Jerry Porter. All rights reserved.
//

import UIKit

extension String {

    func image() -> UIImage? {
        let size = CGSize(width: 40, height: 40)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        UIColor.clear.set()
        let rect = CGRect(origin: .zero, size: size)
        UIRectFill(CGRect(origin: .zero, size: size))
        (self as AnyObject).draw(in: rect, withAttributes: [.font: XTRFontFactory.systemFont40])
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }

}
