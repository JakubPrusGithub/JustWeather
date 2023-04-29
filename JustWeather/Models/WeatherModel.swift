//
//  WeatherModel.swift
//  JustWeather
//
//  Created by Jakub Prus on 20/04/2023.
//

import Foundation

struct WeatherModel: Decodable, Identifiable, Equatable {
    
    static func == (lhs: WeatherModel, rhs: WeatherModel) -> Bool {
        lhs.id == rhs.id
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case place = "name"
        case currentWeather = "weather"
        case temperature = "main"
    }
    
    struct CurrentWeather: Decodable { // Current weather
        let main: String
        let description: String
    }
    
    struct Temperature: Decodable { // Temperature
        let temp: Double
        let temp_min: Double
        let temp_max: Double
    }
    
    // MARK: init for download data
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: CodingKeys.id)
        place = try container.decode(String.self, forKey: CodingKeys.place)
        currWeather = try container.decode([CurrentWeather].self, forKey: CodingKeys.currentWeather)
        temperature = try container.decode(Temperature.self, forKey: CodingKeys.temperature)
    }
    
    // MARK: init for mock data
    init(id: Int, place: String, currWeather: [CurrentWeather], temperature: Temperature) {
        self.id = id
        self.place = place
        self.currWeather = currWeather
        self.temperature = temperature
    }
    
    let id: Int
    let place: String
    
    let currWeather: [CurrentWeather]
    let temperature: Temperature
    
    static let sampleWeather = WeatherModel(id: 1,
                                            place: "Warsaw",
                                            currWeather: [CurrentWeather(main: "Clouds", description: "scattered clouds")],
                                            temperature: Temperature(temp: 20.0, temp_min: 10.0, temp_max: 30.0))
}
/*
 {
 "coord": { "lon":14.5528, "lat":53.4285 },
 "weather":[{"id":802, "main":"Clouds", "description":"scattered clouds", "icon":"03d"}],
 "base":"stations",
 "main":{"temp":18.3, "feels_like":17.41, "temp_min":17.66, "temp_max":19.12, "pressure":1020, "humidity":47},
 "visibility":10000,
 "wind":{"speed":5.81, "deg":80},
 "clouds":{"all":43},
 "dt":1682000796,
 "sys":{"type":2, "id":2034200, "country":"PL", "sunrise":1681962695, "sunset":1682014176},
 "timezone":7200,
 "id":3083829,
 "name":"Szczecin",
 "cod":200
 }
 */
