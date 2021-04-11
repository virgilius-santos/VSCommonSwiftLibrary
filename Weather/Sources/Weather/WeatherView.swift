
import SwiftUI
import Functions
import Styles

public struct WeatherView: View {
    
    @EnvironmentObject private var enviroment: WeatherEnviroment
    
    public var weather: WeatherViewModel
    
    public var body: some View {
        ZStack {
            WeatherBackground()
            
            VStack {
                WeatherHeader(
                    title: weather.title
                )
                
                WeatherHighlighted(
                    temperature: weather.currentWeather.temperature,
                    image: weather.currentWeather.image
                )
                .padding(.bottom, 40)
                
                WeatherCollection(weatherList: weather.weatherList)
                
                Spacer()
                
                Button {
                    enviroment.isNight.toggle()
                } label: {
                    WeatherButton(title: weather.buttonTitle)
                }
                
                Spacer()
            }
        }
    }
    
    public init(weather: WeatherViewModel) {
        self.weather = weather
    }
}
public extension WeatherView {
    static let mock: some View = WeatherView(weather: WeatherViewModel.mock)
        .environmentObject(WeatherEnviroment())
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView.mock
    }
}
