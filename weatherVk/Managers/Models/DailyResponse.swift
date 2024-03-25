//
//  DailyResponse.swift
//  weatherVk
//
//  Created by Елизавета Шерман on 25.03.2024.
//

import Foundation

struct DailyResponseBody: Decodable {
    var list: [OndeDayResponse]
}

struct WeatherResponse: Decodable {
    var id: Double
    var main: String
    var description: String
    var icon: String
}

struct TemperatureResponse: Decodable {
    var min: Double
    var max: Double
}

struct OndeDayResponse: Decodable {
    var temp:TemperatureResponse
    var weather: [WeatherResponse]
}
