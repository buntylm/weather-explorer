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
    private var dataProvider : DataProviderProtocol!
    public var results: Dynamic<[CityDataModel]> = .init([])

    //MARK: LifeCycle
    init(dataProvider: DataProviderProtocol) {
        self.dataProvider = dataProvider
    }
    
    //MARK: Public
    public func searchFor(_ string: String?) {
        guard let string = string   else {
            return
        }
        
        dataProvider.search(for: string) { (response) in
            var results: [CityDataModel] = []
            for responseModel in response?.search_api?.result ?? [] {
                let model = CityDataModel(responseModel: responseModel)
                results.append(model)
            }
            self.results.value = results
        }
    }
    
    //MARK: Private
    private func savedCities() -> [CityDataModel] {
        var results: [CityDataModel] = []
        guard let coreDataResults = CoreData.shared.fetch(CityCoreDataModel.self), !coreDataResults.isEmpty else {
            return results
        }
        for coreDataModel in coreDataResults {
            let model = CityDataModel(coreDataModel: coreDataModel)
            results.append(model)
        }
        return results
    }
    
    //MARK: Presentation Logic
    var numberOfRows: Int {
        return results.value.count
    }
    
    func modelFor(indexPath: IndexPath) -> CityDataModel {
        return results.value[indexPath.row]
    }
    
    func willFinishSearch() {
        self.results.value = savedCities()
    }
    
    func willStartSearch() {
        self.results.value.removeAll()
    }
}
