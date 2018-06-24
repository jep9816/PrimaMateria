//
//  XTRPropertiesStore.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 4/15/16.
//  Copyright ©2018 xTrensa. All rights reserved.
//

import UIKit

struct XTRProperty {
    static let elementBubble = "elementBubbleState"
    static let showTransitions = "showViewTransitionsState"
    static let splashScreen = "splashScreenState"
    static let atomicNumber = "atomicNumber"
    static let viewTitle = "viewTitle"
}

class XTRPropertiesStore : NSObject {
    
    class var atomicNumber: Int {
        get {
            let userDefaults = UserDefaults.standard
            guard let defaultValue = userDefaults.value(forKeyPath: XTRProperty.atomicNumber) as? Int else {
                XTRPropertiesStore.atomicNumber = 1
                return 1
            }
            
            return defaultValue
        }
        
        set {
            let userDefaults = UserDefaults.standard
            
            userDefaults.set(newValue, forKey: XTRProperty.atomicNumber)
            userDefaults.synchronize()
        }
    }
    
    class var viewTitle: String {
        get {
            let userDefaults = UserDefaults.standard
            guard let defaultValue = userDefaults.value(forKeyPath: XTRProperty.viewTitle) as? String else {
                XTRPropertiesStore.viewTitle = "None"
                return "None"
            }
            
            return defaultValue
        }
        
        set {
            let userDefaults = UserDefaults.standard
            
            userDefaults.set(newValue, forKey: XTRProperty.viewTitle)
            userDefaults.synchronize()
        }
    }

    class var splashScreenState: Bool {
        get {
            let userDefaults = UserDefaults.standard
            guard let defaultValue = userDefaults.value(forKeyPath: XTRProperty.splashScreen) as? Bool else {
                XTRPropertiesStore.splashScreenState = false
                return false
            }
            
            return defaultValue
        }
        
        set {
            let userDefaults = UserDefaults.standard
            
            userDefaults.set(newValue, forKey: XTRProperty.splashScreen)
            userDefaults.synchronize()
        }
    }

    class var showTransitionsState: Bool {
        get {
            let userDefaults = UserDefaults.standard
            guard let defaultValue = userDefaults.value(forKeyPath: XTRProperty.showTransitions) as? Bool else {
                XTRPropertiesStore.showTransitionsState = false
                return false
            }
            
            return defaultValue
        }
        
        set {
            let userDefaults = UserDefaults.standard
            
            userDefaults.set(newValue, forKey: XTRProperty.showTransitions)
            userDefaults.synchronize()
        }
    }

    class var elementBubblesState: Bool {
        get {
            let userDefaults = UserDefaults.standard
            guard let defaultValue = userDefaults.value(forKeyPath: XTRProperty.elementBubble) as? Bool else {
                XTRPropertiesStore.elementBubblesState = false
                return false
            }
            
            return defaultValue
        }
        
        set {
            let userDefaults = UserDefaults.standard
            
            userDefaults.set(newValue, forKey: XTRProperty.elementBubble)
            userDefaults.synchronize()
        }
    }

    class func getColorDataForKey(_ key: String?) -> Data? {
        let userDefaults = UserDefaults.standard
        return userDefaults.object(forKey: key!) as? Data
    }
    
    class func setColorData(_ data: Data!, key: String!) {
        if data != nil && key != nil {
            let userDefaults : UserDefaults = UserDefaults.standard
            
            userDefaults.set(data, forKey: key)
            userDefaults.synchronize()
        }
    }
    
    // MARK: - Appearance Name
    
    class var appearanceName: String {
        get {
            guard let objectValue = UserDefaults.standard.value(forKey: APPEARANCE_NAME_KEY) as? String else {
                XTRPropertiesStore.appearanceName = XTRAppearanceType.classic
                return XTRAppearanceType.classic
            }
            
            return objectValue
        }
        
        set(aValue) {
            let defaults = UserDefaults.standard
            defaults.set(aValue, forKey: APPEARANCE_NAME_KEY)
            defaults.synchronize()
        }
    }

    class func resetPreferences() {
        let userDefaults = UserDefaults.standard
        
        userDefaults.removeObject(forKey: XTRProperty.elementBubble)
        userDefaults.removeObject(forKey: ElementSeries.actinide)
        userDefaults.removeObject(forKey: ElementSeries.alkaliEarthMetal)
        userDefaults.removeObject(forKey: ElementSeries.alkaliMetal)
        userDefaults.removeObject(forKey: ElementSeries.halogen)
        userDefaults.removeObject(forKey: ElementSeries.lanthanide)
        userDefaults.removeObject(forKey: ElementSeries.metal)
        userDefaults.removeObject(forKey: ElementSeries.nobleGas)
        userDefaults.removeObject(forKey: ElementSeries.nonMetal)
        userDefaults.removeObject(forKey: ElementSeries.transactinides)
        userDefaults.removeObject(forKey: ElementSeries.transitionMetal)
        
        userDefaults.synchronize()
    }
    
}
