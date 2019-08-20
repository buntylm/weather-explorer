//
//  DetailAPIResponseModel.swift
//  Weather
//
//  Created by bunty.madan on 20/8/19.
//  Copyright © 2019 Bunty Madan. All rights reserved.
//

import Foundation

public struct DetailAPIResponseModel : Codable {
    var data: RequestResponseModel?
}

struct RequestResponseModel : Codable {
    var current_condition: [CurrentConditionResponseModel]?
}

struct CurrentConditionResponseModel : Codable {
    var temp_C: String
    var weatherIconUrl: [WeatherIconURL]
    var weatherDesc: [WeatherDesc]
    var humidity: String
}

struct WeatherIconURL : Codable {
    var value: String
}

struct WeatherDesc : Codable {
    var value: String
}
