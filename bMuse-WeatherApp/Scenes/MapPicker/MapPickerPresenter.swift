//
//  MapPickerPresenter.swift
//  bMuse-WeatherApp
//
//  Created by Ilya Kharebashvili on 23.08.2021.
//

import UIKit
import MapKit
import CoreLocation

protocol MapPickerPresenterProtocol: LifecyclePresenter {
    var router: MapPickerRouterProtocol { get }
    func setCoordinates(coordinate: CLLocationCoordinate2D, completionHandler: @escaping (AlertAction) -> Void)
}

final class MapPickerPresenter: MapPickerPresenterProtocol {
    
    private weak var view: MapPickerView?
    private(set) var router: MapPickerRouterProtocol
    
    init(view: MapPickerView?,
         router: MapPickerRouterProtocol) {
        
        self.view = view
        self.router = router
    }
    
    func viewDidLoad() {
        view?.setTitle(with: "Long Press For Choose")
    }
    
    func setCoordinates(coordinate: CLLocationCoordinate2D, completionHandler: @escaping (AlertAction) -> Void) {
        
        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        CLGeocoder().reverseGeocodeLocation(location, completionHandler: { [unowned self] (placemarks, error) in
            if error != nil {
                let alert = UIAlertController.universalAlert(title: "Something went wrong", message: error!.localizedDescription, actions: nil)
                router.presentAlert(with: alert)
            } else {
                let placemark = placemarks?.first
                
                if let cityName = placemark?.administrativeArea , let countryName = placemark?.country {
                    
                    let alert = UIAlertController.universalAlert(title: cityName + ", " + countryName, message: "Show the weather in this city?", actions: [(title:"Cancel",action: {
                        completionHandler(.cancel)
                    })
                    , (title:"OK", action: {
                        WeatherService.shared.coordinates = (Double(coordinate.latitude), Double(coordinate.longitude))
                        completionHandler(.confirm)
                        router.popViewController(animated: true)
                    })])
                    router.presentAlert(with: alert)
                }
                else {
                    let alert = UIAlertController.universalAlert(title: "Error", message: "Failed to recognize the location, try another.", actions:[(title:"OK",action: {
                        completionHandler(.cancel)
                    })])
                    router.presentAlert(with: alert)
                }
            }
        })
    }
}
