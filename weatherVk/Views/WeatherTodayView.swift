//
//  WeatherTodayView.swift
//  weatherVk
//
//  Created by Елизавета Шерман on 24.03.2024.
//

import UIKit

enum WeatherTypes: String {
    case Rain
    case Clouds
    case Clear
    case Thunderstorm
    case Drizzle
    case Snow
    case Atmosphere
}

final class WeatherTodayView: UIView {
    private enum Constants {
        static let todayLabel = "Today"
        static let helveticaLight = "HelveticaNeue-Light"
        static let helveticaMedium = "HelveticaNeue-Medium"
        static let humidityIcon = "humidity"
        static let precipitation = "drop.fill"
        static let windIcon = "wind"
    }
    
    var weather: ResponseBody?
    
    var todayLabel = UILabel()
    var temperatureLabel = UILabel()
    var temperaureIcon = UIImageView()
    var temperatureAndIconStack = UIStackView()
    var weatherLabel = UILabel()
    var dateLabel = UILabel()
    
    var humidityLabel = UILabel()
    var precipitationLabel = UILabel()
    var windLabel = UILabel()
    var weatherOptionsStack = UIStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        super.backgroundColor = .secondarySystemBackground
        super.layer.cornerRadius = 16
        translatesAutoresizingMaskIntoConstraints = false
        
        
        configureTodayLabel()
        addSubview(todayLabel)
        
        configureDateLabel()
        addSubview(dateLabel)
        
        configureTemperatureLabel()
        
        configureTemperatureIcon()
        
        configureTemperatureAndIconStack()
        addSubview(temperatureAndIconStack)
        
        configureWeatherLabel()
        addSubview(weatherLabel)
        
        configureWeatherOptionsStack()
        addSubview(weatherOptionsStack)
        
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func getWeatherData(_ data: ResponseBody?) {
        guard let weatherData = data else {
            temperatureLabel.text = "--°"
            weatherLabel.text = "--"
            humidityLabel.text = "0"
            precipitationLabel.text = "0"
            windLabel.text = "0"
            return
        }
        
        switch weatherData.weather[0].main {
        case WeatherTypes.Rain.rawValue:
            temperaureIcon.image = UIImage(systemName: "cloud.rain.fill")
        case WeatherTypes.Clouds.rawValue:
            temperaureIcon.image = UIImage(systemName: "cloud.fill")
        case WeatherTypes.Clear.rawValue:
            temperaureIcon.image = UIImage(systemName: "sun.max.fill")
        case WeatherTypes.Thunderstorm.rawValue:
            temperaureIcon.image = UIImage(systemName: "cloud.bolt.fill")
        case WeatherTypes.Drizzle.rawValue:
            temperaureIcon.image = UIImage(systemName: "cloud.drizzle.fill")
        case WeatherTypes.Snow.rawValue:
            temperaureIcon.image = UIImage(systemName: "snowflake")
        case WeatherTypes.Atmosphere.rawValue:
            temperaureIcon.image = UIImage(systemName: "cloud.fog.fill")
        default:
            temperaureIcon.image = UIImage(systemName: "rainbow")
        }
        temperatureLabel.text = "\(weatherData.main.temp)°"
        weatherLabel.text = weatherData.weather[0].description
        
        let humidity = attributedTextLabel(Constants.humidityIcon, "\(weatherData.main.humidity)%")
        humidityLabel.attributedText = humidity
        
        let precipitation = attributedTextLabel(Constants.precipitation, "\(weatherData.main.pressure) hPa")
        precipitationLabel.attributedText = precipitation
        
        let wind = attributedTextLabel(Constants.windIcon, "\(weatherData.wind.speed) km/h")
        windLabel.attributedText = wind
    }
    
    private func configureTodayLabel() {
        todayLabel.text = Constants.todayLabel
        todayLabel.font = UIFont(name: Constants.helveticaLight, size: 30)
        todayLabel.textColor = .black
        todayLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureDateLabel() {
        let getDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        dateLabel.text = dateFormatter.string(from: getDate)
        dateLabel.font = UIFont(name: Constants.helveticaLight, size: 20)
        dateLabel.textColor = .black
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func attributedTextLabel(_ image: String, _ text: String) -> NSMutableAttributedString {
        let fullString = NSMutableAttributedString()
        let myAttribute = [ NSAttributedString.Key.font: UIFont(name: Constants.helveticaLight, size: 15)!, NSAttributedString.Key.foregroundColor: UIColor.black ]
        let textString = NSAttributedString(string: text, attributes: myAttribute)
        let attachment = NSTextAttachment()
        let image = UIImage(systemName: image)
        attachment.image = image
        fullString.append(NSAttributedString(attachment: attachment))
        fullString.append(textString)
        
        
        
        return fullString
    }
    
    private func configureTemperatureLabel() {
        temperatureLabel.font = UIFont(name: Constants.helveticaMedium, size: 60)
        temperatureLabel.textColor = .black
        temperatureLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureTemperatureIcon() {
        temperaureIcon.contentMode = .scaleAspectFill
        temperaureIcon.tintColor = .black
        temperaureIcon.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureTemperatureAndIconStack() {
        temperatureAndIconStack.axis = .horizontal
        temperatureAndIconStack.addArrangedSubview(temperaureIcon)
        temperatureAndIconStack.addArrangedSubview(temperatureLabel)
        temperatureAndIconStack.setCustomSpacing(40, after: temperaureIcon)
        temperatureAndIconStack.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureWeatherLabel() {
        weatherLabel.font = UIFont(name: Constants.helveticaLight, size: 25)
        weatherLabel.textColor = .black
        weatherLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureWeatherOptionsStack() {
        humidityLabel.translatesAutoresizingMaskIntoConstraints = false
        
        precipitationLabel.translatesAutoresizingMaskIntoConstraints = false
        
        windLabel.translatesAutoresizingMaskIntoConstraints = false
        
        weatherOptionsStack.addArrangedSubview(humidityLabel)
        weatherOptionsStack.addArrangedSubview(precipitationLabel)
        weatherOptionsStack.addArrangedSubview(windLabel)
        
        weatherOptionsStack.axis = .horizontal
        weatherOptionsStack.translatesAutoresizingMaskIntoConstraints = false
        weatherOptionsStack.spacing = 20
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            todayLabel.centerXAnchor.constraint(equalTo: super.centerXAnchor),
            todayLabel.topAnchor.constraint(equalTo: super.topAnchor, constant: 10),
            
            dateLabel.centerXAnchor.constraint(equalTo: super.centerXAnchor),
            dateLabel.topAnchor.constraint(equalTo:todayLabel.bottomAnchor, constant: 10),
            
            temperatureAndIconStack.centerXAnchor.constraint(equalTo: super.centerXAnchor),
            temperatureAndIconStack.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 10),
            
            weatherLabel.centerXAnchor.constraint(equalTo: super.centerXAnchor),
            weatherLabel.topAnchor.constraint(equalTo: temperatureAndIconStack.bottomAnchor, constant: 10),
            
            weatherOptionsStack.centerXAnchor.constraint(equalTo: super.centerXAnchor),
            weatherOptionsStack.topAnchor.constraint(equalTo: weatherLabel.bottomAnchor, constant: 10)
        ])
    }
}

