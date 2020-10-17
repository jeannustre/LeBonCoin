//
//  DetailStrings.swift
//  LeBonCoin
//
//  Created Jean Sarda on 17/10/2020.
//  Copyright © 2020 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

/// Strings class used to get localized strings for the Detail module.
class DetailStrings {
    /// Returns the localized string for the specified key. Returns the key if no value was found.
    static func localized(_ key: String) -> String {
        return NSLocalizedString(key, tableName: "Detail", comment: "")
    }
}
