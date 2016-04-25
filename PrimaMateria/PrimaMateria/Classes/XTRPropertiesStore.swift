//
//  XTRPropertiesStore.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 4/15/16.
//  Copyright © 2016 xTrensa. All rights reserved.
//

@objc class XTRPropertiesStore : NSObject {
    
    class func retreiveAtomicNumber() -> NSNumber {
        let userDefaults : NSUserDefaults = NSUserDefaults.standardUserDefaults()
        var defaultValue : NSNumber? = userDefaults.valueForKey(ELEMENT_ATOMIC_NUMBER) as? NSNumber
        
        if (defaultValue == nil) {
            defaultValue = 1;
            XTRPropertiesStore.storeAtomicNumber(defaultValue!)
        }
        return defaultValue!;
    }
    
    class func storeAtomicNumber(aValue: NSNumber?)  {
        if (aValue != nil) {
            let userDefaults : NSUserDefaults = NSUserDefaults.standardUserDefaults()
            
            userDefaults.setValue(aValue, forKey: ELEMENT_ATOMIC_NUMBER)
            userDefaults.synchronize()
        }
    }
    
    class func retreiveViewTitle() -> String {
        let userDefaults : NSUserDefaults = NSUserDefaults.standardUserDefaults()
        var defaultValue : String? = userDefaults.stringForKey(VIEW_TITLE_KEY)
        
        if (defaultValue == nil) {
            defaultValue = "None";
            XTRPropertiesStore.storeViewTitle(defaultValue!)
        }
        return defaultValue!;
    }
    
    class func storeViewTitle(aValue: String?) {
        if (aValue != nil) {
            let userDefaults : NSUserDefaults = NSUserDefaults.standardUserDefaults()
            
            userDefaults.setValue(aValue, forKey: VIEW_TITLE_KEY)
            userDefaults.synchronize()
        }
    }
    
    class func retreiveSplashScreenState() -> Bool {
        return NSUserDefaults.standardUserDefaults().boolForKey(SPLASH_SCREEN_DEFAULT)
    }
    
    class func storeSplashScreenState(aValue: Bool) {
        let userDefaults : NSUserDefaults = NSUserDefaults.standardUserDefaults()
        
        userDefaults.setBool(aValue, forKey: SPLASH_SCREEN_DEFAULT)
        userDefaults.synchronize()
    }
    
    class func retreiveShowTransitionsState() -> Bool {
        return NSUserDefaults.standardUserDefaults().boolForKey(SHOW_TRANSITIONS_DEFAULT)
    }
    
    class func storeShowTranitionsState(aValue: Bool) {
        let userDefaults : NSUserDefaults = NSUserDefaults.standardUserDefaults()
        
        userDefaults.setBool(aValue, forKey: SHOW_TRANSITIONS_DEFAULT)
        userDefaults.synchronize()
    }
    
    class func retreiveElementBubblesState() -> Bool {
        return NSUserDefaults.standardUserDefaults().boolForKey(ELEMENT_BUBBLE_DEFAULT)
    }
    
    class func storeElementBubblesState(aValue: Bool) {
        let userDefaults : NSUserDefaults = NSUserDefaults.standardUserDefaults()
        
        userDefaults.setBool(aValue, forKey: ELEMENT_BUBBLE_DEFAULT)
        userDefaults.synchronize()
    }
    
    class func retreiveColorDataForColorKey(aColorKey: String?) -> NSData? {
        let userDefaults : NSUserDefaults = NSUserDefaults.standardUserDefaults()
        return userDefaults.objectForKey(aColorKey!) as? NSData
    }
    
    class func storeColorData(colorData: NSData!, forColorKey: String!) {
        if (colorData != nil && forColorKey != nil) {
            let userDefaults : NSUserDefaults = NSUserDefaults.standardUserDefaults()
            
            userDefaults.setObject(colorData, forKey: forColorKey)
            userDefaults.synchronize()
        }
    }
    
    class func resetPreferences() {
        let userDefaults : NSUserDefaults = NSUserDefaults.standardUserDefaults()
        
        userDefaults.removeObjectForKey(ELEMENT_BUBBLE_DEFAULT)
        userDefaults.removeObjectForKey(SERIES_ACTINIDE)
        userDefaults.removeObjectForKey(SERIES_ALKALI_EARTH_METAL)
        userDefaults.removeObjectForKey(SERIES_ALKALI_METAL)
        userDefaults.removeObjectForKey(SERIES_HALOGEN)
        userDefaults.removeObjectForKey(SERIES_LANTHANIDE)
        userDefaults.removeObjectForKey(SERIES_METAL)
        userDefaults.removeObjectForKey(SERIES_NOBLE_GAS)
        userDefaults.removeObjectForKey(SERIES_NON_METAL)
        userDefaults.removeObjectForKey(SERIES_TRANSACTINIDES)
        userDefaults.removeObjectForKey(SERIES_TRANSITION_METAL)
        userDefaults.synchronize()
    }
}