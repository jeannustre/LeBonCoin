//
//  Routes.swift
//  LeBonCoin
//
//  Created by Jean Sarda on 17/10/2020.
//

import Foundation

/// Enum used to list all routes and create URLRequests.
enum Routes {
    /// The Get Categories route.
    case getCategories
    /// The Get Listings route.
    case getListings
    
    /// The base URL. In a real production app that has more than one endpoint, this would be inherited from the current scheme.
    private var baseURL: URL {
        return URL(string: "https://raw.githubusercontent.com/leboncoin/paperclip/master")!
    }
    
    /// Returns the path for the current route.
    private var path: String {
        switch self {
        case .getCategories:
            return "categories.json"
        case .getListings:
            return "listing.json"
        }
    }
    
    /// Creates an `URLRequest` for the current case.
    public var urlRequest: URLRequest {
        let finalURL: URL = baseURL.appendingPathComponent(path)
        return URLRequest(url: finalURL)
    }
    
}
