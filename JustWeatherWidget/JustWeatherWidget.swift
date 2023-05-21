//
//  JustWeatherWidget.swift
//  JustWeatherWidget
//
//  Created by Jakub Prus on 15/05/2023.
//

import SwiftUI
import WidgetKit

struct JustWeatherWidget: Widget {
    let kind: String = "JustWeatherWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            JustWeatherWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("JustWeather's Widget")
        .description("This widget simply shows current weather and temperature based on your location")
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}
