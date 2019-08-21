//
//  DetailViewModel.swift
//  Weather
//
//  Created by bunty.madan on 21/8/19.
//  Copyright © 2019 Bunty Madan. All rights reserved.
//

import Foundation

protocol DetailViewModelProtocol {
    var humidity: Dynamic<String> { get }
    var temperature: Dynamic<String> { get }
    var weatherDesc: Dynamic<String> { get }
    var weatherIconUrl: Dynamic<String> { get }
}

struct DetailViewModel : DetailViewModelProtocol {
    //MARK: Properties
    var humidity: Dynamic<String> = .init("")
    var temperature: Dynamic<String> = .init("")
    var weatherDesc: Dynamic<String> = .init("")
    var weatherIconUrl: Dynamic<String> = .init("")
    var apiRequestFinised: Dynamic<Bool> = .init(false)

    private var dataProvider : DataProviderProtocol!
    
    //MARK: LifeCycle
    init(dataProvider: DataProviderProtocol) {
        self.dataProvider = dataProvider
    }
    
    //MARK: Public
    public func detailFor(_ lat: String?, long: String?) {
        
        guard let lat = lat, let long = long   else {
            return
        }
        
        dataProvider.detail(for: lat, long: long) { (response) in
            self.apiRequestFinised.value = true

            if let humidity = response?.data?.current_condition?.first?.humidity {
                self.humidity.value = humidity
            }
            
            if let temperature = response?.data?.current_condition?.first?.temp_C  {
                self.temperature.value = temperature
            }
            
            if let weatherDesc = response?.data?.current_condition?.first?.weatherDesc.first?.value {
                self.weatherDesc.value = weatherDesc
            }
            
            if let weatherIconUrl = response?.data?.current_condition?.first?.weatherIconUrl.first?.value {
                self.weatherIconUrl.value = weatherIconUrl
            }
        }
    }
}
