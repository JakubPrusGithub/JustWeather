//
//  WeatherSource.swift
//  JustWeather
//
//  Created by Jakub Prus on 20/04/2023.
//

import Foundation
import Combine

protocol WeatherProviding {
    func getWeather()
}

class WeatherProvider: WeatherProviding, ObservableObject {
    
    @Published var currentWeather: WeatherModel
    private var cancellables = Set<AnyCancellable>()
    
    init(){
        self.currentWeather = WeatherModel.sampleWeather
        self.getWeather()
    }
    
    func getWeather() {
        let urlString = "https://api.openweathermap.org/data/2.5/weather?lat=53.428543&lon=14.552812&appid=4d4709bf04a5b6896ab2b456a4012c1d&units=metric"
        guard let url = URL(string: urlString) else { return }
        
        URLSession
            .shared
            .dataTaskPublisher(for: url)
            .receive(on: DispatchQueue.main)
            .tryMap{ res in
                
                guard let response = res.response as? HTTPURLResponse,
                      response.statusCode >= 200 && response.statusCode <= 300 else {
                    throw URLError(.badServerResponse)
                }
                
                let decoder = JSONDecoder()
                guard let weather = try? decoder.decode(WeatherModel.self, from: res.data) else {
                    throw URLError(.cannotParseResponse)
                }
                
                return weather
            }
            .sink { res in
                
                switch res {
                case .failure:
                    print("error res")
                default: break
                }
                
            } receiveValue: { [weak self] weather in
                self?.currentWeather = weather
            }
            .store(in: &cancellables)
    }
    
}


