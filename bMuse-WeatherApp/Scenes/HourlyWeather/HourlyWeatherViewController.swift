//
//  HourlyWeatherViewController.swift
//  bMuse-WeatherApp
//
//  Created by Ilya Kharebashvili on 21.08.2021.
//

import UIKit

protocol HourlyWeatherView: AnyObject {
    
}

final class HourlyWeatherViewController: UIViewController, HourlyWeatherView {
    
    var configurator = HourlyWeatherConfigurator()
    var presenter: HourlyWeatherPresenterProtocol!
    
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
