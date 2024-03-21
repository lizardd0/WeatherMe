//
//  WeatherManager.swift
//  weatherVk
//
//  Created by Lychees Saiyan on 3/21/24.
//

import Foundation
import CoreLocation

final class WeatherManager {
    func getWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) async throws -> Response {
        guard let weatherURL = URL(string: "http://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=\("72dd10da584a7ec0c6a8b4da5c119fbe")&units=metric") else {
            fatalError("Wrong URL")
        }
        
        let request = URLRequest(url: weatherURL)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            fatalError("Failed getting weather data")
        }
        
        let decodedData =  try JSONDecoder().decode(Response.self, from: data)
        
        return decodedData
    }
}
