//
//  MainView_ViewController.swift
//  JustWeather
//
//  Created by Jakub Prus on 23/04/2023.
//

import Foundation
import Combine
import CoreLocation

class MainViewVC: ObservableObject {
    
    @Published var currentWeather: WeatherModel?
    @Published var currentLocation = LocationSource()
    @Published var countryName = ""
    @Published var countryCode = ""
    @Published var cityName = ""
    
    var cancellables = Set<AnyCancellable>()
    let weatherSource: WeatherProviding
    let locale = Locale(identifier: "en_US")
    
    init(weatherSource: WeatherProviding) {
        self.weatherSource = weatherSource
        getLocation()
    }
    
    func fetchWeather() {
        weatherSource.getWeather(url: generateURL())
            .receive(on: DispatchQueue.main)
            .sink { _ in
                
            } receiveValue: { [weak self] weather in
                self?.currentWeather = weather
            }
            .store(in: &cancellables)
    }
    
    func getCurrentDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "ddMMM''yy"
        formatter.locale = locale
        return formatter.string(from: Date()).uppercased()
    }
    
    func generateURL() -> URL {
        let urlString = "https://api.openweathermap.org/data/2.5/weather?lat=53.428543&lon=14.552812&appid=4d4709bf04a5b6896ab2b456a4012c1d&units=metric"
        guard let url = URL(string: urlString) else { fatalError("Incorrect API link") }
        return url
    }
    
    func getLocation() {
        
        currentLocation.$currLocalization.receive(on: DispatchQueue.main).sink { _ in
            guard let currLocalization = self.currentLocation.currLocalization else {
                self.countryName = "VOID"
                self.cityName = "VOID"
                self.countryCode = "VOID"
                return
            }
            let location = CLLocation(latitude: currLocalization.coordinate.latitude, longitude: currLocalization.coordinate.longitude)
            CLGeocoder().reverseGeocodeLocation(location, preferredLocale: self.locale) { placemarks, _ in
                if let placemark = placemarks?.first {
                    self.cityName = placemark.locality?.uppercased() ?? "VOID"
                    self.countryName = placemark.country?.uppercased() ?? "VOID"
                    self.countryCode = placemark.isoCountryCode ?? "VOID"
                }
            }
            
        }
        .store(in: &cancellables)
    }
}
