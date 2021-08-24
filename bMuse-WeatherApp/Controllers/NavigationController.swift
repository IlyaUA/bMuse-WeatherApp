//
//  NavigationController.swift
//  bMuse-WeatherApp
//
//  Created by Ilya Kharebashvili on 24.08.2021.
//

import UIKit

class NavigationController: UINavigationController {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return self.topViewController?.preferredStatusBarStyle ?? .lightContent
    }
}
