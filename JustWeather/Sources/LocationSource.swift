//
//  LocationSource.swift
//  JustWeather
//
//  Created by Jakub Prus on 28/04/2023.
//

import Foundation
import CoreLocation

class LocationSource : NSObject, CLLocationManagerDelegate, ObservableObject {
    
    var locationManager = CLLocationManager()
    @Published var authorizationStatus: CLAuthorizationStatus?
    @Published var currLocalization: CLLocation?
    
    override init() {
        super.init()
        locationManager.delegate = self
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedWhenInUse:  // Location services are available.
            // Insert code here of what should happen when Location services are authorized
            authorizationStatus = .authorizedWhenInUse
            locationManager.requestLocation()
            break
            
        case .restricted, .denied:  // Location services currently unavailable.
            // Insert code here of what should happen when Location services are NOT authorized
            authorizationStatus = .restricted
            break
            
        case .notDetermined:        // Authorization not determined yet.
            authorizationStatus = .notDetermined
            manager.requestWhenInUseAuthorization()
            break
            
        default:
            break
        }
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.currLocalization = locations.first
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error: \(error.localizedDescription)")
    }
}
