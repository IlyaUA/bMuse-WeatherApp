//
//  HourlyWeatherPresenter.swift
//  bMuse-WeatherApp
//
//  Created by Ilya Kharebashvili on 21.08.2021.
//

import UIKit

protocol CoordinateUpdateDelegate: AnyObject {
    func coordinateUpdated()
}

protocol HourlyWeatherPresenterProtocol: LifecyclePresenter {
    var router: HourlyWeatherRouterProtocol { get }
    func openMapPicker()
    var weatherCount: Int { get }
    func configureCell(
        for tableView: UITableView,
        at indexPath: IndexPath
    ) -> UITableViewCell
}

final class HourlyWeatherPresenter: HourlyWeatherPresenterProtocol {
    
    let weatherService = WeatherService.shared
    private var weatherData: [WeatherEntity] = []
    
    private weak var view: HourlyWeatherView?
    private(set) var router: HourlyWeatherRouterProtocol
    
    init(view: HourlyWeatherView?,
         router: HourlyWeatherRouterProtocol) {
        
        self.view = view
        self.router = router
    }
    
    func viewDidLoad() {
        weatherService.coordinationDelegate = self
        setupView()
        preloadData()
        updateWeather()
    }
    
    func viewWillAppear() {
        
    }
    
    func openMapPicker() {
        router.openMapPickerScreen()
    }
    
    // MARK: Private methods
    
    private func setupView() {
        view?.setTableView()
    }
    
    private func updateWeather() {
        weatherService.updateWeather() { [weak self] weather in
            guard let weather = weather else { return }
            self?.weatherData = weather
            self?.setCurrentWeather()
            self?.view?.reloadData()
        }
    }
    
    private func setCurrentWeather() {
        guard let currentWeatherEntity = weatherService.getCurrentWeather() else { return }
        LocationService.shared.getCityName(lat: UserDefaults.standard.double(forKey: "latitude"),
                                           lng: UserDefaults.standard.double(forKey: "longitude")) { [weak self] result in
            self?.view?.setupCurrentWeather(temp: String(currentWeatherEntity.temperature),
                                      cityName: result,
                                      date: currentWeatherEntity.date?.formatted ?? "",
                                      updAt: "Last update: " + (UserDefaults.standard.string(forKey: "updatedAt") ?? ""),
                                      weatherIcon: nil)
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

extension HourlyWeatherPresenter {
    // TableView metthods
    var weatherCount: Int {
        weatherData.count
    }
    
    func configureCell(for tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: WeatherCell.self)
        
        cell.prepareView(model: weatherData[indexPath.row], type: .hourly)
    
        return cell
    }
}

extension HourlyWeatherPresenter: CoordinateUpdateDelegate {
    func coordinateUpdated() {
        updateWeather()
    }
}
