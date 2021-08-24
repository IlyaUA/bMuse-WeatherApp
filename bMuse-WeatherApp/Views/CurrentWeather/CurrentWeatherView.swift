//
//  CurrentWeatherView.swift
//  bMuse-WeatherApp
//
//  Created by Ilya Kharebashvili on 23.08.2021.
//

import UIKit

class CurrentWeatherView: NibView {
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperature: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var updatedAtLabel: UILabel!
    
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var backgroundStackView: UIView!
    
    
    
    override func setupUI() {
        backgroundStackView.layer.borderWidth = 1
        backgroundStackView.layer.borderColor = UIColor.white.cgColor
        backgroundStackView.layer.cornerRadius = 15
    }
    
    // MARK: - Public methods
    
    func setCityLabel(with cityName: String) {
        cityLabel.text = cityName
    }
    
    func setTemperatureLabel(with temp: String) {
        temperature.text = temp
    }
    
    func setDateLabel(with date: String) {
        dateLabel.text = date
    }
    
    func setUpdatedAtLabel(with date: String) {
        updatedAtLabel.text = date
    }
    
    func setWeatherIcon(with image: UIImage?) {
        weatherIcon.image = image
    }
    
}
