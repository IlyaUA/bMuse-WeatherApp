//
//  WeeklyWeatherConfigurator.swift
//  bMuse-WeatherApp
//
//  Created by Ilya Kharebashvili on 21.08.2021.
//

import Foundation

protocol WeeklyWeatherConfiguratorProtocol {
    func configure(viewController: WeeklyWeatherViewController)
}

final class WeeklyWeatherConfigurator: WeeklyWeatherConfiguratorProtocol {
    
    func configure(viewController: WeeklyWeatherViewController) {
        let router = WeeklyWeatherRouter(viewController: viewController)
        
        let presenter = WeeklyWeatherPresenter(
            view: viewController,
            router: router
        )
        
        viewController.presenter = presenter
    }
    
}
