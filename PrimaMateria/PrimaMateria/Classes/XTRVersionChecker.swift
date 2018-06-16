//
//  XTRVersionChecker.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 4/14/16.
//  Copyright ©2018 xTrensa. All rights reserved.
//

class XTRVersionChecker : NSObject {
    
    class var appNameString: String? {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") as? String
    }
    
    class var appVersionString: String? {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
    }
    
    class var copywriteString: String? {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleGetInfoString") as? String
    }
    
}
