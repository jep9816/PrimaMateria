//
//  XTRSpectraModel.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 7/5/18.
//  Copyright © 2018 xTrensa. All rights reserved.
//

import Foundation

class XTRSpectraModel : NSObject {
    
    var airWavelength: String = STRING_EMPTY
    var intensity: String = STRING_EMPTY
    var spectrum: String = STRING_EMPTY
    
    convenience init(dictionary: [String : Any]) {
        self.init()
        
        if let value1 = dictionary[ELEMENT_AIR_WAVELENGTH] as? String {
            airWavelength = value1
        }
        if let value2 = dictionary[ELEMENT_INTENSITY] as? String {
            intensity = value2
        }
        if let value3 = dictionary[ELEMENT_SPECTRUM] as? String {
            spectrum = value3
        }
     }
}
