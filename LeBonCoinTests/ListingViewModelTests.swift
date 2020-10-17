//
//  ListingViewModelTests.swift
//  LeBonCoinTests
//
//  Created by Jean Sarda on 16/10/2020.
//

import XCTest
@testable import LeBonCoin

class ListingViewModelTests: XCTestCase {
    
    var sut: ListingViewModel!
    var sutWithoutCategories: ListingViewModel!
    
    override func setUpWithError() throws {
        let smallImageURL = URL(string: "https://raw.githubusercontent.com/leboncoin/paperclip/master/ad-small/2c9563bbe85f12a5dcaeb2c40989182463270404.jpg")
        let thumbImageURL = URL(string: "https://raw.githubusercontent.com/leboncoin/paperclip/master/ad-thumb/2c9563bbe85f12a5dcaeb2c40989182463270404.jpg")
        let images: Images = Images(small: smallImageURL, thumb: thumbImageURL)
        let listing: Listing = Listing(id: 0, category: 2, title: "Test Listing", description: "Some description", price: 42, images: images, creationDate: nil, isUrgent: true)
        sut = ListingViewModel(listing: listing, categories: [Category(id: 2, name: "TestCategory")])
        sutWithoutCategories = ListingViewModel(listing: listing, categories: nil)
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func testProperties() {
        XCTAssertEqual(sut.listingTitle(), "Test Listing")
    }
    
    func testListingDescription() {
        XCTAssertEqual(sut.listingDescription(), "Some description")
    }

    func testListingPrice() {
        XCTAssertEqual(sut.listingPrice(), "42.00 €")
    }
    
    func testImages() {
        XCTAssertNotNil(sut.smallImageUrl())
        XCTAssertNotNil(sut.thumbImageUrl())
    }
    
    func testUrgentString() {
        XCTAssertEqual(sut.urgentString(), "Urgent !")
    }
    
    func testCategory() {
        let category = sut.category()
        XCTAssertEqual(category.id, 2)
        XCTAssertEqual(category.name, "TestCategory")
        XCTAssertEqual(category.color(), UIColor(named: "category-\(2)"))
    }
    
    func testEmptyCategory() {
        let category = sutWithoutCategories.category()
        XCTAssertEqual(category.id, -1)
        XCTAssertEqual(category.name, "???")
    }
    
}
