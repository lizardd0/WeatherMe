//
//  WelcomeView.swift
//  weatherVk
//
//  Created by Lychees Saiyan on 3/21/24.
//

import UIKit
import CoreLocationUI

final class WelcomeViewController: UIViewController {
    private enum Constants {
        static let welcomeLabel = "Hello! It is WeatherMe"
        static let helveticaBold = "HelveticaNeue-Bold"
        static let welcomeLabelSize: CGFloat = 36
        static let cornerRadiusShareButton: CGFloat = 25.0
    }
    
    private let locationManager = LocationManager()
    private let welcomeLabel = UILabel()
    private let shareLocationButton = CLLocationButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        configureWelcomeLabel()
        view.addSubview(welcomeLabel)
        
        configureLocationButton()
        view.addSubview(shareLocationButton)
        
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
        locationManager.requestLocation()
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            welcomeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            welcomeLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            shareLocationButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            shareLocationButton.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 50)
        ])
    }
}
