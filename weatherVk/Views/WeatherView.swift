//
//  WeatherView.swift
//  weatherVk
//
//  Created by Елизавета Шерман on 24.03.2024.
//

import UIKit

final class WeatherViewController: UIViewController {
    private enum Constants {
        static let helveticaLight = "HelveticaNeue-Light"
        static let weekForecast = "Weekly Forecast"
    }
    
    var locationManager = LocationManager.shared
    var weatherManager = WeatherManager()
    var weather: ResponseBody?
    private var weatherTodayView = WeatherTodayView()
    
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    
    private var weeklyLabel = UILabel()
    
    private var weekTableView = UITableView(frame: .zero, style: .plain)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.color = .gray
        activityIndicator.startAnimating()
        view.addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        loadWeather()
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
                    activityIndicator.stopAnimating() // Останавливаем индикатор загрузки
                } else {
                    print("Weather data is nil")
                }
            } catch {
                print("Failed to fetch data!")
            }
        }
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
            weatherTodayView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            weatherTodayView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60),
            weatherTodayView.heightAnchor.constraint(equalToConstant: 210),
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
        
        
//        cell.textLabel?.text = "\(indexPath.row)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
