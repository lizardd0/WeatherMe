//
//  WeatherResponse.swift
//  weatherVk
//
//  Created by Lychees Saiyan on 3/21/24.
//

import Foundation

struct WeatherResponse: Decodable {
    var id: Double
    var main: String
    var description: String
    var icon: String
}
