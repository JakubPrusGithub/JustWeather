//
//  MainView_ViewController.swift
//  JustWeather
//
//  Created by Jakub Prus on 23/04/2023.
//

import Foundation
import Combine

class MainViewVC: ObservableObject {
    
    @Published var currentWeather: WeatherModel?
    var cancellables = Set<AnyCancellable>()
    let weatherSource: WeatherProviding
    
    init(weatherSource: WeatherProviding) {
        self.weatherSource = weatherSource
    }
    
    func fetchWeather() {
        weatherSource.getWeather()
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
        return formatter.string(from: Date()).uppercased()
    }
}
