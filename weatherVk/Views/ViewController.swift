//
//  ViewController.swift
//  weatherVk
//
//  Created by Lychees Saiyan on 3/21/24.
//

import UIKit

class ViewController: UIViewController {
    var locationManager = LocationManager()
    var coordinatesLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .secondarySystemBackground

        if let location = locationManager.location {
            coordinatesLabel.text = "Your coordinates are: \(location.latitude), \(location.longitude)"
        } else {
            coordinatesLabel.text = "Your coordinates are: (((("
        }
        coordinatesLabel.textColor = .black
        coordinatesLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(coordinatesLabel)
        
        NSLayoutConstraint.activate([
            coordinatesLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            coordinatesLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }


}

