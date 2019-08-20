//
//  CityTableViewCell.swift
//  Weather
//
//  Created by bunty.madan on 20/8/19.
//  Copyright © 2019 Bunty Madan. All rights reserved.
//

import UIKit

class CityTableViewCell: UITableViewCell {
    func setupCell(_ city: CityDataModel) {
        textLabel?.text = city.areaName
    }
}
