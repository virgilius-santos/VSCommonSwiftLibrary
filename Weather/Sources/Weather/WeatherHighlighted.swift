
import SwiftUI
import Functions
import Styles

struct WeatherHighlighted: View {
    var temperature: String
    var image: String
    
    @EnvironmentObject private var enviroment: WeatherEnviroment
    
    var body: some View {
        VStack(spacing: 10) {
            Image(systemName: image)
                |> curry(imageStyle)(180)
                |> { $0.colorMultiply(enviroment.theme.secondary) }
            
            Text(temperature)
                .baseStyle(size: 70, color: enviroment.theme.secondary)
        }
    }
}
