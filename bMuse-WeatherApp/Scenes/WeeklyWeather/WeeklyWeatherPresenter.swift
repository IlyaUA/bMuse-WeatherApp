//
//  WeeklyWeatherPresenter.swift
//  bMuse-WeatherApp
//
//  Created by Ilya Kharebashvili on 21.08.2021.
//

import UIKit

protocol WeeklyWeatherPresenterProtocol: LifecyclePresenter {
    var router: WeeklyWeatherRouterProtocol { get }
}

final class WeeklyWeatherPresenter: WeeklyWeatherPresenterProtocol {
    
    private weak var view: WeeklyWeatherView?
    private(set) var router: WeeklyWeatherRouterProtocol
    
    init(view: WeeklyWeatherView?,
         router: WeeklyWeatherRouterProtocol) {
        
        self.view = view
        self.router = router
    }
    
    func viewDidLoad() {
        
    }
    
    func viewWillAppear() {
        
    }
}
