//
//  ListingViewModel.swift
//  LeBonCoin
//
//  Created by Jean Sarda on 13/10/2020.
//

import Foundation

/// A view model used to handle formatting the infos of a `Listing` for display.
struct ListingViewModel {
    
    /// The listing.
    private var listing: Listing
    /// All categories, so we can find the relevant Category with `listing.category`.
    private var categories: [Category]?
    
    /// Returns the formatted title for the listing.
    public func listingTitle() -> String {
        return listing.title
    }
    
    /// Returns the formatted title for the listing.
    public func listingPrice() -> String {
        return String(format: "%.2f €", listing.price)
    }
    
    /// Returns the formatted description for the listing.
    public func listingDescription() -> String {
        return listing.description
    }
    
    /// Returns the URL for the small image.
    public func smallImageUrl() -> URL? {
        return listing.images.small
    }
    
    /// Returns the url for the thumbnail image.
    public func thumbImageUrl() -> URL? {
        return listing.images.thumb
    }
    
    /// Returns the string to be used for the "Urgent" label.
    public func urgentString() -> String {
        return listing.isUrgent ? "Urgent !" : ""
    }
    
    /// Returns the category for the current listing, or a default unknown category otherwise.
    public func category() -> Category {
        return categories?.first(where: { $0.id == listing.category }) ?? Category(id: -1, name: "???")
    }
    
    /// Initializes from a `Listing` and an optional array of `Category`.
    public init(listing: Listing, categories: [Category]?) {
        self.listing = listing
        self.categories = categories
    }
    
}
