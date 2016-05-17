//
//  XTRApplication.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 4/20/16.
//  Copyright © 2016 xTrensa. All rights reserved.
//

@objc class XTRApplication : UIApplication {
    
    // MARK: Initialization Methods
    
    override init() {
        super.init()
        let aDefault : String? = NSUserDefaults.standardUserDefaults().stringForKey(SPLASH_SCREEN_DEFAULT)
        
        if (aDefault == nil) {
            self.registerDefaultsFromSettingsBundle()
        }
        
        XTRDataSource.sharedInstance()
    }
    
    // MARK: Internal Methods
    
    func registerDefaultsFromSettingsBundle() {
        guard let settingsBundle = NSBundle.mainBundle().pathForResource("Settings", ofType: "bundle") else {
            NSLog("Could not find Settings.bundle")
            return
        }
        
        let url : NSURL = NSURL.init(fileURLWithPath: settingsBundle)
        let url2 = url.URLByAppendingPathComponent("Root.plist")
        let settings : NSDictionary = NSDictionary.init(contentsOfURL: url2)!
        
        guard let preferences = settings.objectForKey("PreferenceSpecifiers") as? NSArray else {
            return
        }
        var defaultsToRegister = [String : AnyObject]()
        
        for index in 0..<preferences.count {
            let prefSpecification : NSDictionary = preferences.objectAtIndex(index) as! NSDictionary
            let key : String? = prefSpecification.objectForKey("Key") as? String
            
            if (key != nil) {
                let defaultValue : Bool? = prefSpecification.objectForKey("DefaultValue") as? Bool
                if (defaultValue != nil) {
                    defaultsToRegister[key!] = defaultValue
                }
            }
        }
        
        NSUserDefaults.standardUserDefaults().registerDefaults(defaultsToRegister)
    }
    
    // MARK: UIApplication implemented Methods
    
    func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    // MARK: - Memory Management Methods
}
