
import SwiftUI
import Functions
import Styles

struct WeatherDay: View {
    
    var weather: Weather
    
    @EnvironmentObject private var enviroment: WeatherEnviroment
    
    var body: some View {
        VStack() {
            Text(weather.day)
                |> textStyle(size: 16, color: enviroment.theme.secondary)
                |> simplePadding
            
            Image(systemName: weather.image)
                |> curry(imageStyle)(40)
                |> { $0.colorMultiply(enviroment.theme.secondary) }
            
            Text(weather.temperature)
                |> textStyle(size: 24, color: enviroment.theme.secondary)
                |> simplePadding
        }
    }
}
