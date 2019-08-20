//
//  NetworkDataProvider.swift
//  Weather
//
//  Created by bunty.madan on 20/8/19.
//  Copyright © 2019 Bunty Madan. All rights reserved.
//

import Foundation

typealias SearchCompletion = ((SearchAPIResponseModel?) -> ())
typealias DetailCompletion = ((DetailAPIResponseModel?) -> ())
typealias DataTaskCompletion = ((Data?) -> ())

protocol DataProviderProtocol {
    func search(for string:String, handler: @escaping SearchCompletion)
    func detail(for lat: String, long: String, handler: @escaping DetailCompletion)
}

class NetworkDataProvider: DataProviderProtocol {
    
    func search(for string:String, handler: @escaping SearchCompletion) {
        
        guard let url = URLBuilder.search(matching: string)?.url else {
            handler(nil)
            return
        }
        
        dataTask(url) { (data) in
            guard let jsonData = data,
                let responseObject = try? JSONDecoder().decode(SearchAPIResponseModel.self, from: jsonData),
                responseObject.search_api != nil else {
                    handler(nil)
                    return
            }
            handler(responseObject)
        }
    }
    
    public func detail(for lat: String, long: String, handler: @escaping DetailCompletion) {
        
        guard let url = URLBuilder.detail(for: long, lat: lat)?.url else {
            handler(nil)
            return
        }
        
        dataTask(url) { (data) in
            guard let jsonData = data,
                let responseObject = try? JSONDecoder().decode(DetailAPIResponseModel.self, from: jsonData), responseObject.data?.current_condition != nil else {
                    handler(nil)
                    return
            }
            handler(responseObject)
        }
        
    }
    
    private func dataTask(_ url: URL, handler: @escaping DataTaskCompletion) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            handler(data)
            }.resume()
    }
}
