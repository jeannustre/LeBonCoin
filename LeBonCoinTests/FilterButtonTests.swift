//
//  FilterButtonTests.swift
//  LeBonCoinTests
//
//  Created by Jean Sarda on 17/10/2020.
//

import XCTest
@testable import LeBonCoin

class FilterButtonTests: XCTestCase {
    
    var sut: FilterButton!
    
    override func setUp() {
        sut = FilterButton(categories: [])
    }

    override func tearDown() {
        sut = nil
    }
    
    func testFilterButtonImage() {
        XCTAssertNotNil(sut.image)
    }
    
    func testUpdateCategories() {
        sut.updateCategories([])
    }
    
}
