//
//  DetailViewModelTests.swift
//  WeatherTests
//
//  Created by bunty.madan on 20/8/19.
//  Copyright © 2019 Bunty Madan. All rights reserved.
//

import Foundation
import XCTest
@testable import Weather

class DetailViewModelTests: XCTestCase {
    
    var detailViewModel: DetailViewModel!
    
    override func setUp() {
        detailViewModel = DetailViewModel(dataProvider: DetailNetworkDataProviderMock())
    }
    
    override func tearDown() {
    }
    
    func testValidLongLat() {
        let expectation = self.expectation(description: "detail")
        detailViewModel.detailFor("1.352083", long: "103.819839")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            expectation.fulfill()
        }
        waitForExpectations(timeout: 2.0, handler: nil)
        XCTAssertEqual(detailViewModel.humidity.value, "20%")
        XCTAssertEqual(detailViewModel.weatherDesc.value, "desc")
        XCTAssertEqual(detailViewModel.weatherIconUrl.value, "weather-url")
        XCTAssertEqual(detailViewModel.temperature.value, "10°C")
    }
    
    func testInValidLongLat() {
        let expectation = self.expectation(description: "detail")
        detailViewModel.detailFor("", long: "")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            expectation.fulfill()
        }
        waitForExpectations(timeout: 2.0, handler: nil)
        XCTAssertEqual(detailViewModel.humidity.value, "")
        XCTAssertEqual(detailViewModel.weatherDesc.value, "")
        XCTAssertEqual(detailViewModel.weatherIconUrl.value, "")
        XCTAssertEqual(detailViewModel.temperature.value, "")
    }
    
    func testNilLongLat() {
        let expectation = self.expectation(description: "detail")
        detailViewModel.detailFor(nil, long: nil)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            expectation.fulfill()
        }
        waitForExpectations(timeout: 2.0, handler: nil)
        XCTAssertEqual(detailViewModel.humidity.value, "")
        XCTAssertEqual(detailViewModel.weatherDesc.value, "")
        XCTAssertEqual(detailViewModel.weatherIconUrl.value, "")
        XCTAssertEqual(detailViewModel.temperature.value, "")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}

class DetailNetworkDataProviderMock: DataProviderProtocol {
    
    let mockObject = DetailAPIResponseModel(data: RequestResponseModel(current_condition: [CurrentConditionResponseModel(temp_C: "10", weatherIconUrl: [WeatherIconURL(value: "weather-url")], weatherDesc: [WeatherDesc(value: "desc")], humidity: "20")]))
    
    func detail(for lat: String, long: String, handler: @escaping DetailCompletion) {
        if lat.isEmpty || long.isEmpty  {
            handler(nil)
        } else {
            handler(mockObject)
        }
    }
    
    func search(for string: String, handler: @escaping SearchCompletion) {
        
    }
}
