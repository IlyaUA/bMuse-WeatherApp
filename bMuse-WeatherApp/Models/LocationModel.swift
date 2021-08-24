//
//  LocationModel.swift
//  bMuse-WeatherApp
//
//  Created by Ilya Kharebashvili on 22.08.2021.
//

import Foundation

struct Location: Codable {
    let latitude, longitude: Double?
    let principalSubdivision, city, locality: String?
}
