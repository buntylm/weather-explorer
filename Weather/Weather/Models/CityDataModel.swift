//
//  CityModel.swift
//  Weather
//
//  Created by bunty.madan on 20/8/19.
//  Copyright © 2019 Bunty Madan. All rights reserved.
//

import Foundation
import CoreData

public protocol PersistenanceProtocol {
    @discardableResult
    func map(_ managedObject: NSManagedObject?) -> CityCoreDataModel
}

struct CityDataModel : PersistenanceProtocol {
    
    let areaName: String
    let region: String
    let country: String
    let longitude: String
    let latitude: String
    let population: String
    
    var displayable : String    {
        return "\(areaName.value())\(region.value())\(country)"
    }
    
    init(responseModel: CityResponseModel) {
        self.areaName = responseModel.areaName?.value() ?? K.defaultValue
        self.region = responseModel.region?.value() ?? K.defaultValue
        self.country = responseModel.country?.value() ?? K.defaultValue
        self.longitude = responseModel.longitude ?? K.defaultValue
        self.latitude = responseModel.latitude ?? K.defaultValue
        self.population = responseModel.population ?? K.defaultValue
    }
    
    init(coreDataModel: CityCoreDataModel) {
        self.areaName = coreDataModel.areaName ?? K.defaultValue
        self.region = coreDataModel.region ?? K.defaultValue
        self.country = coreDataModel.country ?? K.defaultValue
        self.longitude = coreDataModel.longitude ?? K.defaultValue
        self.latitude = coreDataModel.latitude ?? K.defaultValue
        self.population = coreDataModel.population ?? K.defaultValue
    }
    
    func map(_ managedObject: NSManagedObject?) -> CityCoreDataModel {
        let mObject = managedObject as! CityCoreDataModel
        mObject.areaName = self.areaName
        mObject.region = self.region
        mObject.country = self.country
        mObject.longitude = self.longitude
        mObject.latitude = self.latitude
        mObject.population = self.population
        return mObject
    }
}
