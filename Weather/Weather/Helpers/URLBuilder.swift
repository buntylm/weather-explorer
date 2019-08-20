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
            path: "/premium/v1/search.ashx",
            queryItems: [
                URLQueryItem(name: "query", value: query),
                URLQueryItem(name: "format", value: "json"),
                URLQueryItem(name: "key", value: "e4e04472fe8748a1a2685025191408"),
                URLQueryItem(name: "num_of_results", value: "10")
            ]
        )
    }
    
    static func detail(for long: String, lat: String) -> URLBuilder? {
        
        guard !long.isEmpty || !lat.isEmpty else {
            return nil
        }
        
        return URLBuilder(
            path: "/premium/v1/weather.ashx",
            queryItems: [
                URLQueryItem(name: "q", value: "\(lat),\(long)"),
                URLQueryItem(name: "format", value: "json"),
                URLQueryItem(name: "key", value: "e4e04472fe8748a1a2685025191408"),
                URLQueryItem(name: "num_of_days", value: "1")
            ]
        )
    }
}

extension URLBuilder {
    var url: URL? {
        var components = URLComponents()
        components.scheme   = "https"
        components.host     = "api.worldweatheronline.com"
        components.path     = path
        components.queryItems = queryItems
        return components.url
    }
}
