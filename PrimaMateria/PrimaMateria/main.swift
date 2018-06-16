//
//  main.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 4/20/16.
//  Copyright ©2018 xTrensa. All rights reserved.
//

import Foundation
import UIKit

UIApplicationMain(
    CommandLine.argc,
    UnsafeMutableRawPointer(CommandLine.unsafeArgv).bindMemory(to: UnsafeMutablePointer<Int8>.self, capacity: Int(CommandLine.argc)),
    NSStringFromClass(XTRApplication.self),
    NSStringFromClass(XTRAppDelegate.self)
)
