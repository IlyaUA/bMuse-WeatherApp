//
//  HourlyWeatherConfigurator.swift
//  bMuse-WeatherApp
//
//  Created by Ilya Kharebashvili on 21.08.2021.
//

import Foundation

protocol HourlyWeatherConfiguratorProtocol {
    func configure(viewController: HourlyWeatherViewController)
}

final class HourlyWeatherConfigurator: HourlyWeatherConfiguratorProtocol {
    
    func configure(viewController: HourlyWeatherViewController) {
        let router = HourlyWeatherRouter(viewController: viewController)
        
        let presenter = HourlyWeatherPresenter(
            view: viewController,
            router: router
        )
        
        viewController.presenter = presenter
    }
    
}
