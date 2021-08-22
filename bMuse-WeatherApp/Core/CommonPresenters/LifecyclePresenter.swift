//
//  LifecyclePresenter.swift
//  bMuse-WeatherApp
//
//  Created by Ilya Kharebashvili on 21.08.2021.
//

import Foundation

protocol LifecyclePresenter {
    func viewWillAppear()
    func viewDidLoad()
    func viewWillDisappear()
    func viewDidAppear()
    func viewDidDisappear()
}

extension LifecyclePresenter {
    func viewWillAppear() { }
    func viewDidLoad() { }
    func viewWillDisappear() { }
    func viewDidAppear() { }
    func viewDidDisappear() { }
}
