//
//  WidgetView.swift
//  JustWeather
//
//  Created by Jakub Prus on 17/05/2023.
//

import SwiftUI
import WidgetKit

struct JustWeatherWidgetEntryView: View {
    @Environment(\.widgetFamily) var widgetFamily
    var entry: Provider.Entry
    
    var body: some View {
        
        // Create view based on widget's size
        if widgetFamily == .systemSmall {
            WidgetViewSmall(entry: entry)
        } else if widgetFamily == .systemMedium {
            WidgetViewMedium(entry: entry)
        }
    }
}

struct JustWeatherWidget_Previews: PreviewProvider {
    static var previews: some View {
        JustWeatherWidgetEntryView(entry: WidgetWeatherModel(date: Date(), weather: .sampleWeather))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
