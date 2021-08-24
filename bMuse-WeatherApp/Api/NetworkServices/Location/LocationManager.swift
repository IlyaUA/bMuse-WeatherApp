//
//  LocationManager.swift
//  bMuse-WeatherApp
//
//  Created by Ilya Kharebashvili on 22.08.2021.
//

import Alamofire

protocol LocationManagerProtocol {
    func getLocation(lat: Double, lng: Double, completion: @escaping (Result<Location, AFError>) -> Void)
}

class LocationManager: CommonNetworkManager, LocationManagerProtocol {
    func getLocation(lat: Double, lng: Double, completion: @escaping (Result<Location, AFError>) -> Void) {
        
    }
    
    
}
