//
//  BundleExtensions.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 4/14/16.
//  Copyright ©2018 xTrensa. All rights reserved.
//

public extension Bundle {
    
    var appNameString: String? {
        return infoDictionary!["CFBundleDisplayName"] as? String
    }
    
    var appVersionString: String? {
        return infoDictionary!["CFBundleShortVersionString"] as? String
    }
    
    var copywriteString: String? {
        return infoDictionary!["CFBundleGetInfoString"] as? String
    }
    
}
