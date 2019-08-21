//
//  WeatherUITests.swift
//  WeatherUITests
//
//  Created by bunty.madan on 20/8/19.
//  Copyright © 2019 Bunty Madan. All rights reserved.
//

import XCTest

class WeatherUITests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSearchValidKeyword() {
        let app = XCUIApplication()
        //Search Delhi
        app.searchFields["Search"].tap()
        app.searchFields["Search"].typeText("Delhi")
        
        //Open detail (Save Result)
        app.tables.children(matching: .cell).element(boundBy: 1).staticTexts["Delhi, Ontario, Canada"].tap()
        app.buttons["Weather Explorer"].tap()

        //Open detail again (Check duplicate)
        app.tables.children(matching: .cell).element(boundBy: 1).staticTexts["Delhi, Ontario, Canada"].tap()
        app.buttons["Weather Explorer"].tap()
        
        //Cancel will saved result
        app.buttons["Cancel"].tap()
        
        //Tap on saved result list
        app.tables.children(matching: .cell).element(boundBy: 0).staticTexts["Delhi, Ontario, Canada"].tap()
        app.buttons["Weather Explorer"].tap()
    }
    
    func testTapSearchAndCancel() {
        let app = XCUIApplication()
        
        //search something wrong
        app.searchFields["Search"].tap()
        app.searchFields["Search"].typeText("ghjgjgjhghjghjghjg")
        
        //verify table row count.
        XCTAssertEqual(app.tables.children(matching: .cell).count, 0)
        app.buttons["Cancel"].tap()
    }
}
