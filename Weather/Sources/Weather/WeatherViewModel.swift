
import SwiftUI
import Functions
import Styles

public struct WeatherViewModel {
    
    var weatherList: [Weather]
    var title: String
    var currentWeather: Weather
    var buttonTitle: String
    
    public init(weatherList: [Weather], title: String, currentWeather: Weather, buttonTitle: String) {
        self.weatherList = weatherList
        self.title = title
        self.currentWeather = currentWeather
        self.buttonTitle = buttonTitle
    }
}

public extension WeatherViewModel {
    static let mock: WeatherViewModel = {
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
}
