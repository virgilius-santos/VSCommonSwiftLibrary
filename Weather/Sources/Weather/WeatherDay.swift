
import SwiftUI
import Functions
import Styles

struct WeatherDay: View {
    
    var weather: Weather
    
    @EnvironmentObject private var enviroment: WeatherEnviroment
    
    var body: some View {
        VStack() {
            Text(weather.day)
                .baseStyle(size: 16, color: enviroment.theme.secondary)
            
            Image(systemName: weather.image)
                .imageStyle(size: 40)
                .colorMultiply(enviroment.theme.secondary)
            
            Text(weather.temperature)
                .baseStyle(size: 24, color: enviroment.theme.secondary)
        }
    }
}
