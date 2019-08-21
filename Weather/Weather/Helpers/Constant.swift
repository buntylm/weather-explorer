//
//  Constant.swift
//  Weather
//
//  Created by bunty.madan on 20/8/19.
//  Copyright © 2019 Bunty Madan. All rights reserved.
//

import Foundation

struct K {
    static let defaultValue = ""
    
    struct API {
        static let scheme = "https"
        static let host = "api.worldweatheronline.com"

        struct URLPattern {
            static let search = "/premium/v1/search.ashx"
            static let detail = "/premium/v1/weather.ashx"
        }
        
        struct Param {
            
            struct Key {
                static let q = "q"
                static let query = "query"
                static let format = "format"
                static let key = "key"
                static let numberOfResults = "num_of_results"
            }
            
            struct Value {
                static let json = "json"
                static let apiKey = "e4e04472fe8748a1a2685025191408"
                static let numberOfResultsInSearch = "10"
                static let numberOfDaysInDetail = "1"
            }
        }
        
        struct Search {
            static let valueKey = "value"
        }
    }
    
    struct Storyboard {
        struct Search {
            static let showDetail = "detail"
        }
    }
    
    struct UI {
        static let searchPlaceholder = "Search"
    }
}
