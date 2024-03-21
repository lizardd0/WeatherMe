//
//  Rain+Clouds Responses.swift
//  weatherVk
//
//  Created by Lychees Saiyan on 3/21/24.
//

import Foundation

struct RainResponse: Decodable {
    var h1: Double
}

struct CloudsResponse: Decodable {
    var all: Double
}
