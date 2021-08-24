//
//  WeatherRouter.swift
//  bMuse-WeatherApp
//
//  Created by Ilya Kharebashvili on 21.08.2021.
//

import Alamofire

enum WeathersRouter: APIConfiguration {

    case getWeather(lat: Double, lng: Double)
    
    var url: String {
        return Endpoint.weatherApi.rawValue
    }
    
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
                "lat" : lat,
                "lon" : lng
            ])
        }
    }
}

