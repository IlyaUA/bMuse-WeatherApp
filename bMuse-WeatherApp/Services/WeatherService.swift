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
    var weathers: [WeatherEntity] = []
    
    func updateWeather(type: WeatherType = .hourly, completion: @escaping ([WeatherEntity]?) -> Void) {
        weatherManager.getWeather(lat: 0, lng: 0) { [self] result in
            switch result {
            case .success(let value):
                saveWeatherToDB(with: value, type: type, completion: completion)
            case .failure(let error):
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
            case .weekly:
                getWeeklyWeather(completion: completion)
            }
            getWeeklyWeather(completion: completion)
            print("Successfully saved +++")
        } else {
            print("SAVE ERROR")
        }
    }
    
    func getHourlyWeather(completion: @escaping ([WeatherEntity]?) -> Void) {
        guard let context = coreDataService.configureContext() else { return }
        let fetchRequest: NSFetchRequest<WeatherEntity> = WeatherEntity.fetchRequest()
        fetchRequest.returnsObjectsAsFaults = false
        let fromDate = Date() as NSDate
        let toDate = Date.tomorrow as NSDate
        fetchRequest.predicate = NSPredicate(format: "(date >= %@) AND (date <= %@)", fromDate, toDate)
        
        do {
            weathers = try context.fetch(fetchRequest)
            completion(weathers)
            print("Successfully fetched +++")
        } catch let error as NSError {
            completion(nil)
            NSLog("FETCH ERROR", error.localizedDescription)
        }
    }
    
    func getWeeklyWeather(completion: @escaping ([WeatherEntity]?) -> Void) {
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
            weathers = try context.fetch(fetchRequest)
            completion(weathers)
            print("Successfully fetched +++")
        } catch let error as NSError {
            completion(nil)
            NSLog("FETCH ERROR", error.localizedDescription)
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
