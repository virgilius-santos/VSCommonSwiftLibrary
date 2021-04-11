
import SwiftUI
import Functions
import Combine
import Weather

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(WeatherEnviroment())
    }
}

struct ContentView: View {
        
    var weatherViewModel: WeatherViewModel = {
        var list: [Weather] = [
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
        
        return WeatherViewModel(
            weatherList: list,
            title: "Cupertino, CA",
            currentWeather: list[0],
            buttonTitle: "Change Day Time"
        )
    }()
    
    var body: some View {
        WeatherView(weather: weatherViewModel)
            .environmentObject(WeatherEnviroment())
    }
}
