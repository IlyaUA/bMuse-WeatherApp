//
//  WeatherManager.swift
//  bMuse-WeatherApp
//
//  Created by Ilya Kharebashvili on 21.08.2021.
//

import Alamofire

protocol WeatherManagerProtocol {
    func getWeather(lat: Double, lng: Double, completion: @escaping (Result<WeatherModel, AFError>) -> Void)
}

class WeatherManager: CommonNetworkManager, WeatherManagerProtocol {
    
    func getWeather(lat: Double, lng: Double, completion: @escaping (Result<WeatherModel, AFError>) -> Void) {
        let request = WeathersRouter.getWeather(lat: lat, lng: lng)
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        session.request(request).validate().responseDecodable(of: WeatherModel.self, decoder: decoder) { response in
            completion(response.result)
        }
    }
    
}
