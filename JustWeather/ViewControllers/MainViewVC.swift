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
    let source = MockWeatherProvider()
    
    func fetchWeather() {
        source.getWeather()
            .receive(on: DispatchQueue.main)
            .sink { _ in
                
            } receiveValue: { [weak self] weather in
                self?.currentWeather = weather
            }
            .store(in: &cancellables)
    }
}
