//
//  WeatherRouter.swift
//  bMuse-WeatherApp
//
//  Created by Ilya Kharebashvili on 21.08.2021.
//

import UIKit

protocol WeatherRouterProtocol: CommonRouter {
    func openMapPickerScreen()
}

final class WeatherRouter: CommonRouterImplementation, WeatherRouterProtocol {
    
    func openMapPickerScreen() {
        let mapScreen = MapPickerViewController.instantiateFrom(appStoryboard: .map)
        mapScreen.configurator = MapPickerConfigurator()
        push(mapScreen)
    }
}
