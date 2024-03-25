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
        
//        translatesAutoresizingMaskIntoConstraints = false
        
        configureWeatherStack()
        contentView.addSubview(weatherStack)
        
        configureTemperatureStack()
        contentView.addSubview(temperatureStack)
        
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //    func getWeatherData
    
    private func configureWeatherIcon() {
        weatherIcon.image = UIImage(systemName: "sun.max.fill")
        weatherIcon.contentMode = .scaleAspectFill
        weatherIcon.tintColor = .black
        weatherIcon.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureWeatherLabel() {
        weatherLabel.text = "Clear"
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
        minTemperature.text = "5°"
        minTemperature.font = UIFont(name: Constants.helveticaLight, size: 18)
        minTemperature.textColor = .black
        minTemperature.translatesAutoresizingMaskIntoConstraints = false
        
        maxTemperature.text = "0°"
        maxTemperature.font = UIFont(name: Constants.helveticaLight, size: 14)
        maxTemperature.textColor = .black
        maxTemperature.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureTemperatureStack() {
        configureMinMaxLabel()
        
        temperatureStack.addArrangedSubview(minTemperature)
        temperatureStack.addArrangedSubview(maxTemperature)
        
        temperatureStack.axis = .vertical
        temperatureStack.spacing = 4
        temperatureStack.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            contentView.heightAnchor.constraint(equalToConstant: 60),
            
            weatherStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            weatherStack.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),

            temperatureStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            temperatureStack.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
}
