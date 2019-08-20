//
//  WeatherAPIResponseModel.swift
//  Weather
//
//  Created by bunty.madan on 20/8/19.
//  Copyright © 2019 Bunty Madan. All rights reserved.
//

import Foundation
import CoreData

typealias APIResponseValue = [[String: String]]

public struct WeatherAPIResponseModel : Codable {
    var search_api: SearchResponseModel?
}

struct SearchResponseModel : Codable{
    var result: [CityResponseModel]
}

struct CityResponseModel : Codable {
    var areaName:   APIResponseValue?
    var country:    APIResponseValue?
    var region:     APIResponseValue?
    var latitude:   String?
    var longitude:  String?
    var population: String?
    var weatherUrl: APIResponseValue?
}
