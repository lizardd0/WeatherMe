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
    
    
    @objc func getCurrentLocation() {
        welcomeLabel.isHidden = true
        shareLocationButton.isHidden = true
        activityIndicator.startAnimating()
        locationManager.requestLocation { [weak self] coordinate in
            guard let coordinate = coordinate else {
                self?.activityIndicator.stopAnimating()
                print("Failed to get user location")
                return
            }
            
            self?.locationManager.location = coordinate
            self?.activityIndicator.stopAnimating()
            let weatherViewController = WeatherViewController()
            self?.present(weatherViewController, animated: true)
        }
    }

    
    private func configureActivityIndicator() {
        activityIndicator.color = .gray
        activityIndicator.hidesWhenStopped = true
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
