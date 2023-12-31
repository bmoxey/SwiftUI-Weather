//
//  ContentView.swift
//  SwiftUI-Weather
//
//  Created by Brett Moxey on 3/8/2023.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var locationManager = LocationManager.shared
    
    @State private var isNight = false
    
    var body: some View {
        Group {
            if locationManager.userLocation == nil {
                LocationRequestView()
            } else if let location = locationManager.userLocation {
                ZStack {
                    BackgroundView(isNight: isNight)
                    VStack {
                        Text("\(location)")
                        CityTextView(cityName: "Southbank, Vic")
                        MainWeatherView(imageName: isNight ? "moon.stars.fill" : "cloud.sun.fill", temperature: 23)
                        HStack(spacing: 20) {
                            WeatherDayView(dayOfWeek: "TUE", imageName: "cloud.sun.fill", temperature: 25)
                            WeatherDayView(dayOfWeek: "WED", imageName: "sun.max.fill", temperature: 28)
                            WeatherDayView(dayOfWeek: "THU", imageName: "wind", temperature: 12)
                            WeatherDayView(dayOfWeek: "FRI", imageName: "wind.snow", temperature: 5)
                            WeatherDayView(dayOfWeek: "SAT", imageName: "snow", temperature: 2)
                        }
                        Spacer()
                        Button {
                            isNight.toggle()
                        } label: {
                            WeatherButton(title: "Change Day Time", textColor: .blue, backgroundColor: .white)
                        }
                        Spacer()
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct WeatherDayView: View {
    
    var dayOfWeek: String
    var imageName: String
    var temperature: Int
    
    var body: some View {
        VStack(spacing: 20) {
            Text(dayOfWeek)
                .font(.system(size:16, weight: .medium))
                .foregroundColor(.white)
            Image(systemName: imageName)
                .symbolRenderingMode(.multicolor)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 40, height: 40)
            Text("\(temperature)°")
                .font(.system(size:28, weight: .medium))
                .foregroundColor(.white)
        }
    }
}

struct BackgroundView: View {
    
    var isNight: Bool
    
    var body: some View {
//        LinearGradient(gradient: Gradient(colors: [isNight ? .black : .blue,
//                                          isNight ? .gray : Color("lightBlue")]),
//                       startPoint: .topLeading,
//                       endPoint: .bottomTrailing)
//        .ignoresSafeArea()
        ContainerRelativeShape()
            .fill(isNight ? Color.black.gradient : Color.blue.gradient)
            .ignoresSafeArea()
    }
}

struct CityTextView: View {
    
    var cityName: String
    
    var body: some View {
        Text(cityName)
            .font(.system(size: 32, weight: .medium, design: .default))
            .foregroundColor(.white)
            .padding()
    }
}

struct MainWeatherView: View {
    var imageName: String
    var temperature: Int
    
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: imageName)
                .symbolRenderingMode(.multicolor)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 180, height: 180)
            Text("\(temperature)°")
                .font(.system(size: 70, weight: .medium))
                .foregroundColor(.white)
        }
        .padding(.bottom, 40)
    }
}

