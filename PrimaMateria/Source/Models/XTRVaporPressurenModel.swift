//
//  XTRVaporPressurenModel.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 8/7/18.
//  Copyright ©2021 xTrensa. All rights reserved.
//

import Foundation

class XTRVaporPressurenModel: NSObject {
    var dictionary: [String: Any]!

    convenience init(dictionary: [String: Any]) {
        self.init()
        self.dictionary = dictionary
    }

    var pa1: String {
        let paValue: String!
        let footnoteValue: String!

        if let prefix = dictionary["pa1"] as? String {
            paValue = prefix
        } else {
            paValue = STRING_EMPTY
        }

        if let suffix = dictionary["pakFootnote"] as? String {
            footnoteValue = suffix
        } else {
            footnoteValue = STRING_EMPTY
        }

        return "\(paValue!) \(footnoteValue!)"
    }

    var pa10: String {
        let paValue: String!
        let footnoteValue: String!

        if let prefix = dictionary["pa10"] as? String {
            paValue = prefix
        } else {
            paValue = STRING_EMPTY
        }

        if let suffix = dictionary["pa10Footnote"] as? String {
            footnoteValue = suffix
        } else {
            footnoteValue = STRING_EMPTY
        }

        return "\(paValue!) \(footnoteValue!)"
    }

    var pa100: String {
        let paValue: String!
        let footnoteValue: String!

        if let prefix = dictionary["pa100"] as? String {
            paValue = prefix
        } else {
            paValue = STRING_EMPTY
        }

        if let suffix = dictionary["pa100Footnote"] as? String {
            footnoteValue = suffix
        } else {
            footnoteValue = STRING_EMPTY
        }

        return "\(paValue!) \(footnoteValue!)"
    }

    var pa1k: String {
        let paValue: String!
        let footnoteValue: String!

        if let prefix = dictionary["pa1k"] as? String {
            paValue = prefix
        } else {
            paValue = STRING_EMPTY
        }

        if let suffix = dictionary["pa1kFootnote"] as? String {
            footnoteValue = suffix
        } else {
            footnoteValue = STRING_EMPTY
        }

        return "\(paValue!) \(footnoteValue!)"
    }

    var pa10k: String {
        let paValue: String!
        let footnoteValue: String!

        if let prefix = dictionary["pa10k"] as? String {
            paValue = prefix
        } else {
            paValue = STRING_EMPTY
        }

        if let suffix = dictionary["pa1kFootnote"] as? String {
            footnoteValue = suffix
        } else {
            footnoteValue = STRING_EMPTY
        }

        return "\(paValue!) \(footnoteValue!)"
    }

    var pa100k: String {
        let paValue: String!
        let footnoteValue: String!

        if let prefix = dictionary["pa100k"] as? String {
            paValue = prefix
        } else {
            paValue = STRING_EMPTY
        }

        if let suffix = dictionary["pa100kFootnote"] as? String {
            footnoteValue = suffix
        } else {
            footnoteValue = STRING_EMPTY
        }

        return "\(paValue!) \(footnoteValue!)"
    }

}
