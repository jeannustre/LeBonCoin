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

    func testGuitarIsNotVisibleByDefault() throws {
        app.launch()
        
        let guitarListingTitle = app.staticTexts["Guitare électro acoustique"]
        XCTAssertFalse(guitarListingTitle.exists, "The listing 'Guitare électro acoustique' should not be visible because we have not scrolled yet.")
        app.swipeUp()
        XCTAssert(guitarListingTitle.exists, "The listing 'Guitare électro acoustique' should now be visible because we have scrolled.")
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
