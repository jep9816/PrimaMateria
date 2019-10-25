//
//  XTRPropertiesStore.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 4/15/16.
//  Copyright © 2019 xTrensa. All rights reserved.
//

import UIKit

struct XTRPropertiesStoreConfig {
    static let appearanceName = "appearanceName"
    static let elementBubble = "elementBubbleState"
    static let showTransitions = "showViewTransitionsState"
    static let splashScreen = "splashScreenState"
    static let atomicNumber = "atomicNumber"
    static let viewTitle = "viewTitle"
    static let noneValue = "None"
}

class XTRPropertiesStore: NSObject {
    
    class var currentLanguageCode: String {
        get {
            let userDefaults = UserDefaults.standard
            guard let defaultValue = userDefaults.value(forKeyPath: "AppleLanguage") as? String else {
                XTRPropertiesStore.atomicNumber = 1
                userDefaults.set("en", forKey: "AppleLanguage")
                userDefaults.synchronize()

                return "en"
            }

            return defaultValue
        }
        
        set {
            let userDefaults = UserDefaults.standard
            userDefaults.set(newValue, forKey: "AppleLanguage")
            userDefaults.synchronize()
        }
    }

    class var atomicNumber: Int {
        get {
            let userDefaults = UserDefaults.standard
            guard let defaultValue = userDefaults.value(forKeyPath: XTRPropertiesStoreConfig.atomicNumber) as? Int else {
                XTRPropertiesStore.atomicNumber = 1
                return 1
            }
            
            return defaultValue
        }
        
        set {
            let userDefaults = UserDefaults.standard
            
            userDefaults.set(newValue, forKey: XTRPropertiesStoreConfig.atomicNumber)
            userDefaults.synchronize()
        }
    }
    
    class var viewTitle: String {
        get {
            let userDefaults = UserDefaults.standard
            guard let defaultValue = userDefaults.value(forKeyPath: XTRPropertiesStoreConfig.viewTitle) as? String else {
                XTRPropertiesStore.viewTitle = XTRPropertiesStoreConfig.noneValue
                return XTRPropertiesStoreConfig.noneValue
            }
            
            return defaultValue
        }
        
        set {
            let userDefaults = UserDefaults.standard
            
            userDefaults.set(newValue, forKey: XTRPropertiesStoreConfig.viewTitle)
            userDefaults.synchronize()
        }
    }

    class var splashScreenState: Bool {
        get {
            let userDefaults = UserDefaults.standard
            guard let defaultValue = userDefaults.value(forKeyPath: XTRPropertiesStoreConfig.splashScreen) as? Bool else {
                XTRPropertiesStore.splashScreenState = false
                return false
            }
            
            return defaultValue
        }
        
        set {
            let userDefaults = UserDefaults.standard
            
            userDefaults.set(newValue, forKey: XTRPropertiesStoreConfig.splashScreen)
            userDefaults.synchronize()
        }
    }

    class var showTransitionsState: Bool {
        get {
            let userDefaults = UserDefaults.standard
            guard let defaultValue = userDefaults.value(forKeyPath: XTRPropertiesStoreConfig.showTransitions) as? Bool else {
                XTRPropertiesStore.showTransitionsState = false
                return false
            }
            
            return defaultValue
        }
        
        set {
            let userDefaults = UserDefaults.standard
            
            userDefaults.set(newValue, forKey: XTRPropertiesStoreConfig.showTransitions)
            userDefaults.synchronize()
        }
    }

    class var elementBubblesState: Bool {
        get {
            let userDefaults = UserDefaults.standard
            guard let defaultValue = userDefaults.value(forKeyPath: XTRPropertiesStoreConfig.elementBubble) as? Bool else {
                XTRPropertiesStore.elementBubblesState = false
                return false
            }
            
            return defaultValue
        }
        
        set {
            let userDefaults = UserDefaults.standard
            
            userDefaults.set(newValue, forKey: XTRPropertiesStoreConfig.elementBubble)
            userDefaults.synchronize()
        }
    }

    class func getColorDataForKey(_ key: String?) -> Data? {
        let userDefaults = UserDefaults.standard
        return userDefaults.object(forKey: key!) as? Data
    }
    
    class func setColorData(_ data: Data!, key: String!) {
        if data != nil && key != nil {
            let userDefaults: UserDefaults = UserDefaults.standard
            
            userDefaults.set(data, forKey: key)
            userDefaults.synchronize()
        }
    }
    
    // MARK: - Appearance Name
    
    class var appearanceName: String {
        get {
            guard let objectValue = UserDefaults.standard.value(forKey: XTRPropertiesStoreConfig.appearanceName) as? String else {
                XTRPropertiesStore.appearanceName = XTRAppearanceType.classic
                return XTRAppearanceType.classic
            }
            
            return objectValue
        }
        
        set(aValue) {
            let defaults = UserDefaults.standard
            defaults.set(aValue, forKey: XTRPropertiesStoreConfig.appearanceName)
            defaults.synchronize()
        }
    }

    class func resetPreferences() {
        let userDefaults = UserDefaults.standard
        
        userDefaults.removeObject(forKey: XTRPropertiesStoreConfig.elementBubble)
        userDefaults.removeObject(forKey: XTRPropertiesStoreConfig.showTransitions)
        userDefaults.removeObject(forKey: XTRPropertiesStoreConfig.splashScreen)
        userDefaults.removeObject(forKey: XTRPropertiesStoreConfig.splashScreen)
        userDefaults.removeObject(forKey: XTRPropertiesStoreConfig.appearanceName)

        userDefaults.removeObject(forKey: ElementSeries.actinide)
        userDefaults.removeObject(forKey: ElementSeries.alkaliEarthMetal)
        userDefaults.removeObject(forKey: ElementSeries.alkaliMetal)
        userDefaults.removeObject(forKey: ElementSeries.halogen)
        userDefaults.removeObject(forKey: ElementSeries.lanthanide)
        userDefaults.removeObject(forKey: ElementSeries.metal)
        userDefaults.removeObject(forKey: ElementSeries.nobleGas)
        userDefaults.removeObject(forKey: ElementSeries.nonMetal)
        userDefaults.removeObject(forKey: ElementSeries.transactinide)
        userDefaults.removeObject(forKey: ElementSeries.transitionMetal)
        
        userDefaults.synchronize()
    }
    
}
