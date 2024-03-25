//
//  WelcomeView.swift
//  weatherVk
//
//  Created by Lychees Saiyan on 3/21/24.
//

import UIKit
import CoreLocationUI
import CoreLocation

final class WelcomeViewController: UIViewController {
    private enum Constants {
        static let welcomeLabel = "Hello! It is WeatherMe"
        static let helveticaBold = "HelveticaNeue-Bold"
        static let welcomeLabelSize: CGFloat = 36
        static let cornerRadiusShareButton: CGFloat = 25.0
    }
    
    private let locationManager = LocationManager.shared
    private let welcomeLabel = UILabel()
    private let shareLocationButton = CLLocationButton()
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        configureWelcomeLabel()
        view.addSubview(welcomeLabel)
        
        configureLocationButton()
        view.addSubview(shareLocationButton)
        
        configureActivityIndicator()
        view.addSubview(activityIndicator)
        
        configureConstraints()
    }
    
    
    private func configureWelcomeLabel() {
        welcomeLabel.text = Constants.welcomeLabel
        welcomeLabel.textColor = .black
        welcomeLabel.font = UIFont(name: Constants.helveticaBold, size: Constants.welcomeLabelSize)
        
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureLocationButton() {
        shareLocationButton.icon = .arrowFilled
        shareLocationButton.cornerRadius = Constants.cornerRadiusShareButton
        shareLocationButton.label = .shareCurrentLocation
        shareLocationButton.addTarget(self, action: #selector(getCurrentLocation), for: .touchUpInside)
        shareLocationButton.translatesAutoresizingMaskIntoConstraints = false
    }
    
//    @objc func getCurrentLocation() {
//        activityIndicator.startAnimating()
//        DispatchQueue.main.async {
//            self.locationManager.requestLocation()
//        }
//        welcomeLabel.isHidden = true
//        shareLocationButton.isHidden = true
//        if let latitude = locationManager.location?.latitude,
//           let longitude = locationManager.location?.longitude {
//            let weatherViewController = WeatherViewController()
//            self.present(weatherViewController, animated: true)
//        }
//    }
    
    @objc func getCurrentLocation() {
//        activityIndicator.startAnimating() // Старт индикатора загрузки
        
        locationManager.requestLocation()
        
        if let location = locationManager.location {
            let weatherViewController = WeatherViewController()
            self.present(weatherViewController, animated: true)
            
            // Остановка и скрытие индикатора загрузки
            activityIndicator.stopAnimating()
        }
        
    }
    
    
    
    private func configureActivityIndicator() {
        activityIndicator.color = .gray
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            welcomeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            welcomeLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            shareLocationButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            shareLocationButton.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 50),
            
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}

