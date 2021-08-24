//
//  Nibable.swift
//  bMuse-WeatherApp
//
//  Created by Ilya Kharebashvili on 23.08.2021.
//

import UIKit

protocol Nibable: ReuseIdentifying {
    static var nib: UINib? { get }
}

extension Nibable {
    static var nib: UINib? {
        let identifier = self.reuseIdentifier
        guard Bundle.main.path(forResource: identifier, ofType: "nib") != nil else {
            return nil
        }
        return UINib(nibName: identifier, bundle: nil)
    }
}
