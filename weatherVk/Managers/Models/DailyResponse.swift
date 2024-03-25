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

struct MainResponse: Decodable {
    var temp_max: Double
    var temp_min: Double
}

struct OndeDayResponse: Decodable {
    var main: MainResponse
    var weather: [WeatherResponse]
}
