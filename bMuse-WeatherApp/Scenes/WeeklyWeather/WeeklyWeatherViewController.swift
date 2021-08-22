//
//  WeeklyWeatherViewController.swift
//  bMuse-WeatherApp
//
//  Created by Ilya Kharebashvili on 21.08.2021.
//

import UIKit

protocol WeeklyWeatherView: class {
    
}

final class WeeklyWeatherViewController: UIViewController, WeeklyWeatherView {
    
    var configurator = WeeklyWeatherConfigurator()
    var presenter: WeeklyWeatherPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configurator.configure(viewController: self)
        presenter.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        presenter.viewWillAppear()
    }
}
