//
//  Category.swift
//  LeBonCoin
//
//  Created by Jean Sarda on 13/10/2020.
//

import UIKit

/// The Codable struct used to represent a category.
struct Category: Codable {
    /// The identifier for the category.
    var id: Int
    /// The name for the category.
    var name: String?
    /// Returns the color associated with the current category (depending on the `id`). See `Colors.xcasset`.
    func color() -> UIColor? {
        return UIColor.init(named: "category-\(id)")
    }
    
}
