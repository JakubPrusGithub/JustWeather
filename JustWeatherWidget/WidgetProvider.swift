//
//  WidgetProvider.swift
//  JustWeather
//
//  Created by Jakub Prus on 17/05/2023.
//

import WidgetKit

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> WidgetWeatherModel {
        WidgetWeatherModel(date: Date(), weather: .sampleWeather)
    }

    func getSnapshot(in context: Context, completion: @escaping (WidgetWeatherModel) -> Void) {
        let entry = WidgetWeatherModel(date: Date(), weather: .sampleWeather)
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<WidgetWeatherModel>) -> Void) {
        var entries: [WidgetWeatherModel] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = WidgetWeatherModel(date: entryDate, weather: .sampleWeather)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}
