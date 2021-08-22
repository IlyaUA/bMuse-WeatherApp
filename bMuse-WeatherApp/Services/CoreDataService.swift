//
//  CoreDataService.swift
//  bMuse-WeatherApp
//
//  Created by Ilya Kharebashvili on 22.08.2021.
//

import CoreData
import UIKit

class CoreDataServie {
    func configureContext() -> NSManagedObjectContext? {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return nil}
        let context = appDelegate.persistentContainer.viewContext
        return context
    }
    
    func saveContext(with context: NSManagedObjectContext) -> Bool {
        do {
            try context.save()
            return true
        } catch {
            return false
        }
    }
}
