//
//  Model.swift
//  weatherVk
//
//  Created by Елизавета Шерман on 25.03.2024.
//

import Foundation

struct Model: Decodable {
    var lat: Double
    var lon: Double
    var current: CurrentResponse
    var daily: [DailyResponse]
    
    struct WeatherResponse: Decodable {
        var id: Double
        var main: String
        var description: String
        var icon: String
    }
    
    struct CurrentResponse: Decodable {
        var temp: Double
        var pressure: Double
        var humidity: Double
        var wind_speed: Double
        var weather: [WeatherResponse]
    }
    
    struct Temperature: Decodable {
        var min: Double
        var max: Double
    }
    
    struct DailyResponse: Decodable {
        var temp: Temperature
        var weather: [WeatherResponse]
    }
}
