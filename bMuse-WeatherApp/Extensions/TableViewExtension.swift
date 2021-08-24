//
//  TableViewExtension.swift
//  bMuse-WeatherApp
//
//  Created by Ilya Kharebashvili on 23.08.2021.
//

import UIKit

extension UITableView {
    
    // Universal method for registration UITableViewCell
    final func register<T: UITableViewCell>(cellType: T.Type)
        where T: ReuseIdentifying {
            self.register(UINib.init(nibName: T.reuseIdentifier, bundle: Bundle.main),
                          forCellReuseIdentifier: T.reuseIdentifier)
    }
    
    // Retrieving cell reuseIdentifier
    final func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath, cellType: T.Type = T.self) -> T
          where T: ReuseIdentifying {
              guard let cell = self.dequeueReusableCell(withIdentifier: cellType.reuseIdentifier, for: indexPath) as? T else {
                  fatalError(
                      "Failed to dequeue a cell with identifier \(cellType.reuseIdentifier) matching type \(cellType.self). "
                  )
              }
              return cell
      }
}
