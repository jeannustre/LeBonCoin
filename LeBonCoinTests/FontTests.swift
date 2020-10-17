//
//  FontTests.swift
//  LeBonCoinTests
//
//  Created by Jean Sarda on 17/10/2020.
//

import XCTest
@testable import LeBonCoin

class FontTests: XCTestCase {
    
    var sut: UIFont!
    
    override func setUp() {
        
    }

    override func tearDown() {
        sut = nil
    }

    func testIfFontsAreAvailable() throws {
        sut = DMSansFont.regular.font()
        XCTAssertNotEqual(sut, UIFont.systemFont(ofSize: 17.0))
        sut = DMSansFont.italic.font()
        XCTAssertNotEqual(sut, UIFont.systemFont(ofSize: 17.0))
        sut = DMSansFont.bold.font()
        XCTAssertNotEqual(sut, UIFont.systemFont(ofSize: 17.0))
        sut = DMSansFont.boldItalic.font()
        XCTAssertNotEqual(sut, UIFont.systemFont(ofSize: 17.0))
        sut = DMSansFont.medium.font()
        XCTAssertNotEqual(sut, UIFont.systemFont(ofSize: 17.0))
        sut = DMSansFont.mediumItalic.font()
        XCTAssertNotEqual(sut, UIFont.systemFont(ofSize: 17.0))
    }
    
    func testDefaultFontSize() {
        sut = DMSansFont.regular.font()
        XCTAssertEqual(sut.pointSize, 17.0)
    }
    
    func testCustomSize() {
        sut = DMSansFont.regular.font(size: 2.0)
        XCTAssertEqual(sut.pointSize, 2.0)
        sut = DMSansFont.regular.font(size: 200.0)
        XCTAssertEqual(sut.pointSize, 200.0)
        sut = DMSansFont.regular.font(size: 42.0)
        XCTAssertEqual(sut.pointSize, 42.0)
    }
    
}
