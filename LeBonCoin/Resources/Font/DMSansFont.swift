//
//  DMSansFont.swift
//  LeBonCoin
//
//  Created by Jean Sarda on 13/10/2020.
//

import UIKit

/// An enum to access to the DMSans font names easily.
enum DMSansFont: String {
    /// Regular
    case regular = "DMSans-Regular"
    /// Italic
    case italic = "DMSans-Italic"
    /// Bold
    case bold = "DMSans-Bold"
    /// Bold, Italic
    case boldItalic = "DMSans-BoldItalic"
    /// Medium
    case medium = "DMSans-Medium"
    /// Medium, Italic
    case mediumItalic = "DMSans-MediumItalic"
    /// Returns a `UIFont` initialized from the current `DMSansFont` at the specified size, or 17 if none is provided.
    func font(size: CGFloat = 17) -> UIFont {
        guard let font = UIFont(name: self.rawValue, size: size) else {
            return UIFont.systemFont(ofSize: size)
        }
        return font
    }
}
