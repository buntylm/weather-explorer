//
//  CityModel.swift
//  Weather
//
//  Created by bunty.madan on 20/8/19.
//  Copyright © 2019 Bunty Madan. All rights reserved.
//

import Foundation

struct CityDataModel {
    let areaName: String
    let region: String
    let country: String
    let longitude: String
    let latitude: String
    let population: String
    
    init(responseModel: CityResponseModel) {
        self.areaName = responseModel.areaName?.value() ?? K.defaultValue
        self.region = responseModel.region?.value() ?? K.defaultValue
        self.country = responseModel.country?.value() ?? K.defaultValue
        self.longitude = responseModel.longitude ?? K.defaultValue
        self.latitude = responseModel.latitude ?? K.defaultValue
        self.population = responseModel.population ?? K.defaultValue
    }
}
