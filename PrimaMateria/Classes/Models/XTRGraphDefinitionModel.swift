//
//  XTRGraphDefinitionModel.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 7/5/18.
//  Copyright © 2018 xTrensa. All rights reserved.
//

//
//  XTRIsotopeModel.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 7/4/18.
//  Copyright © 2018 xTrensa. All rights reserved.
//

import Foundation

class XTRGraphDefinitionModel: NSObject {
    
    var title: String = STRING_EMPTY
    var attributeName: String = STRING_EMPTY
    var majorTickMarks: Float = 0
    var minorTickMarks: Float = 0
    var maximumValue: Float = 0
    var minimumValue: Float = 0
    
    convenience init(dictionary: [String: Any]) {
        self.init()
        
        if let value1 = dictionary[GraphAttribute.title] as? String {
            title = value1
        }
        if let value2 = dictionary[GraphAttribute.name] as? String {
            attributeName = value2
        }
        if let value3 = dictionary[GraphAttribute.majorTickMarks] as? Float {
            majorTickMarks = value3
        }
        if let value4 = dictionary[GraphAttribute.minorTickMarks] as? Float {
            minorTickMarks = value4
        }
        if let value5 = dictionary[GraphAttribute.maximumValue] as? Float {
            maximumValue = value5
        }
        if let value6 = dictionary[GraphAttribute.minimumValue] as? Float {
            minimumValue = value6
        }
     }
}
