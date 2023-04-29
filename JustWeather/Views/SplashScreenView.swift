//
//  SplashScreenView.swift
//  JustWeather
//
//  Created by Jakub Prus on 29/04/2023.
//

import SwiftUI

struct SplashScreenView: View {
    
    @State var textOffset: CGFloat = 0
    @State var opacityValue = 0.0
    @Binding var finishedSplashScreen: Bool
    
    var body: some View {
        ZStack {
            Circle()
                .foregroundColor(Color(red: 0, green: 0, blue: 0.8))
                .blur(radius: 20)
                .frame(width: 125)
            Text("JUST WEATHER")
                .font(.custom("GothicA1-Medium", size: 45))
            Text("JUST WEATHER")
                .font(.custom("GothicA1-Medium", size: 45))
                .offset(x: textOffset, y: textOffset)
            Text("JUST WEATHER")
                .font(.custom("GothicA1-Medium", size: 45))
                .offset(x: -textOffset, y: -textOffset)
        }
        .opacity(opacityValue)
        .onAppear {
            withAnimation(.easeIn(duration: 0.25).delay(1)) {
                opacityValue = 1.0
            }
            withAnimation(.spring(dampingFraction: 0.5).delay(2)) {
                textOffset = 75
            }
            withAnimation(.easeIn.delay(3)) {
                finishedSplashScreen = true
            }
        }
    }
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        
        @State var finished = false
        SplashScreenView(finishedSplashScreen: $finished)
    }
}
