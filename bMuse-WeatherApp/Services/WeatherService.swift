//
//  WeatherService.swift
//  bMuse-WeatherApp
//
//  Created by Ilya Kharebashvili on 22.08.2021.
//

import Foundation
import CoreData
import UIKit

class WeatherService {
    
    static let shared = WeatherService()
    private let weatherManager = WeatherManager()
    private let coreDataService = CoreDataServie()
    
    var coordinates: (lat: Double, lng: Double) {
        didSet {
            UserDefaults.standard.set(coordinates.lat, forKey: "latitude")
            UserDefaults.standard.set(coordinates.lng, forKey: "longitude")
            UserDefaults.standard.synchronize()
            NotificationCenter.default.post(name: Notification.Name("UpdateWeather"), object: nil)
        }
    }
    
    private init() {
        coordinates = (lat: UserDefaults.standard.double(forKey: "latitude"),
                       lng: UserDefaults.standard.double(forKey: "longitude"))
    }
    
    // MARK: Internal methods

    func updateWeather(type: WeatherType = .hourly, completion: @escaping ([WeatherEntity]?) -> Void) {
        weatherManager.getWeather(lat: coordinates.lat, lng: coordinates.lng) { [weak self] result in
            switch result {
            case .success(let value):
                UserDefaults.standard.set(value.properties?.meta?.updatedAt?.formatted, forKey: "updatedAt")
                UserDefaults.standard.synchronize()
                self?.saveWeatherToDB(with: value, type: type, completion: completion)
            case .failure(let error):
                switch type {
                case .hourly:
                    self?.getHourlyWeather(completion: completion)
                case .daily:
                    self?.getdailyWeather(completion: completion)
                }
                print(error.localizedDescription)
            }
        }
    }
    
    func saveWeatherToDB(with model: WeatherModel, type: WeatherType, completion: @escaping ([WeatherEntity]?) -> Void) {
        removeAllData()
        guard let context = coreDataService.configureContext() else { return }
        guard let entity = NSEntityDescription.entity(forEntityName: "WeatherEntity", in: context) else { return }
        model.properties?.timeseries?.forEach { info in
            let weatherObject = WeatherEntity(entity: entity, insertInto: context)
            weatherObject.date = info.time
            if let humidity = info.data?.instant?.details?.relativeHumidity {
                weatherObject.humidity = humidity
            }
            weatherObject.next_12_hour_icon = info.data?.next12_Hours?.summary?.symbolCode
            weatherObject.next_1_hour_icon = info.data?.next1_Hours?.summary?.symbolCode
            weatherObject.next_6_hour_icon = info.data?.next6_Hours?.summary?.symbolCode
            if let temperature = info.data?.instant?.details?.airTemperature {
                weatherObject.temperature = temperature
            }
            if let temperatureMax = info.data?.next6_Hours?.details?.airTemperatureMax {
                weatherObject.temperature_max = temperatureMax
            }
            if let temperatureMin = info.data?.next6_Hours?.details?.airTemperatureMin {
                weatherObject.temperature_max = temperatureMin
            }
            if let windSpeed = info.data?.instant?.details?.windSpeed {
                weatherObject.wind_speed = windSpeed
            }
        }
        
        if coreDataService.saveContext(with: context) {
            switch type {
            case .hourly:
                getHourlyWeather(completion: completion)
            case .daily:
                getdailyWeather(completion: completion)
            }
        } else {
            print("SAVE ERROR")
        }
    }
    
    func preloadData(type: WeatherType = .hourly, completion: @escaping ([WeatherEntity]?) -> Void) {
        switch type {
        case .hourly:
            getHourlyWeather(completion: completion)
        case .daily:
            getdailyWeather(completion: completion)
        }
    }
    
    func getHourlyWeather(completion: @escaping ([WeatherEntity]?) -> Void) {
        guard let context = coreDataService.configureContext() else { return }
        
        let fetchRequest: NSFetchRequest<WeatherEntity> = WeatherEntity.fetchRequest()
        fetchRequest.returnsObjectsAsFaults = false
        let fromDate = Date() as NSDate
        let toDate = Date.tomorrow as NSDate
        fetchRequest.predicate = NSPredicate(format: "(date >= %@) AND (date <= %@)", fromDate, toDate)
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "date", ascending: true)]
        do {
            let objects = try context.fetch(fetchRequest)
            completion(objects)
            print("Successfully fetched +++")
        } catch let error as NSError {
            completion(nil)
            NSLog("FETCH ERROR", error.localizedDescription)
        }
    }
    
    func getdailyWeather(completion: @escaping ([WeatherEntity]?) -> Void) {
        guard let context = coreDataService.configureContext() else { return }
        
        let fetchRequest: NSFetchRequest<WeatherEntity> = WeatherEntity.fetchRequest()
        fetchRequest.returnsObjectsAsFaults = false
        let fromDate = Date.tomorrow as NSDate
        fetchRequest.predicate = NSPredicate(format: "date >= %@", fromDate)
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "date", ascending: true)]
        do {
            let objects = try context.fetch(fetchRequest)
            
            var filteredObjects: [WeatherEntity] = []
            objects.forEach { item in
                if !filteredObjects.contains(where: { $0.date?.withoutTime == item.date?.withoutTime }) {
                    filteredObjects.append(item)
                }
            }
            
            completion(filteredObjects)
            print("Successfully fetched +++")
        } catch let error as NSError {
            completion(nil)
            NSLog("FETCH ERROR", error.localizedDescription)
        }
    }
    
    func getAllWeather(completion: @escaping ([WeatherEntity]?) -> Void) {
        guard let context = coreDataService.configureContext() else { return }
        
        let fetchRequest: NSFetchRequest<WeatherEntity> = WeatherEntity.fetchRequest()
        
        do {
            let objects = try context.fetch(fetchRequest)
            completion(objects)
            print("Successfully fetched +++")
        } catch let error as NSError {
            completion(nil)
            NSLog("FETCH ERROR", error.localizedDescription)
        }
    }
    
    func getCurrentWeather() -> WeatherEntity? {
        guard let context = coreDataService.configureContext() else { return nil }
        
        let fetchRequest: NSFetchRequest<WeatherEntity> = WeatherEntity.fetchRequest()
        fetchRequest.returnsObjectsAsFaults = false
        let current = Date() as NSDate
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "date", ascending: true)]
        fetchRequest.predicate = NSPredicate(format: "date >= %@", current)
        fetchRequest.fetchLimit = 1
        
        do {
            let objects = try context.fetch(fetchRequest)
            return objects.first
        } catch {
            return nil
        }
    }
    
    func removeAllData() {
        guard let context = coreDataService.configureContext() else { return }
        
        getAllWeather { objects in
            objects?.forEach { object in
                context.delete(object)
            }
        }
        coreDataService.saveContext(with: context)
    }
}

class location {
    var lat: Double = UserDefaults.standard.double(forKey: "lat") 
    var lng: Double = UserDefaults.standard.double(forKey: "lng")
}
