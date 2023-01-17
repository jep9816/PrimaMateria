//
//  UIViewController+Extensions.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 6/10/21.
//  Copyright ©2023 Jerry Porter. All rights reserved.
//

import UIKit

extension UIViewController {
    
    static func loadFromNib() -> Self {
        func instantiateFromNib<T: UIViewController>() -> T {
            return T.init(nibName: String(describing: T.self), bundle: nil)
        }

        return instantiateFromNib()
    }
    
}
