//
//  LocationManager.swift
//  weatherVk
//
//  Created by Lychees Saiyan on 3/21/24.
//

import Foundation
import CoreLocation


class LocationManager: NSObject, CLLocationManagerDelegate {
    static let shared = LocationManager()
    let manager = CLLocationManager()
    var location: CLLocationCoordinate2D?
    var completionHandler: ((CLLocationCoordinate2D?) -> Void)?
    
    private override init() {
        super.init()
        manager.delegate = self
    }
    
    func requestLocation(completion: @escaping (CLLocationCoordinate2D?) -> Void) {
        completionHandler = completion
        manager.requestWhenInUseAuthorization()
    }
    
    
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedWhenInUse, .authorizedAlways:
            manager.requestLocation()
        case .denied, .restricted:
            completionHandler?(nil)
        case .notDetermined:
            break
        @unknown default:
            fatalError("Unknown case")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            completionHandler?(nil)
            return
        }
        completionHandler?(location.coordinate)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to get location: \(error.localizedDescription)")
        completionHandler?(nil)
    }
}
