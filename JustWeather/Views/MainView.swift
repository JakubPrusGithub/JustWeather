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
        .alert("Sorry, there is no internet connection.", isPresented: $networkMonitor.showError) {
            Button("OK") {}
        }
        .alert("Please allow location service.", isPresented: $weather.isLocationDisabled) {
            Button("OK") {
                weather.checkLocationPermission()
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(weatherSource: MockWeatherProvider())
    }
}
