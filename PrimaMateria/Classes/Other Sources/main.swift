//
//  main.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 4/20/16.
//  Copyright © 2018 xTrensa. All rights reserved.
//

import UIKit

_ = UIApplicationMain(
    CommandLine.argc,
    UnsafeMutablePointer(CommandLine.unsafeArgv),
    NSStringFromClass(XTRAppDelegate.self),
    NSStringFromClass(XTRAppDelegate.self)
)
//_ = UIApplicationMain(
//    CommandLine.argc,
//    UnsafeMutablePointer(CommandLine.unsafeArgv).bindMemory(to: UnsafeMutablePointer<Int8>.self, capacity: Int(CommandLine.argc)),
//    NSStringFromClass(XTRAppDelegate.self),
//    NSStringFromClass(XTRAppDelegate.self)
//)

//UIApplicationMain' is deprecated: Use the overload of UIApplicationMain where the type of the second parameter is UnsafeMutablePointer<UnsafeMutablePointer<Int8>?>, which is the same as the type of CommandLine.unsafeArgv.
