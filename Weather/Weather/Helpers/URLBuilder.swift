//
//  URLBuilder.swift
//  Weather
//
//  Created by bunty.madan on 20/8/19.
//  Copyright © 2019 Bunty Madan. All rights reserved.
//

import Foundation

public struct URLBuilder {
    let path: String
    let queryItems: [URLQueryItem]
}

extension URLBuilder {
    static func search(matching query: String) -> URLBuilder? {
        
        guard !query.isEmpty else {
            return nil
        }
        
        return URLBuilder(
            path: K.API.URLPattern.search,
            queryItems: [
                URLQueryItem(name: K.API.Param.Key.query, value: query),
                URLQueryItem(name: K.API.Param.Key.format, value: K.API.Param.Value.json),
                URLQueryItem(name: K.API.Param.Key.key, value: K.API.Param.Value.apiKey),
                URLQueryItem(name: K.API.Param.Key.numberOfResults, value: K.API.Param.Value.numberOfResultsInSearch)
            ]
        )
    }
    
    static func detail(for long: String, lat: String) -> URLBuilder? {
        
        guard !long.isEmpty || !lat.isEmpty else {
            return nil
        }
        
        return URLBuilder(
            path: K.API.URLPattern.detail,
            queryItems: [
                URLQueryItem(name: K.API.Param.Key.q, value: "\(lat),\(long)"),
                URLQueryItem(name: K.API.Param.Key.format, value: K.API.Param.Value.json),
                URLQueryItem(name: K.API.Param.Key.key, value: K.API.Param.Value.apiKey),
                URLQueryItem(name: K.API.Param.Key.numberOfResults, value: K.API.Param.Value.numberOfDaysInDetail)
            ]
        )
    }
}

extension URLBuilder {
    var url: URL? {
        var components = URLComponents()
        components.scheme   = K.API.scheme
        components.host     = K.API.host
        components.path     = path
        components.queryItems = queryItems
        return components.url
    }
}
