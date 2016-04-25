//
//  XTRVersionChecker.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 4/14/16.
//  Copyright © 2016 xTrensa. All rights reserved.
//

@objc class XTRVersionChecker : NSObject {
    
    class func appNameString() -> String? {
        return NSBundle.mainBundle().objectForInfoDictionaryKey("CFBundleDisplayName") as? String
    }
    
    class func appVersionString() -> String? {
        return NSBundle.mainBundle().objectForInfoDictionaryKey("CFBundleShortVersionString") as? String
    }
    
    class func copywriteString() -> String? {
        return NSBundle.mainBundle().objectForInfoDictionaryKey("CFBundleGetInfoString") as? String
    }
}
