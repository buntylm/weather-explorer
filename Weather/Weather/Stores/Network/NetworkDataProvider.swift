//
//  NetworkDataProvider.swift
//  Weather
//
//  Created by bunty.madan on 20/8/19.
//  Copyright © 2019 Bunty Madan. All rights reserved.
//

import Foundation

typealias Completion = ((WeatherAPIResponseModel?) -> ())

protocol DataProviderProtocol {
    func search(for string:String, handler: @escaping Completion)
}

class NetworkDataProvider: DataProviderProtocol {
    
    public static let shared = NetworkDataProvider()
    
    private init() { }
    
    func search(for string:String, handler: @escaping Completion) {
        
        guard let url = URLBuilder.search(matching: string)?.url else {
            handler(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let jsonData = data,
                let responseObject = try? JSONDecoder().decode(WeatherAPIResponseModel.self, from: jsonData),
                responseObject.search_api != nil else {
                    handler(nil)
                    return
            }
            handler(responseObject)
            }.resume()
    }
}
