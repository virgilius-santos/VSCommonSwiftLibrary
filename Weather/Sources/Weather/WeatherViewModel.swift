
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
