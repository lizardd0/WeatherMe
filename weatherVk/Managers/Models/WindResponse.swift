//
//  WindResponse.swift
//  weatherVk
//
//  Created by Lychees Saiyan on 3/21/24.
//

import Foundation

struct WindResponse: Decodable {
    var speed: Double
    var deg: Double
    var gust: Double
}
