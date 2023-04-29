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
                showWeather
            } else {
                SplashScreenView(finishedSplashScreen: $isShowingWeather)
            }
        }
        .onChange(of: weather.isWeatherFetched) { newValue in
            print(newValue)
        }
        .onAppear {
            print(weather.isWeatherFetched)
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(weatherSource: MockWeatherProvider())
    }
}

extension MainView {
    var showWeather: some View {
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
            Group {
                Circle()
                    .foregroundColor(.purple)
                    .blur(radius: 30)
                    .offset(x: -20, y: -100)
                Circle()
                    .foregroundColor(.red)
                    .blur(radius: 30)
                    .offset(x: 0, y: -50)
                Circle()
                    .foregroundColor(.orange)
                    .blur(radius: 30)
                    .offset(x: 20, y: 0)
                Circle()
                    .foregroundColor(.white)
                    .blur(radius: 30)
                    .offset(x: 40, y: 50)
                Circle()
                    .foregroundColor(Color(red: 0, green: 0, blue: 0.8))
                    .blur(radius: 20)
                    .offset(x: 160, y: 350)
                    .frame(width: 125)
            }
            
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
        .onAppear {
            weather.fetchWeather()
            weather.getLocation()
        }
    }
}
