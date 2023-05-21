//
//  WidgetProvider.swift
//  JustWeather
//
//  Created by Jakub Prus on 17/05/2023.
//

import WidgetKit
import Combine

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
        var weather: WeatherModel = WeatherModel.sampleWeather
        let currentDate = Date()
        
        // Fetch weather for widget
        fetchData { result in
            switch result {
            case .success(let decodedStruct):
                weather = decodedStruct
                
                let entry = WidgetWeatherModel(date: currentDate, weather: weather)
                entries.append(entry)
                
                let timeline = Timeline(entries: entries, policy: .after(currentDate.addingTimeInterval(3600)))
                completion(timeline)
                
            case .failure(let error):
                print("Error with downloading weather for widget: \(error.localizedDescription)")
            }
        }
    }
    
    // Create URL from user's location
    func generateURL(lat: Double, lon: Double) -> URL {
        let urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&appid=4d4709bf04a5b6896ab2b456a4012c1d&units=metric"
        guard let url = URL(string: urlString) else { fatalError("Incorrect API link") }
        return url
    }
    
    // Download weather from internet
    func fetchData(completion: @escaping (Result<WeatherModel, Error>) -> Void) {
        let sharedUserDefaults = UserDefaults(suiteName: SharedUserDefaults.suiteName)
        let latitude = sharedUserDefaults?.double(forKey: SharedUserDefaults.latitude) ?? 0.0
        let longitude = sharedUserDefaults?.double(forKey: SharedUserDefaults.longitude) ?? 0.0
        let url = generateURL(lat: latitude, lon: longitude)
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            // Error handling
            if let error = error {
                completion(.failure(error))
                return
            }
            
            // HTTP response check
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(NSError(domain: "Invalid server response", code: 0, userInfo: nil)))
                return
            }
            
            // Data check
            guard let data = data else {
                completion(.failure(NSError(domain: "Invalid data", code: 0, userInfo: nil)))
                return
            }
            
            // Decode
            do {
                let decoder = JSONDecoder()
                let decodedStruct = try decoder.decode(WeatherModel.self, from: data)
                completion(.success(decodedStruct))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
