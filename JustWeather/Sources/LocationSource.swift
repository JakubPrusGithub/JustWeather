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
            authorizationStatus = .authorizedWhenInUse
            locationManager.requestLocation()
        case .restricted, .denied:  // Location services currently unavailable.
            authorizationStatus = .restricted
        case .notDetermined:        // Authorization not determined yet.
            authorizationStatus = .notDetermined
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                manager.requestWhenInUseAuthorization()
            }
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
