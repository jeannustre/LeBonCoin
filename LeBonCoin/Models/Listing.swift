//
//  Listing.swift
//  LeBonCoin
//
//  Created by Jean Sarda on 11/10/2020.
//

import Foundation

protocol ListingProtocol: Codable {
    
    
    
}

struct Listing: Codable {
    
    enum CodingKeys: String, CodingKey {
        case id
        case category = "category_id"
        case title
        case description
        case price
        case images = "images_url"
        case creationDate = "creation_date"
        case isUrgent = "is_urgent"
    }
    
    var id: Double
    var category: Int
    var title: String
    var description: String
    var price: Double
    var images: Images
    var creationDate: Date?
    var isUrgent: Bool
    
    var categoryName: String?
    
}

