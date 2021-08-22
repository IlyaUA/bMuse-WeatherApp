//
//  WeatherModel.swift
//  bMuse-WeatherApp
//
//  Created by Ilya Kharebashvili on 22.08.2021.
//

import Foundation

// MARK: - WeatherModel
struct WeatherModel: Codable {
    let type: String?
    let geometry: Geometry?
    let properties: Properties?
}

// MARK: - Geometry
struct Geometry: Codable {
    let type: String?
    let coordinates: [Double]?
}

// MARK: - Properties
struct Properties: Codable {
    let meta: Meta?
    let timeseries: [Timesery]?
}

// MARK: - Meta
struct Meta: Codable {
    let updatedAt: Date?

    enum CodingKeys: String, CodingKey {
        case updatedAt = "updated_at"
    }
}

// MARK: - Timesery
struct Timesery: Codable {
    let time: Date?
    let data: DataClass?
}

// MARK: - DataClass
struct DataClass: Codable {
    let instant: Instant?
    let next12_Hours: Next12_Hours?
    let next1_Hours: Next1_Hours?
    let next6_Hours: Next6_Hours?

    enum CodingKeys: String, CodingKey {
        case instant
        case next12_Hours = "next_12_hours"
        case next1_Hours = "next_1_hours"
        case next6_Hours = "next_6_hours"
    }
}

// MARK: - Instant
struct Instant: Codable {
    let details: InstantDetails?
}

// MARK: - InstantDetails
struct InstantDetails: Codable {
    let airPressureAtSeaLevel, airTemperature, relativeHumidity: Double?
    let ultravioletIndexClearSky, windFromDirection: Double?
    let windSpeed: Double?

    enum CodingKeys: String, CodingKey {
        case airPressureAtSeaLevel = "air_pressure_at_sea_level"
        case airTemperature = "air_temperature"
        case relativeHumidity = "relative_humidity"
        case ultravioletIndexClearSky = "ultraviolet_index_clear_sky"
        case windFromDirection = "wind_from_direction"
        case windSpeed = "wind_speed"
    }
}

// MARK: - Next12_Hours
struct Next12_Hours: Codable {
    let summary: Summary?
}

// MARK: - Summary
struct Summary: Codable {
    let symbolCode: String?

    enum CodingKeys: String, CodingKey {
        case symbolCode = "symbol_code"
    }
}

// MARK: - Next1_Hours
struct Next1_Hours: Codable {
    let summary: Summary?
    let details: Next1_HoursDetails?
}

// MARK: - Next1_HoursDetails
struct Next1_HoursDetails: Codable {
    let precipitationAmount: Double?

    enum CodingKeys: String, CodingKey {
        case precipitationAmount = "precipitation_amount"
    }
}

// MARK: - Next6_Hours
struct Next6_Hours: Codable {
    let summary: Summary?
    let details: Next6_HoursDetails?
}

// MARK: - Next6_HoursDetails
struct Next6_HoursDetails: Codable {
    let airTemperatureMax, airTemperatureMin: Double?
    let precipitationAmount: Double?

    enum CodingKeys: String, CodingKey {
        case airTemperatureMax = "air_temperature_max"
        case airTemperatureMin = "air_temperature_min"
        case precipitationAmount = "precipitation_amount"
    }
}
