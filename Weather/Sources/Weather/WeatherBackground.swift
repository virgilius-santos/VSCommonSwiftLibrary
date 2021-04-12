
import SwiftUI
import Functions
import Styles

struct WeatherBackground: View {
    
    @EnvironmentObject private var enviroment: WeatherEnviroment
    
    var body: some View {
        LinearGradient(enviroment.theme.primary, enviroment.theme.primaryLight)
            .edgesIgnoringSafeArea(.all)
    }
}
