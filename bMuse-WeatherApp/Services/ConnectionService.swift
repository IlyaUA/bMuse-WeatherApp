//
//  ConnectionService.swift
//  bMuse-WeatherApp
//
//  Created by Ilya Kharebashvili on 21.08.2021.
//

import Foundation
import Reachability

final class ConnectionService {
    
    static let shared = ConnectionService()
    public let reachability = try! Reachability()

    private init() {}

    public func isConnected() -> Bool {

        switch reachability.connection {
        case .none:
            NotificationCenter.default.post(name: .reachabilityChanged, object: false)
            return false
        default:
            NotificationCenter.default.post(name: .reachabilityChanged, object: true)
            return true
        }
    }
    
    func startNotifier() {
        do {
            try reachability.startNotifier()
        } catch {
            NSLog("Unable to start notifier")
        }
    }
    
    func stopNotifier() {
        reachability.stopNotifier()
    }
    
    public func noInternetHeader(width: CGFloat) -> UIView? {
        if let view = Bundle.main.loadNibNamed("NoInternetHeader", owner: nil, options: nil)?.first as? UIView {
            view.frame.size.width = width
            return view
        }
        return nil
    }
    
    func showNoInternetPopUp(over view: UIViewController, completionHandler: () -> Void) {
        let title = "failed_to_sign_in"
        let message = "have_no_internet_connection"
        let action = "ok"
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: action, style: .default, handler: nil))
    
        view.present(alert, animated: true)
        completionHandler()
    }
}
