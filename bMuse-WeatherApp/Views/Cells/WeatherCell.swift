//
//  WeatherCell.swift
//  bMuse-WeatherApp
//
//  Created by Ilya Kharebashvili on 23.08.2021.
//

import UIKit

final class WeatherCell: UITableViewCell {
    
    @IBOutlet private weak var background: UIView!
    @IBOutlet private weak var weatherIcon: UIImageView!
    @IBOutlet private weak var date: UILabel!
    @IBOutlet private weak var wind: UILabel!
    @IBOutlet private weak var humidity: UILabel!
    @IBOutlet private weak var temperature: UILabel!
    
    
    func prepareView(model: WeatherEntity, type: WeatherType) {
        setupUI()
        if type == .hourly {
            date.text = model.date?.dateTime
        } else {
            date.text = model.date?.formatted
        }
        
        wind.text = "Wind: " + String(model.wind_speed) + .meter
        humidity.text = "Humidity: " + String(model.humidity) + .percent
        temperature.text = String(model.temperature) + .celsius
        if let symolCode = model.next_1_hour_icon, let weatherImage = UIImage(named: symolCode) {
            weatherIcon.image = weatherImage
        }
    }
    
    private func setupUI() {
        background.layer.cornerRadius = 10
    }
    
}

extension WeatherCell: ReuseIdentifying { }
