//
//  OneDayWeatherCell.swift
//  weatherVk
//
//  Created by Елизавета Шерман on 24.03.2024.
//

import UIKit

final class OneDayWeatherCell: UITableViewCell {
    private enum Constants {
        static let helveticaLight = "HelveticaNeue-Light"
    }
    
    private var weatherIcon = UIImageView()
    private var weatherLabel = UILabel()
    private var minTemperature = UILabel()
    private var maxTemperature = UILabel()
    private var weatherStack = UIStackView()
    private var temperatureStack = UIStackView()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureWeatherStack()
        contentView.addSubview(weatherStack)
        
        configureTemperatureStack()
        contentView.addSubview(temperatureStack)
        
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func getWeatherData(_ data: OndeDayResponse?) {
        guard let weather = data else {
            weatherIcon.image = UIImage(systemName: "sun.max.fill")
            weatherLabel.text = "--"
            minTemperature.text = "--°"
            maxTemperature.text = "--°"
            
            return
        }
        
        switch data?.weather[0].main {
        case WeatherTypes.Rain.rawValue:
            weatherIcon.image = UIImage(systemName: "cloud.rain.fill")
        case WeatherTypes.Clouds.rawValue:
            weatherIcon.image = UIImage(systemName: "cloud.fill")
        case WeatherTypes.Clear.rawValue:
            weatherIcon.image = UIImage(systemName: "sun.max.fill")
        case WeatherTypes.Thunderstorm.rawValue:
            weatherIcon.image = UIImage(systemName: "cloud.bolt.fill")
        case WeatherTypes.Drizzle.rawValue:
            weatherIcon.image = UIImage(systemName: "cloud.drizzle.fill")
        case WeatherTypes.Snow.rawValue:
            weatherIcon.image = UIImage(systemName: "snowflake")
        case WeatherTypes.Atmosphere.rawValue:
            weatherIcon.image = UIImage(systemName: "cloud.fog.fill")
        default:
            weatherIcon.image = UIImage(systemName: "rainbow")
        }
        
        weatherLabel.text = data?.weather[0].description
        if let min = data?.main.temp_min {
            minTemperature.text = "\(min)°"
        }
        if let max = data?.main.temp_max {
            maxTemperature.text = "\(max)°"
        }
    }
    
    private func configureWeatherIcon() {
        weatherIcon.contentMode = .scaleAspectFill
        weatherIcon.tintColor = .black
        weatherIcon.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureWeatherLabel() {
        weatherLabel.font = UIFont(name: Constants.helveticaLight, size: 20)
        weatherLabel.textColor = .black
        weatherLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureWeatherStack() {
        configureWeatherIcon()
        configureWeatherLabel()
        
        weatherStack.addArrangedSubview(weatherIcon)
        weatherStack.addArrangedSubview(weatherLabel)
        
        weatherStack.axis = .horizontal
        weatherStack.spacing = 10
        weatherStack.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureMinMaxLabel() {
        minTemperature.font = UIFont(name: Constants.helveticaLight, size: 14)
        minTemperature.textColor = .black
        minTemperature.translatesAutoresizingMaskIntoConstraints = false
        
        maxTemperature.font = UIFont(name: Constants.helveticaLight, size: 18)
        maxTemperature.textColor = .black
        maxTemperature.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureTemperatureStack() {
        configureMinMaxLabel()
        
        temperatureStack.addArrangedSubview(maxTemperature)
        temperatureStack.addArrangedSubview(minTemperature)
        
        temperatureStack.axis = .vertical
        temperatureStack.spacing = 4
        temperatureStack.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([            
            weatherStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            weatherStack.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),

            temperatureStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            temperatureStack.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
}
