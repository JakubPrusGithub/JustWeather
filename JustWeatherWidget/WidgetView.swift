//
//  WidgetView.swift
//  JustWeather
//
//  Created by Jakub Prus on 17/05/2023.
//

import SwiftUI
import WidgetKit

struct JustWeatherWidgetEntryView: View {
    var entry: Provider.Entry

    var body: some View {
        Text(entry.date, style: .time)
    }
}

struct JustWeatherWidget_Previews: PreviewProvider {
    static var previews: some View {
        JustWeatherWidgetEntryView(entry: WidgetWeatherModel(date: Date(), weather: .sampleWeather))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
