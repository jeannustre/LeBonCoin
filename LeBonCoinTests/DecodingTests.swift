//
//  DecodingTests.swift
//  LeBonCoinTests
//
//  Created by Jean Sarda on 16/10/2020.
//

import XCTest
@testable import LeBonCoin

class DecodingTests: XCTestCase {
    
    let testDataMockFileName = "TestData"
    let testCategoriesMockFileName = "TestCategories"
    let testFileType = "json"
    
    var decoder: JSONDecoder!
    var listingsData: Data!
    var categoriesData: Data!
    
    override func setUpWithError() throws {
        let listingsMockURL = Bundle.main.url(forResource: testDataMockFileName, withExtension: testFileType)!
        let categoriesMockURL = Bundle.main.url(forResource: testCategoriesMockFileName, withExtension: testFileType)!
        do {
            listingsData = try Data(contentsOf: listingsMockURL)
            categoriesData = try Data(contentsOf: categoriesMockURL)
        } catch {
            throw error
        }
        decoder = JSONDecoder()
    }

    override func tearDownWithError() throws {
        listingsData = nil
        categoriesData = nil
    }

    func testDecodingListings() throws {
        decoder.dateDecodingStrategy = .iso8601
        do {
            let listings = try decoder.decode([LeBonCoin.Listing].self, from: listingsData)
            XCTAssertNotEqual(listings.count, 0)
        } catch {
            throw error
        }
    }
    
    func testDecodingCategories() throws {
        do {
            let categories = try decoder.decode([LeBonCoin.Category].self, from: categoriesData)
            XCTAssertNotEqual(categories.count, 0)
        } catch {
            throw error
        }
    }
    
}
