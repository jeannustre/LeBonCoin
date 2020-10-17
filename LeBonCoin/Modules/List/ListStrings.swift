//
//  ListStrings.swift
//  LeBonCoin
//
//  Created by Jean Sarda on 18/10/2020.
//

import Foundation

/// Strings class used to get localized strings for the Navigation module.
class ListStrings {
    /// Returns the localized string for the specified key. Returns the key if no value was found.
    static func localized(_ key: String) -> String {
        return NSLocalizedString(key, tableName: "List", comment: "")
    }
}
