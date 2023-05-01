//
//  MainView.swift
//  JustWeather
//
//  Created by Jakub Prus on 20/04/2023.
//

import SwiftUI

struct MainView: View {
    
    @StateObject var networkMonitor = NetworkMonitor()
    @StateObject var weather: WeatherViewVC
    @State var finishedSplashScreen = false
    
    init(weatherSource: WeatherProviding) {
        _weather = StateObject(wrappedValue: WeatherViewVC(weatherSource: weatherSource))
    }
    
    var body: some View {
        Group {
            if finishedSplashScreen, weather.isWeatherFetched {
                WeatherView(weather: weather)
            } else {
                SplashScreenView(finishedSplashScreen: $finishedSplashScreen)
            }
        }
        .alert("There is no internet connection.", isPresented: $networkMonitor.showError) {
            Button("OK") {}
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(weatherSource: MockWeatherProvider())
    }
}
