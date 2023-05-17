//
//  WidgetModel.swift
//  JustWeather
//
//  Created by Jakub Prus on 17/05/2023.
//

import WidgetKit

struct WidgetWeatherModel: TimelineEntry {
    let date: Date
    let weather: WeatherModel
}
