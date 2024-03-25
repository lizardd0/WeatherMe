//
//  WeatherManager.swift
//  weatherVk
//
//  Created by Lychees Saiyan on 3/21/24.
//

import Foundation
import CoreLocation

enum WeatherError: Error {
    case failedToFetchData
}


final class WeatherManager {
    func getWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) async throws -> ResponseBody {
        guard let weatherURL = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=c815cd4cc1a1bdae098b147bc2f751b6&units=metric") else {
            fatalError("Wrong URL")
        }
        
        let request = URLRequest(url: weatherURL)

        guard let (data, response) = try? await URLSession.shared.data(for: request) else {
            print("No data or response received")
            
            throw WeatherError.failedToFetchData
        }
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            fatalError("Failed getting weather data")
        }
        
        let decodedData =  try JSONDecoder().decode(ResponseBody.self, from: data)
        
        
        return decodedData
    }
    
    
    func getForecast(latitude: CLLocationDegrees, longitude: CLLocationDegrees) async throws -> DailyResponseBody {
        guard let forecastURL = URL(string: "https://api.openweathermap.org/data/2.5/forecast/daily?lat=\(latitude)&lon=\(longitude)&cnt=5&appid=c815cd4cc1a1bdae098b147bc2f751b6&units=metric") else {
            fatalError("Wrong URL")
        }
        
        var request = URLRequest(url: forecastURL)

        guard let (data, response) = try? await URLSession.shared.data(for: request) else {
            print("No data or response received")
            
            throw WeatherError.failedToFetchData
        }
        print(response)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            fatalError("Failed getting forecast data")
        }
        
        let decodedData =  try JSONDecoder().decode(DailyResponseBody.self, from: data)
        
        print(decodedData)
        
        return decodedData
    }
}
