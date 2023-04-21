//
//  MainView.swift
//  JustWeather
//
//  Created by Jakub Prus on 20/04/2023.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        ZStack{
            VStack{
                Spacer()
                HStack(alignment: .lastTextBaseline){
                    Text("CURRENT")
                    Spacer()
                    Text("25")
                        .font(.custom("system", size: 250))
                }
                .offset(x: 40, y: 40)
            }
            Circle()
                .foregroundColor(.orange)
                .blur(radius: 30)
                .offset(x: 0, y: -100)
            Circle()
                .foregroundColor(.red)
                .blur(radius: 30)
                .offset(x: 0, y: -50)
            Circle()
                .foregroundColor(.purple)
                .blur(radius: 30)
                .offset(x: 25, y: 0)
            Circle()
                .foregroundColor(.white)
                .blur(radius: 30)
                .offset(x: 50, y: 50)
            Circle()
                .foregroundColor(Color(red: 0, green: 0, blue: 0.8))
                .blur(radius: 20)
                .offset(x: 75, y: 400)
                .frame(width: 125)
            VStack{
                HStack{
                    Text("WEATHER FORECAST")
                    Spacer()
                    Text("Clouds")
                }
                .padding(.top, 30)
                .padding(.horizontal)
                Text("20APR'23\nWARSAW PL \nPOLAND < > DAILY\nWEATHER")
                    .font(.custom("system", size: 50))
                    .padding(.top, 30)
                Divider()
                VStack{
                    Text("[TEMPERATURE]")
                    HStack{
                        Text("MINIMAL")
                        Spacer()
                        Text("10°C")
                    }
                    .padding(.bottom)
                    HStack{
                        Text("MAXIMAL")
                        Spacer()
                        Text("30°C")
                    }
                }
                .padding()
                Spacer()
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
