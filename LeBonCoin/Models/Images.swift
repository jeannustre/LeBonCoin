//
//  Images.swift
//  LeBonCoin
//
//  Created by Jean Sarda on 13/10/2020.
//

import Foundation

/// Codable struct used to hold both images for a listing.
struct Images: Codable {
    /// The small image URL.
    var small: URL?
    /// The thumbnail image URL.
    var thumb: URL?
}
