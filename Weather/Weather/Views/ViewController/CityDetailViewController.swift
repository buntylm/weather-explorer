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
    
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var foregroundImage: UIImageView!
    @IBOutlet weak var weatherInText: UILabel!
    @IBOutlet weak var humidity: UILabel!
    @IBOutlet weak var tempreature: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = cityDataModel?.areaName
    }
}
