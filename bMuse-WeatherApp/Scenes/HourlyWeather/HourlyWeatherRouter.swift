//
//  HourlyWeatherRouter.swift
//  bMuse-WeatherApp
//
//  Created by Ilya Kharebashvili on 21.08.2021.
//

import UIKit

protocol HourlyWeatherRouterProtocol: CommonRouter {
    func openMapPickerScreen()
}

final class HourlyWeatherRouter: CommonRouterImplementation, HourlyWeatherRouterProtocol {
    func openMapPickerScreen() {
        let mapScreen = MapPickerViewController.instantiateFrom(appStoryboard: .map)
        mapScreen.configurator = MapPickerConfigurator()
        push(mapScreen)
    }
    
    
}
