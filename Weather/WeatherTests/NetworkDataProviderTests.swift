//
//  NetworkDataProviderTests.swift
//  WeatherTests
//
//  Created by bunty.madan on 20/8/19.
//  Copyright © 2019 Bunty Madan. All rights reserved.
//

import XCTest
@testable import Weather

class NetworkDataProviderTests: XCTestCase {
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testSearchAPIValidQuery() {
        let expectation = self.expectation(description: "Networking")
         NetworkDataProvider().search(for: "Delhi") { (response) in
            expectation.fulfill()
            XCTAssertNotEqual(response?.search_api?.result.count, 0)
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testSearchAPIInvalidQuery() {
        let expectation = self.expectation(description: "Networking")
        NetworkDataProvider().search(for: "kljladjsflkc  jsldfj") { (response) in
            expectation.fulfill()
            XCTAssertNil(response)
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testSearchAPINoQuery() {
        let expectation = self.expectation(description: "Networking")
        NetworkDataProvider().search(for: "") { (response) in
            expectation.fulfill()
            XCTAssertNil(response)
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testDetailAPIValidQuery() {
        let expectation = self.expectation(description: "Networking")
        NetworkDataProvider().detail(for: "1.352083", long: "103.819839") { (response) in
            expectation.fulfill()
            XCTAssertNotNil(response?.data?.current_condition?.first?.humidity)
            XCTAssertNotNil(response?.data?.current_condition?.first?.temp_C)
            XCTAssertNotNil(response?.data?.current_condition?.first?.weatherDesc.first?.value)
            XCTAssertNotNil(response?.data?.current_condition?.first?.weatherIconUrl.first?.value)
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testDetailAPIInValidQuery() {
        let expectation = self.expectation(description: "Networking")
        NetworkDataProvider().detail(for: "", long: "") { (response) in
            expectation.fulfill()
            XCTAssertNil(response)
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testDetailAPINoQuery() {
        let expectation = self.expectation(description: "Networking")
        NetworkDataProvider().detail(for: "90909", long: "90909") { (response) in
            expectation.fulfill()
            XCTAssertNil(response)
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}
