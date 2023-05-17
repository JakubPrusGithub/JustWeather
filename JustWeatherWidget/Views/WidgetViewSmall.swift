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
                .blur(radius: 20)
                .frame(width: 90)
            VStack {
                Text("\(Int(entry.weather.temperature.temp))°C")
                    .font(.custom("GothicA1-Medium", size: 66))
                VStack {
                    Text("Last updated: ")
                    Text(entry.date.formatted())
                }
                .font(.caption)
            }
            .padding(.top)
        }
    }
}

struct WidgetViewSmall_Previews: PreviewProvider {
    static var previews: some View {
        WidgetViewSmall(entry: WidgetWeatherModel(date: Date(), weather: .sampleWeather))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
