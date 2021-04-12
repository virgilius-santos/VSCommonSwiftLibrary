
import SwiftUI
import Functions
import Styles

struct WeatherButton: View {
    var title: String
    
    @EnvironmentObject private var enviroment: WeatherEnviroment
    
    var body: some View {
        Text(title)
            .baseStyle(size: 18, weight: .bold, color: enviroment.theme.primary)
            .roundedStyle(foregroundColor: enviroment.theme.primary, background: enviroment.theme.secondary)
    }
}
