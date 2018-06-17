//
//  NSObject+General.swift
//  PlaneBalance
//
//  Created by Jerry Porter on 12/6/16.
//  Copyright ©2018 xTrensa. All rights reserved.
//

import UIKit

public extension NSObject { // General
    
    public class var nameOfClass: String {
        return String(describing: self)
    }
    
}
