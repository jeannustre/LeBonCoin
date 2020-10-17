//
//  CategoryViewTests.swift
//  LeBonCoinTests
//
//  Created by Jean Sarda on 17/10/2020.
//

import XCTest
@testable import LeBonCoin

class CategoryViewTests: XCTestCase {
    
    var sut: CategoryView!
    
    override func setUp() {
        let category = Category.init(id: 1, name: "TestCategory")
        sut = CategoryView(category: category)
    }

    override func tearDown() {
        sut = nil
    }
    
    func testCategoryValues() {
        XCTAssertEqual(sut.category?.id, 1)
        XCTAssertEqual(sut.category?.name, "TestCategory")
        XCTAssertEqual(sut.category?.color(), UIColor(named: "category-\(1)"))
    }
    
    
    
}
