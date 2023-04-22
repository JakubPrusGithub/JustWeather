//
//  MainView.swift
//  JustWeather
//
//  Created by Jakub Prus on 20/04/2023.
//

import SwiftUI

struct MainView: View {
    
    @StateObject var weather = WeatherProvider()
    
    var body: some View {
        ZStack{
            VStack{
                Spacer()
                HStack(alignment: .lastTextBaseline){
                    Text("CURRENT")
                    Spacer()
                    Text(Int(weather.currentWeather.temperature.temp.rounded()).description)
                        .font(.custom("GothicA1-Medium", size: 250))
                }
                .offset(x: 40, y: 40)
            }
            Circle()
                .foregroundColor(.purple)
                .blur(radius: 30)
                .offset(x: 0, y: -100)
            Circle()
                .foregroundColor(.red)
                .blur(radius: 30)
                .offset(x: 0, y: -50)
            Circle()
                .foregroundColor(.orange)
                .blur(radius: 30)
                .offset(x: 25, y: 0)
            Circle()
                .foregroundColor(.white)
                .blur(radius: 30)
                .offset(x: 50, y: 50)
            Circle()
                .foregroundColor(Color(red: 0, green: 0, blue: 0.8))
                .blur(radius: 20)
                .offset(x: 75, y: 400)
                .frame(width: 125)
                .onTapGesture {
//                    print(weather.currentWeather?.place ?? "none")
//                    print(weather.currentWeather?.id ?? "none")
//                    print(weather.currentWeather?.temperature.temp ?? "none")
//                    print(weather.currentWeather?.temperature.temp_max ?? "none")
//                    print(weather.currentWeather?.temperature.temp_min ?? "none")
                    print(String(describing: weather.currentWeather))
                }
            VStack{
                HStack{
                    Text("WEATHER FORECAST")
                    Spacer()
                    Text(weather.currentWeather.currWeather.first?.main ?? "None")
                }
                .padding(.top, 30)
                .padding(.horizontal)
                Text("21APR'23\n\(weather.currentWeather.place.uppercased()) PL\nPOLAND <\n> DAILY\nWEATHER")
                    .font(.custom("GothicA1-Medium", size: 55))
                    .padding(.top, 30)
                Divider()
                VStack{
                    Text("[TEMPERATURE]")
                    HStack{
                        Text("MINIMAL")
                        Spacer()
                        Text(weather.currentWeather.temperature.temp_min.rounded().description + "°C")
                    }
                    .padding(.vertical)
                    HStack{
                        Text("MAXIMAL")
                        Spacer()
                        Text(weather.currentWeather.temperature.temp_max.rounded().description + "°C")
                    }
                }
                .padding()
                Spacer()
            }
            .font(.custom("GothicA1-Medium", size: 20))
        }
        .onAppear{
            weather.getWeather()
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
