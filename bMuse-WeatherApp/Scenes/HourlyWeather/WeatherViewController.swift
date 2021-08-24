//
//  WeatherViewController.swift
//  bMuse-WeatherApp
//
//  Created by Ilya Kharebashvili on 21.08.2021.
//

import UIKit

protocol WeatherView: AnyObject {
    func setupCurrentWeather(temp: String, cityName: String, date: String, updAt: String, weatherIcon: UIImage?)
    func setTableView()
    func reloadData()
    func endRefreshing()
}

final class WeatherViewController: UIViewController, WeatherView {
    
    // Internal properties
    var configurator = WeatherConfigurator()
    var presenter: WeatherPresenterProtocol!
    
    @IBOutlet private weak var currentWeather: CurrentWeatherView!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var segmentedControl: UISegmentedControl!
    
    // Private properties
    private let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Weather App"
        configurator.configure(viewController: self)
        presenter.viewDidLoad()
    }
    
    func setupCurrentWeather(temp: String, cityName: String, date: String, updAt: String, weatherIcon: UIImage?) {
        currentWeather.setTemperatureLabel(with: temp)
        currentWeather.setCityLabel(with: cityName)
        currentWeather.setDateLabel(with: date)
        currentWeather.setUpdatedAtLabel(with: updAt)
        currentWeather.setWeatherIcon(with: weatherIcon)
    }
    
    // Setup table view settings
    func setTableView() {
        setRefreshControl()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 105
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.register(cellType: WeatherCell.self)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func reloadData() {
        tableView.reloadData()
    }
    
    func endRefreshing() {
        refreshControl.endRefreshing()
    }
    
    // MARK: IBActions
    
    @IBAction func openMapPicker(_ sender: Any) {
        presenter.openMapPicker()
    }
    
    @IBAction func indexChanged(_ sender: UISegmentedControl) {
        presenter.weatherTypeChanged(with: segmentedControl.selectedSegmentIndex)
    }
    
    // Private methods
    
    // Configure Refresh Control
    private func setRefreshControl() {
        refreshControl.addTarget(self, action: #selector(refreshWeatherData(_:)), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
    
    @objc private func refreshWeatherData(_ sender: Any) {
        // Fetch Weather Data
        presenter.refreshData()
    }
}

extension WeatherViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return presenter.weatherCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return presenter.configureCell(for: tableView, at: indexPath)
    }
    
}

