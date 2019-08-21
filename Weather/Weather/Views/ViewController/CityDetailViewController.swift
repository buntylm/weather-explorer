//
//  CityDetailViewController.swift
//  Weather
//
//  Created by bunty.madan on 20/8/19.
//  Copyright © 2019 Bunty Madan. All rights reserved.
//

import UIKit

class CityDetailViewController: UIViewController {
    
    var cityDataModel: CityDataModel?
    var detailViewModel = DetailViewModel(dataProvider: NetworkDataProvider())

    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var foregroundImage: UIImageView!
    @IBOutlet weak var weatherInText: UILabel!
    @IBOutlet weak var humidity: UILabel!
    @IBOutlet weak var tempreature: UILabel!
    @IBOutlet var loadingIndicator: [UIActivityIndicatorView]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = cityDataModel?.areaName
        setupBinding()
        fetchData()
    }
    
    //MARK: Binding
    private func setupBinding() {
        detailViewModel.apiRequestFinised.bind { [weak self] in
            self?.stopLoadingIndicators()
        }
        
        detailViewModel.humidity.bind { [weak self] in
            self?.updateHumidity()
        }
        
        detailViewModel.temperature.bind { [weak self] in
            self?.updateTempreature()
        }
        
        detailViewModel.weatherDesc.bind { [weak self] in
            self?.updateWeatherDesc()
        }
        
        detailViewModel.weatherIconUrl.bind { [weak self] in
            self?.updateImage()
        }
    }
    
    private func fetchData()    {
        detailViewModel.detailFor(cityDataModel?.latitude, long: cityDataModel?.longitude)
    }
    
    //MARK: UI Mapping
    private func updateHumidity()   {
        humidity.text = detailViewModel.humidity.value
    }
    
    private func updateTempreature()   {
        tempreature.text = detailViewModel.temperature.value
    }
    
    private func updateWeatherDesc()   {
        weatherInText.text = detailViewModel.weatherDesc.value
    }
    
    private func updateImage() {
        fetchImage(from: self.detailViewModel.weatherIconUrl.value, handler: { (image) in
            DispatchQueue.main.async { [weak self] in
                self?.foregroundImage.image = image
                self?.backgroundImage.image = image
            }
        })
    }
    
    private func stopLoadingIndicators() {
        self.loadingIndicator.forEach { $0.stopAnimating() }
    }
}
