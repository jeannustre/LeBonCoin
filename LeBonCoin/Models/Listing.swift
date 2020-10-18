//
//  Listing.swift
//  LeBonCoin
//
//  Created by Jean Sarda on 11/10/2020.
//

import Foundation

/// Raw representation of a listing. Should be used to initialize a `ListingViewModel` before use.
struct Listing: Codable {
    
    /// CodingKeys for the `Listing` Codable.
    enum CodingKeys: String, CodingKey {
        /// The listing's identifier
        case id
        /// The listing's category's id
        case category = "category_id"
        /// The listing's title
        case title
        /// The listing's description
        case description
        /// The listing's price
        case price
        /// The listing's images
        case images = "images_url"
        /// The listing's creation date
        case creationDate = "creation_date"
        /// The listing's urgency status
        case isUrgent = "is_urgent"
    }
    
    /// Identifier of the listing.
    var id: Double
    /// Id of the listing's category.
    var category: Int
    /// Title of the listing.
    var title: String
    /// Description of the listing.
    var description: String
    /// Price of the listing.
    var price: Double
    /// Images of the listing. Contains a small and thumbnail image URLs, see `Images`.
    var images: Images
    /// Date of creation with the iso8601 format.
    var creationDate: Date?
    /// Whether the listing is tagged as urgent.
    var isUrgent: Bool
    
}

