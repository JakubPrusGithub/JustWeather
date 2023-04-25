//
//  WeatherSource.swift
//  JustWeather
//
//  Created by Jakub Prus on 20/04/2023.
//

import Foundation
import Combine

protocol WeatherProviding {
    func getWeather() -> AnyPublisher<WeatherModel?, Error>
}

class WeatherProvider: WeatherProviding {
    
    private var cancellables = Set<AnyCancellable>()
    
    func getWeather() -> AnyPublisher<WeatherModel?, Error> {
        
        let urlString = "https://api.openweathermap.org/data/2.5/weather?lat=53.428543&lon=14.552812&appid=4d4709bf04a5b6896ab2b456a4012c1d&units=metric"
        guard let url = URL(string: urlString) else { fatalError("Incorrect API link") }
        
        return URLSession.shared.dataTaskPublisher(for: url)
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

class MockWeatherProvider: WeatherProviding {
    func getWeather() -> AnyPublisher<WeatherModel?, Error> {
        let mockWeather = WeatherModel.sampleWeather
        return Just(mockWeather)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}
