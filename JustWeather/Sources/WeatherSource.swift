//
//  WeatherSource.swift
//  JustWeather
//
//  Created by Jakub Prus on 20/04/2023.
//

import Foundation
import Combine

protocol WeatherProviding {
    func getWeather(url: URL) -> AnyPublisher<WeatherModel?, Error>
}

// Download weather from internet
class WeatherProvider: WeatherProviding {
    
    private var cancellables = Set<AnyCancellable>()
    
    func getWeather(url: URL) -> AnyPublisher<WeatherModel?, Error> {
        
        URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { res in
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
            .mapError({ $0 })
            .eraseToAnyPublisher()
    }
    
}

// Inject fake weather
class MockWeatherProvider: WeatherProviding {
    func getWeather(url: URL) -> AnyPublisher<WeatherModel?, Error> {
        let mockWeather = WeatherModel.sampleWeather
        return Just(mockWeather)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}
