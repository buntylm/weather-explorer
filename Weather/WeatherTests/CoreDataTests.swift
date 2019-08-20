//
//  CoreDataTests.swift
//  WeatherTests
//
//  Created by bunty.madan on 20/8/19.
//  Copyright © 2019 Bunty Madan. All rights reserved.
//

import XCTest
@testable import Weather

class CoreDataTests: XCTestCase {
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testReadWriteOperation() {
        //clean up and check count
        CoreData.shared.obliterate(type: CityCoreDataModel.self)
        XCTAssertEqual(CoreData.shared.fetch(CityCoreDataModel.self)?.count, 0)
        
        //insert mock data and check count
        let mockServerResponse = CityResponseModel(areaName: [["value":"areaName"]], country: [["value":"country"]],
                                                   region: [["n":""]], latitude: "10.0", longitude: "10.0", population: "0",
                                                   weatherUrl: [["value":"weatherUrl"]])
        
        let mockModel = CityDataModel(responseModel: mockServerResponse)
        CoreData.shared.insert(CityCoreDataModel.self, responseModel: mockModel)
        
        // Verify saved object
        if let result = CoreData.shared.fetch(CityCoreDataModel.self), let first = result.first   {
            XCTAssertEqual(result.count, 1)
            let city = CityDataModel(coreDataModel: first)
            XCTAssertEqual(city.areaName, first.areaName)
            XCTAssertEqual(city.region, first.region)
        }
        
        //clean up and check count
        CoreData.shared.obliterate(type: CityCoreDataModel.self)
        XCTAssertEqual(CoreData.shared.fetch(CityCoreDataModel.self)?.count, 0)
        
        //insert mock data and check count
        let mockEmptyServerResponse = CityResponseModel()
        let mockEmptyModel = CityDataModel(responseModel: mockEmptyServerResponse)
        CoreData.shared.insert(CityCoreDataModel.self, responseModel: mockEmptyModel)
        
        // Verify saved object
        if let result = CoreData.shared.fetch(CityCoreDataModel.self), let first = result.first   {
            XCTAssertEqual(result.count, 1)
            let city = CityDataModel(coreDataModel: first)
            XCTAssertEqual(city.areaName, "")
            XCTAssertEqual(city.region, "")
            
            first.areaName = nil
            first.region = nil
            first.country = nil
            first.latitude = nil
            first.longitude = nil
            first.population = nil
            first.weatherUrl = nil
            
            CoreData.shared.save()
            CoreData.shared.save()
            
            let cityDataModel = CityDataModel(coreDataModel: first)
            XCTAssertNotNil(cityDataModel.region)
        }
        
        //clean up and check count
        CoreData.shared.obliterate(type: CityCoreDataModel.self)
        XCTAssertEqual(CoreData.shared.fetch(CityCoreDataModel.self)?.count, 0)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
