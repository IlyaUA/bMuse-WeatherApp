//
//  TabController.swift
//  bMuse-WeatherApp
//
//  Created by Ilya Kharebashvili on 21.08.2021.
//

import UIKit

protocol TabBarControllerDelegate: AnyObject {
    func scrollToTop()
}

class TabController: UITabBarController {
        
    let connectionService = ConnectionService.shared
    var connectionView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        connectionView = connectionService.noInternetHeader(width: view.frame.width)
        view.addSubview(connectionView)
        connectionView.isHidden = true
        
        NotificationCenter.default.addObserver(self, selector: #selector(connectionChanged), name: .reachabilityChanged, object: connectionService.reachability)
        do {
            try connectionService.reachability.startNotifier()
        } catch {
            NSLog("Could not start reachability notifier.")
        }
        
        selectedIndex = 2
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBar.superview?.setNeedsLayout()
        tabBar.invalidateIntrinsicContentSize()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        connectionView.frame.origin.y = tabBar.frame.origin.y - connectionView.frame.height
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return self.selectedViewController?.preferredStatusBarStyle ?? .lightContent
    }
}

extension TabController {
    
    @objc func connectionChanged() {
        if !connectionService.isConnected() {
            connectionView.isHidden = false
        } else {
            connectionView.isHidden = true
        }
    }
}

extension UITabBarController {
    
    func hideTabBarAnimated(hide: Bool) {
        if !hide {
            var frame = self.tabBar.frame
            frame.origin.y = self.view.frame.size.height - (frame.size.height)
            UIView.animate(withDuration: 0.5, animations: {
                 self.tabBar.frame = frame
            })
        } else {
            var frame = self.tabBar.frame
            frame.origin.y = self.view.frame.size.height + (frame.size.height)
            UIView.animate(withDuration: 0.5, animations: {
                self.tabBar.frame = frame
            })

        }
    }
}
