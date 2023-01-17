//
//  XTRIsotopeModel.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 7/4/18.
//  Copyright ©2023 xTrensa. All rights reserved.
//

import Foundation

class XTRIsotopeModel: NSObject {

    var isotopicComposition: String = STRING_EMPTY
    var isotopicMass: String = STRING_EMPTY
    var zpValue: String = STRING_EMPTY
    var decayEnergy: String = STRING_EMPTY
    var decayModes: String = STRING_EMPTY
    var daughterIsotopes: String = STRING_EMPTY
    var halfLife: String = STRING_EMPTY
    var nnValue: String = STRING_EMPTY
    var nuclideSymbol: String = STRING_EMPTY
    var nuclearSpin: String = STRING_EMPTY
    var naturalRangeVariation: String = STRING_EMPTY

    convenience init(dictionary: [String: Any]) {
        self.init()

        if let value1 = dictionary[ELEMENT_NUCLIDE_ISOTOPIC_COMPOSITION] as? String {
            isotopicComposition = value1
        }
        if let value2 = dictionary[ELEMENT_ATOMIC_MASS] as? String {
            isotopicMass = value2
        }
        if let value3 = dictionary[ELEMENT_NUCLIDE_ZP] as? String {
            zpValue = value3
        }
        if let value4 = dictionary[ELEMENT_NUCLIDE_DECAY_ENERGY] as? String {
            decayEnergy = value4
        }
        if let value5 = dictionary[ELEMENT_NUCLIDE_DECAY_MODES] as? String {
            decayModes = value5
        }
        if let value6 = dictionary[ELEMENT_NUCLIDE_DAUGHTER_ISOTOPES] as? String {
            daughterIsotopes = value6
        }
        if let value7 = dictionary[ELEMENT_NUCLIDE_HALF_LIFE] as? String {
            halfLife = value7
        }
        if let value8 = dictionary[ELEMENT_NUCLIDE_NN] as? String {
            nnValue = value8
        }
        if let value9 = dictionary[ELEMENT_NUCLIDE_SYMBOL] as? String {
            nuclideSymbol = value9
        }
        if let value10 = dictionary[ELEMENT_NUCLIDE_NUCLEAR_SPIN] as? String {
            nuclearSpin = value10
        }
        if let value11 = dictionary[ELEMENT_NUCLIDE_NATURAL_RANGE_VARIATION] as? String {
            naturalRangeVariation = value11
        }
    }
}
