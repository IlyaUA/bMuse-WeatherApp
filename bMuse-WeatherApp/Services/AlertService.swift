//
//  AlertService.swift
//  bMuse-WeatherApp
//
//  Created by Ilya Kharebashvili on 23.08.2021.
//

import UIKit

final class AlertService {
    
    static let shared = AlertService()
    
    func universalAlert(title: String, message: String, actions: [(title: String, action: () -> Void)]?) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        if let actions = actions {
            for action in actions {
                let alertAction = UIAlertAction(title: action.title, style: .default) { _ in
                    action.action()
                }
                alert.addAction(alertAction)
            }
        } else {
            let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(okAction)
        }
        
        return alert
    }
}

public enum AlertAction {
    case cancel
    case confirm
}
