//
//  AppStoryboard.swift
//  bMuse-WeatherApp
//
//  Created by Ilya Kharebashvili on 21.08.2021.
//

import UIKit

enum AppStoryboard: String {
    
    case main = "Main"
    case hourly = "Weather"
    case map = "MapPicker"
    case navigation = "Navigation"
    
    
    var instance: UIStoryboard {
        return UIStoryboard(name: rawValue, bundle: nil)
    }
    
    func viewController<T: UIViewController>(viewControllerClass: T.Type) -> T {
        let storyboardID = (viewControllerClass as UIViewController.Type).storyboardID
        return instance.instantiateViewController(withIdentifier: storyboardID) as! T
    }
}

extension UIViewController {
    class var storyboardID: String {
        return "\(self)"
    }
    
    static func instantiateFrom(appStoryboard: AppStoryboard) -> Self {
        return appStoryboard.viewController(viewControllerClass: self)
    }
}
