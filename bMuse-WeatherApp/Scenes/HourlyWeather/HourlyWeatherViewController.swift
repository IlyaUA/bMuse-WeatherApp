//
//  HourlyWeatherViewController.swift
//  bMuse-WeatherApp
//
//  Created by Ilya Kharebashvili on 21.08.2021.
//

import UIKit

protocol HourlyWeatherView: AnyObject {
    func setupCurrentWeather(temp: String, cityName: String, date: String, updAt: String, weatherIcon: UIImage?)
    func setTableView()
    func reloadData()
}

final class HourlyWeatherViewController: UIViewController, HourlyWeatherView {
    
    var configurator = HourlyWeatherConfigurator()
    var presenter: HourlyWeatherPresenterProtocol!
    
    @IBOutlet private weak var currentWeather: CurrentWeatherView!
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configurator.configure(viewController: self)
        presenter.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        presenter.viewWillAppear()
    }
    
    func setupCurrentWeather(temp: String, cityName: String, date: String, updAt: String, weatherIcon: UIImage?) {
        currentWeather.setTemperatureLabel(with: temp)
        currentWeather.setCityLabel(with: cityName)
        currentWeather.setDateLabel(with: date)
//        currentWeather.setWeatherIcon(with: weatherIcon)
        currentWeather.setUpdatedAtLabel(with: updAt)
    }
    
    func setTableView() {
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 105
        tableView.separatorStyle = .none
        tableView.register(cellType: WeatherCell.self)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func reloadData() {
        tableView.reloadData()
    }
    
    // MARK: IBActions
    
    @IBAction func openMapPicker(_ sender: Any) {
        presenter.openMapPicker()
    }
    
    
}

extension HourlyWeatherViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return presenter.weatherCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return presenter.configureCell(for: tableView, at: indexPath)
    }
    
}

