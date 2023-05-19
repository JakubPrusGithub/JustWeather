//
//  WidgetViewMedium.swift
//  JustWeatherWidgetExtension
//
//  Created by Jakub Prus on 18/05/2023.
//

import SwiftUI
import WidgetKit
import CoreLocation

struct WidgetViewMedium: View {
    var entry: Provider.Entry
    @State var location = CLLocation()
    @State var cityName = "CITY"
    @State var xOffsetCircle: CGFloat = 75
    @State var yOffsetCircle: CGFloat = 0
    
    var body: some View {
        ZStack {
            ZStack {
                Circle()
                    .foregroundColor(.purple)
                    .blur(radius: 30)
                    .offset(x: -xOffsetCircle, y: -yOffsetCircle*2)
                Circle()
                    .foregroundColor(.red)
                    .blur(radius: 30)
                    .offset(x: 0, y: -yOffsetCircle)
                Circle()
                    .foregroundColor(.orange)
                    .blur(radius: 30)
                    .offset(x: xOffsetCircle, y: 0)
                Circle()
                    .foregroundColor(.white)
                    .blur(radius: 30)
                    .offset(x: xOffsetCircle*2, y: yOffsetCircle)
                Circle()
                    .foregroundColor(Color(red: 0, green: 0, blue: 0.8))
                    .blur(radius: 15)
                    .offset(x: xOffsetCircle*2, y: 10)
                    .frame(width: 125)
            }
            VStack {
                Text(cityName)
                    .font(.custom("GothicA1-Medium", size: 35))
                VStack {
                    Text("\(Int(entry.weather.temperature.temp))°C")
                        .font(.custom("GothicA1-Medium", size: 66))
                    VStack {
                        Text("Last updated: ")
                        Text(entry.date.formatted())
                    }
                    .font(.caption)
                }
            }
        }
        .onAppear {
            let sharedUserDefaults = UserDefaults(suiteName: SharedUserDefaults.suiteName)
            let latitude = sharedUserDefaults?.double(forKey: SharedUserDefaults.latitude) ?? 0.0
            let longitude = sharedUserDefaults?.double(forKey: SharedUserDefaults.longitude) ?? 0.0
            
            let location = CLLocation(latitude: CLLocationDegrees(latitude), longitude: CLLocationDegrees(longitude))
            let locale = Locale(identifier: "en_US")
            self.cityName = location.description
            
            CLGeocoder().reverseGeocodeLocation(location) { placemarks, _ in
                
                if let placemark = placemarks?.first {
                    
                    self.cityName = placemark.locality?.uppercased() ?? "UNKNOWN"
                }
            }
        }
    }
}

struct WidgetViewMedium_Previews: PreviewProvider {
    static var previews: some View {
        WidgetViewMedium(entry: WidgetWeatherModel(date: Date(), weather: .sampleWeather))
            .previewContext(WidgetPreviewContext(family: .systemMedium))
    }
}
