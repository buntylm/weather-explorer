//
//  SearchViewModelTests.swift
//  WeatherTests
//
//  Created by bunty.madan on 20/8/19.
//  Copyright © 2019 Bunty Madan. All rights reserved.
//

import Foundation
import XCTest
@testable import Weather

class SearchViewModelTests: XCTestCase {
    
    var searchViewModel: SearchViewModel!

    override func setUp() {
        searchViewModel = SearchViewModel(dataProvider: NetworkDataProviderMock())
    }
    
    override func tearDown() {
        searchViewModel = nil
    }
    
    func testSearchWithValidString() {
        let expectation = self.expectation(description: "Search")
        searchViewModel.searchFor("Delhi")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            expectation.fulfill()
        }
        waitForExpectations(timeout: 2.0, handler: nil)
        XCTAssertEqual(searchViewModel.results.value.count, 2)
    }
    
    func testSearchWithEmptyString() {
        let expectation = self.expectation(description: "Search")
        searchViewModel.searchFor("")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            expectation.fulfill()
        }
        waitForExpectations(timeout: 2.0, handler: nil)
        XCTAssertEqual(searchViewModel.results.value.count, 0)
    }
    
    func testSearchWithNilString() {
        let expectation = self.expectation(description: "Search")
        searchViewModel.searchFor(nil)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            expectation.fulfill()
        }
        waitForExpectations(timeout: 2.0, handler: nil)
        XCTAssertEqual(searchViewModel.results.value.count, 0)
    }
    
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}

class NetworkDataProviderMock: DataProviderProtocol {
    func detail(for lat: String, long: String, handler: @escaping DetailCompletion) {
        
    }
    
    let mockObject = SearchAPIResponseModel(search_api: SearchResponseModel(result:
    [CityResponseModel(
        areaName: [["value":"areaName"]], country: [["value":"country"]], region: [["n":""]],
        latitude: "10.0", longitude: "10.0", population: "0", weatherUrl: [["value":"weatherUrl"]]),
     CityResponseModel(areaName: nil, country: nil, region: nil,
                       latitude: nil, longitude: nil, population: nil, weatherUrl: nil)]))
    
    func search(for string: String, handler: @escaping SearchCompletion) {
        if string.isEmpty {
            handler(nil)
        } else {
            handler(mockObject)
        }
    }
}

