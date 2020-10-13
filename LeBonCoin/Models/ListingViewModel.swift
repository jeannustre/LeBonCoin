//
//  ListingViewModel.swift
//  LeBonCoin
//
//  Created by Jean Sarda on 13/10/2020.
//

import Foundation

struct ListingViewModel {
    
    private var listing: Listing
    private var categories: [Category]?
    
    public func listingTitle() -> String {
        return listing.title
    }
    
    public func listingPrice() -> String {
        return String(format: "%.2f €", listing.price)
    }
    
    public func listingDescription() -> String {
        return listing.description
    }
    
    public func smallImageUrl() -> URL? {
        return listing.images.small
    }
    
    public func thumbImageUrl() -> URL? {
        return listing.images.thumb
    }
    
    public func urgentString() -> String {
        return listing.isUrgent ? "Urgent !" : ""
    }
    
    public func category() -> Category {
        return categories?.first(where: { $0.id == listing.category }) ?? Category(id: -1, name: "???")
    }
    
    public init(listing: Listing, categories: [Category]?) {
        self.listing = listing
        self.categories = categories
    }
    
}
