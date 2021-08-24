//
//  SessionService.swift
//  bMuse-WeatherApp
//
//  Created by Ilya Kharebashvili on 22.08.2021.
//

import Alamofire

class SessionService {
    
    let session = Session()
    
    private init() { }
    static let shared = SessionService()
}
