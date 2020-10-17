//
//  Routes.swift
//  LeBonCoin
//
//  Created by Jean Sarda on 17/10/2020.
//

import Foundation

enum Routes {
    
    case getCategories
    case getListings
    
    private var baseURL: URL {
        return URL(string: "https://raw.githubusercontent.com/leboncoin/paperclip/master")!
    }
    
    private var path: String {
        switch self {
        case .getCategories:
            return "categories.json"
        case .getListings:
            return "listing.json"
        }
    }
    
    public var urlRequest: URLRequest {
        let finalURL: URL = baseURL.appendingPathComponent(path)
        return URLRequest(url: finalURL)
    }
    
}
