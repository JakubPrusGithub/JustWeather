//
//  MainView.swift
//  JustWeather
//
//  Created by Jakub Prus on 20/04/2023.
//

import SwiftUI

struct MainView: View {
    
    @StateObject var weather: MainViewVC
    @State var isShowingWeather = false
    
    init(weatherSource: WeatherProviding) {
        _weather = StateObject(wrappedValue: MainViewVC(weatherSource: weatherSource))
    }
    
    var body: some View {
        Group {
            if isShowingWeather, weather.isWeatherFetched {
                WeatherView(weather: weather)
            } else {
                SplashScreenView(finishedSplashScreen: $isShowingWeather)
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(weatherSource: MockWeatherProvider())
    }
}
