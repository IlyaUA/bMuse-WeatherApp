//
//  WeatherConfigurator.swift
//  bMuse-WeatherApp
//
//  Created by Ilya Kharebashvili on 21.08.2021.
//

import Foundation

protocol WeatherConfiguratorProtocol {
    func configure(viewController: WeatherViewController)
}

final class WeatherConfigurator: WeatherConfiguratorProtocol {
    
    func configure(viewController: WeatherViewController) {
        let router = WeatherRouter(viewController: viewController)
        
        let presenter = WeatherPresenter(
            view: viewController,
            router: router
        )
        
        viewController.presenter = presenter
    }
    
}
