//
//  SUIPreferencesSupportClasses.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 10/4/21.
//  Copyright © 2021 Jerry Porter. All rights reserved.
//

import SwiftUI

struct ColorMapper {
    
    @State var foreGroundColor = UIColor.white
    @State var backGroundColor = UIColor.black
    
}

enum LanguageCodes: String {
    
    case English = "en"
    case Spanish = "es"
    case Russian = "ru"
    case French = "fr"
    
    func code() -> String {
        return self.rawValue
    }
    
}
