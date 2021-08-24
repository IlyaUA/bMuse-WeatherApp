//
//  LocationService.swift
//  bMuse-WeatherApp
//
//  Created by Ilya Kharebashvili on 23.08.2021.
//

import CoreLocation

final class LocationService {
    
    static let shared = LocationService()
    
    func getCityName(lat: Double, lng: Double, completion: @escaping (String) -> Void) {
        let location = CLLocation(latitude: CLLocationDegrees(lat), longitude: CLLocationDegrees(lng))
        CLGeocoder().reverseGeocodeLocation(location, completionHandler: { [unowned self] (placemarks, error) in
            if error != nil {
                completion("Unknown place")
            } else {
                let placemark = placemarks?.first
                if let cityName = placemark?.administrativeArea{
                    completion(cityName)
                }
            }
        })
    }
}
