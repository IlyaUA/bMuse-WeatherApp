//
//  CommonRouter.swift
//  bMuse-WeatherApp
//
//  Created by Ilya Kharebashvili on 21.08.2021.
//

import UIKit

// Class for navigating the application. You can also add any loaders or toasts here and call like "router.presentToast or router.presentLoader"
public protocol CommonRouter: AnyObject {
    var viewController: UIViewController? { get set }
    
    func present(viewController: UIViewController, animated: Bool)
    func push(_ viewController: UIViewController, animated: Bool)
    func dismiss(animated: Bool)
    func popToRoot(animated: Bool)
    func popViewController(animated: Bool)
    func presentAlert(with alert: UIAlertController)
}

extension CommonRouter {
    func push(_ viewController: UIViewController) {
        push(viewController, animated: true)
    }
}

open class CommonRouterImplementation: CommonRouter {
    public weak var viewController: UIViewController?
    
    public init(viewController: UIViewController) {
        self.viewController = viewController
    }
            
    var navController: UINavigationController? {
        return viewController?.navigationController
    }
    
    public func push(_ viewController: UIViewController, animated: Bool = true) {
        DispatchQueue.main.async {
            self.navController?.pushViewController(viewController, animated: animated)
        }
    }
    
    public func present(viewController: UIViewController, animated: Bool = true) {
        DispatchQueue.main.async {
            self.viewController?.present(viewController, animated: animated)
        }
    }
    
    public func dismiss(animated: Bool) {
        viewController?.dismiss(animated: animated)
    }
    
    public func popToRoot(animated: Bool) {
        navController?.popToRootViewController(animated: animated)
    }
    
    public func popViewController(animated: Bool) {
        navController?.popViewController(animated: animated)
    }
    
    public func presentAlert(with alert: UIAlertController) {
        DispatchQueue.main.async {
            self.viewController?.present(alert, animated: true)
        }
    }
}
