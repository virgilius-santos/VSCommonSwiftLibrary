
import SwiftUI
import Functions
import Combine

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(EnviromentDefinitions())
    }
}

struct ContentView: View {
    
    @EnvironmentObject private var enviroment: EnviromentDefinitions
    
    var weatherList: [Weather] = [
        Weather(
            day: "Tue",
            image: "cloud.sun.fill",
            temperature: "76°"
        ),
        Weather(
            day: "Wed",
            image: "sun.max.fill",
            temperature: "88°"
        ),
        Weather(
            day: "Thu",
            image: "wind.snow",
            temperature: "55°"
        ),
        Weather(
            day: "Fri",
            image: "snow",
            temperature: "60°"
        ),
        Weather(
            day: "Sat",
            image: "sunset.fill",
            temperature: "25°"
        )
    ]
    
    var body: some View {
        ZStack {
            Background()
            
            VStack {
                Header(
                    title: "Cupertino, CA!"
                )
                
                WeatharHighlighted(
                    temperature: "76°",
                    image: !enviroment.isNight ? "cloud.sun.fill" : "wind.snow"
                )
                .padding(.bottom, 40)
                
                WeatherCollection(weatherList: weatherList)
                
                Spacer()
                
                Button {
                    enviroment.isNight.toggle()
                } label: {
                    SimpleButton(title: "Change Day Time")
                }
                
                Spacer()
            }
        }
    }
}

struct Background: View {
    
    @EnvironmentObject private var enviroment: EnviromentDefinitions
    
    var body: some View {
        [enviroment.theme.primary, enviroment.theme.primaryLight]
            |> Gradient.init(colors:)
            |> {
                LinearGradient(
                    gradient: $0,
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            }
            |> { $0.edgesIgnoringSafeArea(.all) }
    }
}

struct Header: View {
    var title: String
    
    @EnvironmentObject private var enviroment: EnviromentDefinitions
    
    var body: some View {
        Text(title)
            |> textStyle(size: 32, color: enviroment.theme.secondary)
            |> simplePadding
    }
}

struct SimpleButton: View {
    var title: String
    
    @EnvironmentObject private var enviroment: EnviromentDefinitions
    
    var body: some View {
        Text(title)
            .frame(width: 280, height: 50)
            .foregroundColor(enviroment.theme.primary)
            .background(enviroment.theme.secondary)
            .font(.system(size: 18, weight: .bold, design: .rounded))
            .cornerRadius(10)
    }
}
