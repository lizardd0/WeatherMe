//
//  Response.swift
//  weatherVk
//
//  Created by Lychees Saiyan on 3/21/24.
//

import Foundation

struct Response: Decodable {
    var coord: CoordinatesResponse
    var weather: [WeatherResponse]
    var main: MainResponse
    var name: String
    var wind: WindResponse
    var rain: RainResponse
    var clouds: CloudsResponse
}
