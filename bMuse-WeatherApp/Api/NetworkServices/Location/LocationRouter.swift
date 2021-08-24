//
//  LocationRouter.swift
//  bMuse-WeatherApp
//
//  Created by Ilya Kharebashvili on 22.08.2021.
//

import Alamofire

enum LocationRouter: APIConfiguration {
   
    case getLocation(lat: Double, lng: Double)
    
    
    var method: HTTPMethod {
        switch self {
        case .getLocation:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .getLocation(_, _):
            return "data/reverse-geocode-client"
        }
    }
    
    var parameters: RequestParams {
        switch self {
        case .getLocation(let lat, let lng):
            return .url([
                "latitude" : 47.847050,
                "longitude" : 35.140288,
                "localityLanguage" : "ru"
            ])
        }
    }
    
    var url: String {
        return Endpoint.locationApi.rawValue
    }
    
    
}

