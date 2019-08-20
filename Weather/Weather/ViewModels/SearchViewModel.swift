//
//  SearchViewModel.swift
//  Weather
//
//  Created by bunty.madan on 20/8/19.
//  Copyright © 2019 Bunty Madan. All rights reserved.
//

import Foundation

protocol SearchViewModelProtocol {
    var results: Dynamic<[CityDataModel]> { get }
}

struct SearchViewModel : SearchViewModelProtocol {
    //MARK: Properties
    //in
    private var dataProvider : DataProviderProtocol!
    //out
    var results: Dynamic<[CityDataModel]> = .init([])

    //MARK: LifeCycle
    init(dataProvider: DataProviderProtocol) {
        self.dataProvider = dataProvider
    }
    
    //MARK: Public
    public func searchFor(_ string: String) {
        dataProvider.search(for: string) { (response) in
            var results: [CityDataModel] = []
            for responseModel in response?.search_api?.result ?? [] {
                let model = CityDataModel(responseModel: responseModel)
                results.append(model)
            }
            self.results.value = results
        }
    }
}
