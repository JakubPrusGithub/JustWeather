//
//  WeatherView.swift
//  JustWeather
//
//  Created by Jakub Prus on 30/04/2023.
//

import SwiftUI

struct WeatherView: View {
    
    @ObservedObject var weather: MainViewVC
    
    var body: some View {
        ZStack {
            
            // MARK: Current Temperature
            VStack {
                Spacer()
                HStack(alignment: .lastTextBaseline) {
                    Text("CURRENT")
                    Spacer()
                    Text(Int(weather.currentWeather?.temperature.temp.rounded() ?? 10).description)
                        .font(.custom("GothicA1-Medium", size: 250))
                }
                .offset(x: 40, y: 40)
            }
            
            // MARK: Circles
            WeatherBackgroundView()
            
            // MARK: Weather Forecast
            VStack {
                HStack {
                    Text("WEATHER FORECAST")
                    Spacer()
                    Text(weather.currentWeather?.currWeather.first?.main ?? "None")
                }
                .padding(.top, 30)
                .padding(.horizontal)
                VStack(alignment: .leading) {
                    Text(weather.getCurrentDate())
                    Text(weather.cityName + " - " + weather.countryCode + "")
                        .scaledToFit()
                        .minimumScaleFactor(0.5)
                    Text("\(weather.countryName) <")
                        .scaledToFit()
                        .minimumScaleFactor(0.5)
                    Text("> DAILY")
                    Text("WEATHER")
                }
                .font(.custom("GothicA1-Medium", size: 55))
                .padding(.top, 30)
                .padding(.horizontal)
                
                Divider()
                VStack {
                    Text("[TEMPERATURE]")
                        .onTapGesture {
                            weather.getLocation()
                        }
                    HStack {
                        Text("MINIMAL")
                        Spacer()
                        Text((weather.currentWeather?.temperature.temp_min.rounded().description ?? "None") + "°C")
                    }
                    .padding(.vertical)
                    HStack {
                        Text("MAXIMAL")
                        Spacer()
                        Text((weather.currentWeather?.temperature.temp_max.rounded().description ?? "None") + "°C")
                    }
                }
                .padding()
                Spacer()
            }
            .font(.custom("GothicA1-Medium", size: 20))
        }
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView(weather: MainViewVC(weatherSource: MockWeatherProvider()))
    }
}
