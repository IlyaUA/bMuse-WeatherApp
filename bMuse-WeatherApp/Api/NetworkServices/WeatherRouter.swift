//
//  WeatherRouter.swift
//  bMuse-WeatherApp
//
//  Created by Ilya Kharebashvili on 21.08.2021.
//

import Alamofire

enum WeatherRouter: APIConfiguration {
    
    case getWeather(lat: Double, lng: Double)
    
    
    var method: HTTPMethod {
        switch self {
        case .getWeather:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .getWeather(_, _):
            return "weatherapi/locationforecast/2.0/complete"
        }
    }
    
    var parameters: RequestParams {
        switch self {
        case .getWeather(let lat, let lng):
            return .url([
                "lat" : 47.847050,
                "lon" : 35.140288
            ])
        }
    }
    
    
}

