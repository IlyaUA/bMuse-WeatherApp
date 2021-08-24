//
//  MapPickerViewController.swift
//  bMuse-WeatherApp
//
//  Created by Ilya Kharebashvili on 23.08.2021.
//

import UIKit
import MapKit

protocol MapPickerView: AnyObject {
    func setTitle(with text: String)
}

final class MapPickerViewController: UIViewController, MapPickerView {
    
    @IBOutlet private weak var mapView: MKMapView!
    
    var configurator: MapPickerConfiguratorProtocol!
    var presenter: MapPickerPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLongPressGesture()
        configurator.configure(viewController: self)
        presenter.viewDidLoad()
    }
    
    func setTitle(with text: String) {
        self.title = text
    }
    
    // MARK: Private methods
    
    // Adding long press recognition
    private func setLongPressGesture() -> Void {
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(addPinOnMap(press:)))
        longPressGesture.minimumPressDuration = 0.3
        mapView.showsUserLocation = true
        mapView.addGestureRecognizer(longPressGesture)
    }
    
    // Understand the user's choice and delete/save the point
    @objc private func addPinOnMap(press : UILongPressGestureRecognizer) {
        if press.state == .ended {
            let point = press.location(in: self.mapView)
            let coordinates = self.mapView.convert(point, toCoordinateFrom: self.mapView)
            let pointAnnotation = MKPointAnnotation()
            pointAnnotation.coordinate = coordinates
            self.mapView.addAnnotation(pointAnnotation)
            presenter.setCoordinates(coordinate: pointAnnotation.coordinate) { AlertAction in
                switch AlertAction {
                case .cancel:
                    self.mapView.removeAnnotation(pointAnnotation)
                case .confirm:
                    self.mapView.addAnnotation(pointAnnotation)
                }
            }
        }
    }
}
