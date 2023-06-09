//
//  WidgetViewMedium.swift
//  JustWeatherWidgetExtension
//
//  Created by Jakub Prus on 18/05/2023.
//

import SwiftUI
import WidgetKit

struct WidgetViewMedium: View {
    var entry: Provider.Entry
    @State var cityName = "CITY"
    @State var xOffsetCircle: CGFloat = 75
    @State var yOffsetCircle: CGFloat = 0
    
    var body: some View {
        ZStack {
            
            // MARK: Circles background
            ZStack {
                Circle()
                    .foregroundColor(.purple)
                    .blur(radius: 30)
                    .offset(x: -xOffsetCircle, y: -yOffsetCircle*2)
                Circle()
                    .foregroundColor(.red)
                    .blur(radius: 30)
                    .offset(x: 0, y: -yOffsetCircle)
                Circle()
                    .foregroundColor(.orange)
                    .blur(radius: 30)
                    .offset(x: xOffsetCircle, y: 0)
                Circle()
                    .foregroundColor(.white)
                    .blur(radius: 30)
                    .offset(x: xOffsetCircle*2, y: yOffsetCircle)
                Circle()
                    .foregroundColor(Color(red: 0, green: 0, blue: 0.8))
                    .blur(radius: 15)
                    .offset(x: xOffsetCircle*2, y: 10)
                    .frame(width: 100)
            } // ZStack
            
            // MARK: Weather text info
            VStack {
                HStack {
                    Text(cityName)
                        .font(.custom("GothicA1-Medium", size: 35))
                    Text("- [" + (entry.weather.currWeather.first?.main ?? " - [WEATHER]") + "]")
                        .font(.custom("GothicA1-Medium", size: 30))
                }
                VStack {
                    Text("\(Int(entry.weather.temperature.temp))°C")
                        .font(.custom("GothicA1-Medium", size: 66))
                    VStack {
                        Text("Last updated: ")
                        Text(entry.date.formatted())
                    }
                    .font(.caption)
                }
            } // VStack
        } // ZStack
        .onAppear {
            // Fetch city name from User Defaults
            let sharedUserDefaults = UserDefaults(suiteName: SharedUserDefaults.suiteName)
            cityName = sharedUserDefaults?.string(forKey: SharedUserDefaults.cityName) ?? "CITY"
        }
    }
}

struct WidgetViewMedium_Previews: PreviewProvider {
    static var previews: some View {
        WidgetViewMedium(entry: WidgetWeatherModel(date: Date(), weather: .sampleWeather))
            .previewContext(WidgetPreviewContext(family: .systemMedium))
    }
}
