//
//  LeBonCoinUITests.swift
//  LeBonCoinUITests
//
//  Created by Jean Sarda on 11/10/2020.
//

import XCTest

class LeBonUITestCase: XCTestCase {

    var app: XCUIApplication!

    override func setUp() {
        super.setUp()

        continueAfterFailure = false

        app = XCUIApplication()

        for arg in self.launchArguments() {
            app.launchArguments.append(arg)
        }
        app.launch()
    }

    override func tearDown() {
        super.tearDown()
    }
    
    func launchArguments() -> [String] {
        return [
            "-AppleLanguages",
            "(en)",
            "-AppleLocale",
            "\"en_US\"",
            "--uitesting"
        ]
    }
}

class ListUITests: LeBonUITestCase {
    
    override func setUp() {
        app = XCUIApplication()
        
        continueAfterFailure = false
    }

    override func tearDown() {
        app = nil
    }

    func testCS4IsNotVisibleByDefault() {
        app.launch()
        
        let cs4Title = app.staticTexts["After effects CS4"]
        XCTAssertFalse(cs4Title.exists && cs4Title.isHittable, "The listing 'After effects CS4' should not be visible because we have not scrolled yet.")
        app.swipeUp()
        app.swipeUp()
        XCTAssert(cs4Title.exists && cs4Title.isHittable, "The listing 'After effects CS4' should now be visible because we have scrolled.")
    }

    func testFilterButtonActuallyFilters() {
        app.launch()
        
        let shopToSellTitle = app.staticTexts["Boutique à céder Oberkampf"]
        XCTAssertFalse(shopToSellTitle.exists && shopToSellTitle.isHittable, "The listing 'Boutique à céder Oberkampf' should not be visible because we have not filtered the list yet.")
        let button = app.buttons["filter-button"]
        button.tap()
        let targetCategory = app.buttons["Immobilier"]
        targetCategory.tap()
        XCTAssert(shopToSellTitle.exists && shopToSellTitle.isHittable, "The listing 'Boutique à céder Oberkampf' should now be visible because we have filtered the list.")
        button.tap()
        let allCategories = app.buttons["Toutes"]
        allCategories.tap()
        XCTAssertFalse(shopToSellTitle.exists && shopToSellTitle.isHittable, "The listing 'Boutique à céder Oberkampf' should not be visible anymore because we have removed the previously applied filter.")
    }
    
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
    
}
