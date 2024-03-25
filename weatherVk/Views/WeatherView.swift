//
//  WeatherView.swift
//  weatherVk
//
//  Created by Елизавета Шерман on 24.03.2024.
//

import UIKit
import CoreLocation

final class WeatherViewController: UIViewController {
    private enum Constants {
        static let helveticaLight = "HelveticaNeue-Light"
        static let weekForecast = "Weekly Forecast"
    }
    
    var locationManager = LocationManager.shared
    var weatherManager = WeatherManager()
    var weather: ResponseBody?
    var forecast: DailyResponseBody?
    private var weatherTodayView = WeatherTodayView()
    
    
    private var weeklyLabel = UILabel()
    
    private var weekTableView = UITableView(frame: .zero, style: .plain)
    
    private let geocoder = CLGeocoder()
    
    private var placeLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        loadWeather()
//        loadForecast()
        
        configurePlaceLabel()
        view.addSubview(placeLabel)
        
        view.addSubview(weatherTodayView)
        
        configureWeeklyLabel()
        view.addSubview(weeklyLabel)
        
        configureWeekTableView()
        view.addSubview(weekTableView)
        
        configureConstraints()
    }
    
    private func loadWeather() {
        Task {
            do {
                if let weatherData = try? await weatherManager.getWeather(latitude: locationManager.location?.latitude ?? 0, longitude: locationManager.location?.longitude ?? 0) {
                    weather = weatherData
                    weatherTodayView.getWeatherData(weatherData)

                } else {
                    print("Weather data is nil")
                }
            } catch {
                print("Failed to fetch data!")
            }
        }
    }
    
    private func loadForecast() {
        Task {
            do {
                if let forecastData = try? await weatherManager.getForecast(latitude: locationManager.location?.latitude ?? 0, longitude: locationManager.location?.longitude ?? 0) {
                    forecast = forecastData
                } else {
                    print("Forecast data is nil")
                }
            } catch {
                print("Failed to fetch data!")
            }
        }
    }
    
    private func configurePlaceLabel() {
        if let location = locationManager.location {
            getLocationName(from: location) { locationName in
                if let locationName = locationName {
                    self.placeLabel.attributedText = self.attributedTextLabel("mappin.and.ellipse", locationName)
                } else {
                    self.placeLabel.attributedText = self.attributedTextLabel("mappin.and.ellipse", "")
                }
            }
        }
        
        placeLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func attributedTextLabel(_ image: String, _ text: String) -> NSMutableAttributedString {
        let fullString = NSMutableAttributedString()
        let myAttribute = [ NSAttributedString.Key.font: UIFont(name: Constants.helveticaLight, size: 20)!, NSAttributedString.Key.foregroundColor: UIColor.black ]
        let textString = NSAttributedString(string: text, attributes: myAttribute)
        let attachment = NSTextAttachment()
        let image = UIImage(systemName: image)
        attachment.image = image
        fullString.append(NSAttributedString(attachment: attachment))
        fullString.append(textString)
        
        
        
        return fullString
    }
    
    private func configureWeeklyLabel() {
        weeklyLabel.text = Constants.weekForecast
        weeklyLabel.font = UIFont(name: Constants.helveticaLight, size: 30)
        weeklyLabel.textColor = .black
        weeklyLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureWeekTableView() {
        weekTableView.layer.cornerRadius = 16
        weekTableView.isScrollEnabled = true
        weekTableView.translatesAutoresizingMaskIntoConstraints = false
        weekTableView.register(OneDayWeatherCell.self, forCellReuseIdentifier: "\(OneDayWeatherCell.self)")
        weekTableView.dataSource = self
        weekTableView.delegate = self
        weekTableView.rowHeight = UITableView.automaticDimension
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            placeLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            placeLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            
            weatherTodayView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            weatherTodayView.topAnchor.constraint(equalTo: placeLabel.bottomAnchor, constant: 30),
            weatherTodayView.heightAnchor.constraint(equalToConstant: 240),
            weatherTodayView.widthAnchor.constraint(equalToConstant: 350),
            
            weeklyLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            weeklyLabel.topAnchor.constraint(equalTo: weatherTodayView.weatherOptionsStack.bottomAnchor, constant: 40),
            
            weekTableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            weekTableView.topAnchor.constraint(equalTo: weeklyLabel.bottomAnchor, constant: 20),
            weekTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            weekTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            weekTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
}


extension WeatherViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(OneDayWeatherCell.self)", for: indexPath) as? OneDayWeatherCell else {
            return UITableViewCell()
        }
        
        cell.getWeatherData(forecast?.list[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}


extension WeatherViewController {
    func getLocationName(from coordinate: CLLocationCoordinate2D, completion: @escaping (String?) -> Void) {
        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        
        geocoder.reverseGeocodeLocation(location) { placemarks, error in
            guard error == nil else {
                print("Reverse geocoding failed with error: \(error!.localizedDescription)")
                completion(nil)
                return
            }
            
            guard let placemark = placemarks?.first else {
                print("No placemarks found")
                completion(nil)
                return
            }
            
            let locationName = placemark.locality ?? placemark.name
            completion(locationName)
        }
    }
}
