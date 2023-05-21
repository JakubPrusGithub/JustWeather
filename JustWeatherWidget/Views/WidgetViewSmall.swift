//
//  WidgetViewSmall.swift
//  JustWeatherWidgetExtension
//
//  Created by Jakub Prus on 18/05/2023.
//

import SwiftUI
import WidgetKit

struct WidgetViewSmall: View {
    var entry: Provider.Entry

    var body: some View {
        ZStack {
            Circle()
                .foregroundColor(Color(red: 0, green: 0, blue: 0.8))
                .blur(radius: 40)
                .frame(width: 115)
            
            // MARK: Weather text info
            VStack {
                Text("[TEMPERATURE]")
                    .font(.custom("GothicA1-Medium", size: 15))
                Text("\(Int(entry.weather.temperature.temp))°")
                    .font(.custom("GothicA1-Medium", size: 66))
                    .offset(x: 10)
                VStack {
                    Text("Last updated: ")
                    Text(entry.date.formatted())
                }
                .font(.caption)
            }
            .padding(.top)
        } // ZStack
    }
}

struct WidgetViewSmall_Previews: PreviewProvider {
    static var previews: some View {
        WidgetViewSmall(entry: WidgetWeatherModel(date: Date(), weather: .sampleWeather))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
