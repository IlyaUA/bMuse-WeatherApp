//
//  MapPickerConfigurator.swift
//  bMuse-WeatherApp
//
//  Created by Ilya Kharebashvili on 23.08.2021.
//

import Foundation

protocol MapPickerConfiguratorProtocol {
    func configure(viewController: MapPickerViewController)
}

final class MapPickerConfigurator: MapPickerConfiguratorProtocol {
    
    func configure(viewController: MapPickerViewController) {
        let router = MapPickerRouter(viewController: viewController)
        
        let presenter = MapPickerPresenter(
            view: viewController,
            router: router
        )
        
        viewController.presenter = presenter
    }
    
}
