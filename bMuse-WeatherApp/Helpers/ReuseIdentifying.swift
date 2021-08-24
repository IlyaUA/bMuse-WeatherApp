//
//  ReuseIdentifying.swift
//  bMuse-WeatherApp
//
//  Created by Ilya Kharebashvili on 23.08.2021.
//

import Foundation

protocol ReuseIdentifying {
    static var reuseIdentifier: String { get }
}

extension ReuseIdentifying {
    static var reuseIdentifier: String {
        return String(describing: Self.self)
    }
}
