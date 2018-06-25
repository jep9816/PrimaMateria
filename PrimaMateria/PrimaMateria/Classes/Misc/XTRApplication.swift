//
//  XTRApplication.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 4/20/16.
//  Copyright © 2018 xTrensa. All rights reserved.
//

class XTRApplication : UIApplication {
    
    // MARK: Initialization Methods
    
    override init() {
        super.init()
        let aDefault : String? = UserDefaults.standard.string(forKey: XTRProperty.splashScreen)
        
        if aDefault == nil {
            registerDefaultsFromSettingsBundle()
        }
        
        _ = XTRDataSource.sharedInstance()
    }
    
    // MARK: Internal Methods
    
    func registerDefaultsFromSettingsBundle() {
        guard let settingsBundlePath = Bundle.main.path(forResource: "Settings", ofType: "bundle") else {
            print("Could not find Settings.bundle")
            return
        }
        
        do {
            let data : Data?
            let url : URL = URL(fileURLWithPath: settingsBundlePath)
            try data = Data(contentsOf: url.appendingPathComponent("Root.plist"), options: [])
            
            do {
                var settings = [String : Any]()
                try settings = PropertyListSerialization.propertyList(from: data!, options: [], format: nil) as! [String : Any]
                
                guard let preferences = settings["PreferenceSpecifiers"] as? [AnyObject] else {
                    return
                }
                var defaultsToRegister = [String : AnyObject]()
                
                for index in 0..<preferences.count {
                    let prefSpecification = preferences[index] as! [String : AnyObject]
                    
                    if let key = prefSpecification["Key"] as? String {
                        if let defaultValue = prefSpecification["DefaultValue"] {
                            defaultsToRegister[key] = defaultValue as AnyObject?
                        }
                    }
                }
                
                UserDefaults.standard.register(defaults: defaultsToRegister)
            } catch {
                
            }
        } catch {
            
        }
    }
    
    // MARK: UIApplication implemented Methods
    
    func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    // MARK: - Memory Management Methods
}
