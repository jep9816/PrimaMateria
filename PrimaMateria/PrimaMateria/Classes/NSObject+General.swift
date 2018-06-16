//
//  NSObject+General.swift
//  PlaneBalance
//
//  Created by Jerry Porter on 12/6/16.
//  This software constitutes proprietary information and copyrighted material
//  of Gulfstream Aerospace Corporation ("Gulfstream"), and is provided under
//  license and not sold. All rights reserved. Gulfstream retains all copyright,
//  trades secret, patent, and other intellectual property rights. No part of
//  this work may be reproduced, copied, decompiled, reverse assembled, reverse
//  engineered or used in the creation of derivative works.
//  Copyright ©2018 Gulfstream Aerospace Corporation. All rights reserved.
//

import UIKit

public extension NSObject { // General
    
    public class var nameOfClass: String {
        return String(describing: self)
    }
    
}
