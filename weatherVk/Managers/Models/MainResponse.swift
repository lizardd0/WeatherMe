//
//  MainResponse.swift
//  weatherVk
//
//  Created by Lychees Saiyan on 3/21/24.
//

import Foundation


struct MainResponse: Decodable {
    var temp: Double
    var feels_like: Double
    var temp_min: Double
    var temp_max: Double
    var pressure: Double
    var humidity: Double
    var sea_level: Double
    var grnd_level: Double
}
