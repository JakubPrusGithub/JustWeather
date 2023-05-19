//
//  WidgetProvider.swift
//  JustWeather
//
//  Created by Jakub Prus on 17/05/2023.
//

import WidgetKit
import Combine
import CoreLocation

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> WidgetWeatherModel {
        WidgetWeatherModel(date: Date(), weather: .sampleWeather)
    }

    func getSnapshot(in context: Context, completion: @escaping (WidgetWeatherModel) -> Void) {
        let entry = WidgetWeatherModel(date: Date(), weather: .sampleWeather)
        completion(entry)
    }
    
    @MainActor
    func getTimeline(in context: Context, completion: @escaping (Timeline<WidgetWeatherModel>) -> Void) {
        var entries: [WidgetWeatherModel] = []
        var weather: WeatherModel = WeatherModel.sampleWeather
        let weatherProvider = WeatherProvider()
        let currentDate = Date()
        var cancellables = Set<AnyCancellable>()
        if let latitude = UserDefaults.standard.object(forKey: "user_location_latitude") as? Double,
            let longitude = UserDefaults.standard.object(forKey: "user_location_longitude") as? Double {
            weatherProvider.getWeather(url: generateURL(lat: latitude, lon: longitude))
                .sink { completion in
                    switch completion {
                    case .finished:
                        print("Finished downloading weather for widget")
                    case .failure(let error):
                        print("Error downloading weather for widget: \(error.localizedDescription)")
                    }
                } receiveValue: { data in
                    guard let data = data else { return print("Error downloading weather for widget") }
                    weather = data
                }
                .store(in: &cancellables)
        }
        let entry = WidgetWeatherModel(date: .now, weather: weather)
        entries.append(entry)
        let timeline = Timeline(entries: entries, policy: .after(currentDate.addingTimeInterval(3600)))
        completion(timeline)
    }
    
    func generateURL(lat: Double, lon: Double) -> URL {
        let urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&appid=4d4709bf04a5b6896ab2b456a4012c1d&units=metric"
        guard let url = URL(string: urlString) else { fatalError("Incorrect API link") }
        return url
    }
}
