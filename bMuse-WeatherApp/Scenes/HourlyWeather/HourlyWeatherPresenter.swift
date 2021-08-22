//
//  HourlyWeatherPresenter.swift
//  bMuse-WeatherApp
//
//  Created by Ilya Kharebashvili on 21.08.2021.
//

import UIKit

protocol HourlyWeatherPresenterProtocol: LifecyclePresenter {
    var router: HourlyWeatherRouterProtocol { get }
}

final class HourlyWeatherPresenter: HourlyWeatherPresenterProtocol {
    
    let weatherService = WeatherService.shared
    
    private weak var view: HourlyWeatherView?
    private(set) var router: HourlyWeatherRouterProtocol
    
    init(view: HourlyWeatherView?,
         router: HourlyWeatherRouterProtocol) {
        
        self.view = view
        self.router = router
    }
    
    func viewDidLoad() {

    }
    
    func viewWillAppear() {
        
    }
}
