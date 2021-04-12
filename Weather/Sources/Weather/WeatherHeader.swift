
import SwiftUI
import Functions
import Styles

struct WeatherHeader: View {
    var title: String
    
    @EnvironmentObject private var enviroment: WeatherEnviroment
    
    var body: some View {
        Text(title)
            .baseStyle(size: 32, color: enviroment.theme.secondary)
    }
}
