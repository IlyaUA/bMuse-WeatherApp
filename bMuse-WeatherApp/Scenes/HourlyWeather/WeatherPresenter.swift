//
//  WeatherPresenter.swift
//  bMuse-WeatherApp
//
//  Created by Ilya Kharebashvili on 21.08.2021.
//

import UIKit

protocol WeatherPresenterProtocol: LifecyclePresenter {
    var router: WeatherRouterProtocol { get }
    func openMapPicker()
    var weatherCount: Int { get }
    func configureCell(
        for tableView: UITableView,
        at indexPath: IndexPath
    ) -> UITableViewCell
    func weatherTypeChanged(with index: Int)
    func refreshData()
}

final class WeatherPresenter: WeatherPresenterProtocol {
    
    let weatherService = WeatherService.shared
    private var weatherData: [WeatherEntity] = []
    private var weatherType: WeatherType = .hourly {
        didSet {
            updateWeather()
        }
    }
    
    private weak var view: WeatherView?
    private(set) var router: WeatherRouterProtocol
    
    init(view: WeatherView?,
         router: WeatherRouterProtocol) {
        
        self.view = view
        self.router = router
    }
    
    func viewDidLoad() {
        setObserver()
        setupView()
        preloadData()
        updateWeather()
    }
    
    func openMapPicker() {
        router.openMapPickerScreen()
    }
    
    func weatherTypeChanged(with index: Int) {
        switch index {
        case 0:
            weatherType = .hourly
        case 1:
            weatherType = .daily
        default:
            weatherType = .hourly
        }
        
    }
    
    func refreshData() {
        updateWeather()
    }
    
    // MARK: Private methods
    
    private func setObserver() {
        _ = NotificationCenter
            .default
            .addObserver(
                forName: Notification.Name("UpdateWeather"),
                object: nil,
                queue: .main
            ) { [weak self] _ in
                self?.updateWeather()
            }
    }
    
    private func setupView() {
        view?.setTableView()
    }
    
    private func updateWeather() {
        weatherService.updateWeather(type: weatherType) { [weak self] weather in
            guard let weather = weather else { return }
            self?.weatherData = weather
            self?.setCurrentWeather()
            self?.view?.reloadData()
            self?.view?.endRefreshing()
        }
    }
    
    private func setCurrentWeather() {
        guard let currentWeatherEntity = weatherService.getCurrentWeather() else { return }
        LocationService.shared.getCityName(lat: UserDefaults.standard.double(forKey: "latitude"),
                                           lng: UserDefaults.standard.double(forKey: "longitude")) { [weak self] result in
            self?.view?.setupCurrentWeather(temp: String(currentWeatherEntity.temperature) + .celsius,
                                      cityName: result,
                                      date: currentWeatherEntity.date?.formatted ?? "",
                                      updAt: "Last update: " + (UserDefaults.standard.string(forKey: "updatedAt") ?? ""),
                                      weatherIcon: UIImage(named: currentWeatherEntity.next_1_hour_icon ?? ""))
        }
        
    }
    
    private func preloadData() {
        weatherService.preloadData(type: .hourly) { [weak self] weather in
            guard let weather = weather else { return }
            self?.weatherData = weather
            self?.setCurrentWeather()
            self?.view?.reloadData()
        }
    }
}

extension WeatherPresenter {
    // TableView metthods
    var weatherCount: Int {
        weatherData.count
    }
    
    func configureCell(for tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: WeatherCell.self)
        
        cell.prepareView(model: weatherData[indexPath.row], type: weatherType)
        return cell
    }
}
