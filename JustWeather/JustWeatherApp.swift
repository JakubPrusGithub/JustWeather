//
//  JustWeatherApp.swift
//  JustWeather
//
//  Created by Jakub Prus on 17/04/2023.
//

import SwiftUI
import Swinject

@main
struct JustWeatherApp: App {
    
    let container: Container = {
        let container = Container()
        container.register(WeatherProviding.self) { _ in
            
            // Use MockWeatherProvider for mock data
            MockWeatherProvider()
            
            // Use WeatherProvider for real data from api call
            // WeatherProvider()
        }
        .inObjectScope(.container)
        return container
    }()
    
    var body: some Scene {
        WindowGroup {
            MainView(weatherSource: container.resolve(WeatherProviding.self) ?? MockWeatherProvider())
        }
    }
}
