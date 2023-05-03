//
//  MainView_ViewController.swift
//  JustWeather
//
//  Created by Jakub Prus on 23/04/2023.
//

import Foundation
import Combine
import CoreLocation
import UIKit

class WeatherViewVC: ObservableObject {
    
    @Published var currentWeather: WeatherModel?
    @Published var currentLocation = LocationSource()
    @Published var countryName = ""
    @Published var countryCode = ""
    @Published var cityName = ""
    @Published var isWeatherFetched = false
    @Published var isLocationDisabled = false
    
    var cancellables = Set<AnyCancellable>()
    let weatherSource: WeatherProviding
    let locale = Locale(identifier: "en_US")
    
    init(weatherSource: WeatherProviding) {
        self.weatherSource = weatherSource
        getLocation()
        locationPermission()
    }
    
    // Fetch weather from internet/mock data
    func fetchWeather(lat: Double, lon: Double) {
        
        let url = generateURL(lat: lat, lon: lon)
        
        weatherSource.getWeather(url: url)
            .receive(on: DispatchQueue.main)
            .sink { _ in
                
            } receiveValue: { [weak self] weather in
                self?.currentWeather = weather
                self?.isWeatherFetched = true
            }
            .store(in: &cancellables)
    }
    
    // Get present date in format e.g: "01JAN'23"  (1st Januray 2023)
    func getCurrentDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "ddMMM''yy"
        formatter.locale = locale
        return formatter.string(from: Date()).uppercased()
    }
    
    // Create url from user location
    private func generateURL(lat: Double, lon: Double) -> URL {
        let urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&appid=4d4709bf04a5b6896ab2b456a4012c1d&units=metric"
        guard let url = URL(string: urlString) else { fatalError("Incorrect API link") }
        return url
    }
    
    // Check if the user has given permission to location
    func checkLocationPermission() {
        self.currentLocation.locationManagerDidChangeAuthorization(self.currentLocation.locationManager)
        if let url = URL(string: UIApplication.openSettingsURLString) {
            UIApplication.shared.open(url)
        }
    }
    
    // Check current permission to location
    private func locationPermission() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.currentLocation.$authorizationStatus.receive(on: DispatchQueue.main).sink { [weak self] status in
                switch status {
                case .authorizedAlways:
                    self?.isLocationDisabled = false
                case .authorizedWhenInUse:
                    self?.isLocationDisabled = false
                case .denied:
                    self?.isLocationDisabled = true
                case .restricted:
                    self?.isLocationDisabled = true
                default:
                    self?.isLocationDisabled = true
                }
            }
            .store(in: &self.cancellables)
        }
    }
    
    // Fetch current location
    private func getLocation() {
        currentLocation.$currLocalization.receive(on: DispatchQueue.main).sink { _ in
            guard let currLocalization = self.currentLocation.currLocalization else {
                self.countryName = "CITY"
                self.cityName = "COUNTRY"
                self.countryCode = "CODE"
                return
            }
            let location = CLLocation(latitude: currLocalization.coordinate.latitude, longitude: currLocalization.coordinate.longitude)
            CLGeocoder().reverseGeocodeLocation(location, preferredLocale: self.locale) { placemarks, _ in
                if let placemark = placemarks?.first {
                    self.cityName = placemark.locality?.uppercased() ?? "CITY"
                    self.countryName = placemark.country?.uppercased() ?? "COUNTRY"
                    self.countryCode = placemark.isoCountryCode ?? "CODE"
                    self.fetchWeather(lat: currLocalization.coordinate.latitude, lon: currLocalization.coordinate.longitude)
                }
            }
            
        }
        .store(in: &cancellables)
    }
}
