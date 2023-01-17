//
//  XTRElectronConfigurationModel.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 8/7/18.
//  Copyright ©2023 xTrensa. All rights reserved.
//

import Foundation

class XTRElectronConfigurationModel: NSObject {
    var dictionary: [String: Any]!

    convenience init(dictionary: [String: Any]) {
        self.init()
        self.dictionary = dictionary
    }

    var shell1s: String {
        guard let aValue = dictionary["1s"] as? String else { return STRING_EMPTY }

        return aValue != "?" ? aValue: STRING_EMPTY
    }

    var shell2s: String {
        guard let aValue = dictionary["2s"] as? String else { return STRING_EMPTY }

        return aValue != "?" ? aValue: STRING_EMPTY
    }

    var shell2p: String {
        guard let aValue = dictionary["2p"] as? String else { return STRING_EMPTY }

        return aValue != "?" ? aValue: STRING_EMPTY
    }

    var shell3s: String {
        guard let aValue = dictionary["3s"] as? String else { return STRING_EMPTY }

        return aValue != "?" ? aValue: STRING_EMPTY
    }

    var shell3p: String {
        guard let aValue = dictionary["3p"] as? String else { return STRING_EMPTY }

        return aValue != "?" ? aValue: STRING_EMPTY
    }

    var shell3d: String {
        guard let aValue = dictionary["3d"] as? String else { return STRING_EMPTY }

        return aValue != "?" ? aValue: STRING_EMPTY
    }

    var shell4s: String {
        guard let aValue = dictionary["4s"] as? String else { return STRING_EMPTY }

        return aValue != "?" ? aValue: STRING_EMPTY
    }

    var shell4p: String {
        guard let aValue = dictionary["4p"] as? String else { return STRING_EMPTY }

        return aValue != "?" ? aValue: STRING_EMPTY
    }

    var shell4d: String {
        guard let aValue = dictionary["4d"] as? String else { return STRING_EMPTY }

        return aValue != "?" ? aValue: STRING_EMPTY
    }

    var shell4f: String {
        guard let aValue = dictionary["4f"] as? String else { return STRING_EMPTY }

        return aValue != "?" ? aValue: STRING_EMPTY
    }

    var shell5s: String {
        guard let aValue = dictionary["5s"] as? String else { return STRING_EMPTY }

        return aValue != "?" ? aValue: STRING_EMPTY
    }

    var shell5p: String {
        guard let aValue = dictionary["5p"] as? String else { return STRING_EMPTY }

        return aValue != "?" ? aValue: STRING_EMPTY
    }

    var shell5d: String {
        guard let aValue = dictionary["5d"] as? String else { return STRING_EMPTY }

        return aValue != "?" ? aValue: STRING_EMPTY
    }

    var shell5f: String {
        guard let aValue = dictionary["5f"] as? String else { return STRING_EMPTY }

        return aValue != "?" ? aValue: STRING_EMPTY
    }

    var shell6s: String {
        guard let aValue = dictionary["6s"] as? String else { return STRING_EMPTY }

        return aValue != "?" ? aValue: STRING_EMPTY
    }

    var shell6p: String {
        guard let aValue = dictionary["6p"] as? String else { return STRING_EMPTY }

        return aValue != "?" ? aValue: STRING_EMPTY
    }

    var shell6d: String {
        guard let aValue = dictionary["6d"] as? String else { return STRING_EMPTY }

        return aValue != "?" ? aValue: STRING_EMPTY
    }

    var shell7s: String {
        guard let aValue = dictionary["7s"] as? String else { return STRING_EMPTY }

        return aValue != "?" ? aValue: STRING_EMPTY
    }

    var shell7p: String {
        guard let aValue = dictionary["7p"] as? String else { return STRING_EMPTY }

        return aValue != "?" ? aValue: STRING_EMPTY
    }

}
