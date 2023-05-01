//
//  WeatherBackgroundView.swift
//  JustWeather
//
//  Created by Jakub Prus on 30/04/2023.
//

import SwiftUI

struct WeatherBackgroundView: View {
    
    @State var xOffsetCircle: CGFloat = 0
    @State var yOffsetCircle: CGFloat = 0
    @State var opacityCircle: Double = 0
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ZStack {
            Circle()
                .foregroundColor(.purple)
                .blur(radius: 30)
                .offset(x: -xOffsetCircle, y: -yOffsetCircle*2)
                .opacity(opacityCircle)
            Circle()
                .foregroundColor(.red)
                .blur(radius: 30)
                .offset(x: 0, y: -yOffsetCircle)
                .opacity(opacityCircle)
            Circle()
                .foregroundColor(.orange)
                .blur(radius: 30)
                .offset(x: xOffsetCircle, y: 0)
                .opacity(opacityCircle)
            Circle()
                .foregroundColor(colorScheme == .dark ? .black : .white)
                .blur(radius: 30)
                .offset(x: xOffsetCircle*2, y: yOffsetCircle)
                .opacity(opacityCircle)
            Circle()
                .foregroundColor(Color(red: 0, green: 0, blue: 0.8))
                .blur(radius: 20)
                .offset(x: xOffsetCircle*8, y: yOffsetCircle*7)
                .frame(width: 125)
        }
        .onAppear {
            withAnimation(.spring(dampingFraction: 0.5).delay(0.5)) {
                xOffsetCircle = 20
                yOffsetCircle = 50
            }
            withAnimation(.linear.delay(0.5)) {
                opacityCircle = 1
            }
        }
    }
}

struct WeatherBackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherBackgroundView()
    }
}
