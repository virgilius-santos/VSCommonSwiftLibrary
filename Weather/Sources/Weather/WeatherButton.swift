
import SwiftUI
import Functions
import Styles

struct WeatherButton: View {
    var title: String
    
    @EnvironmentObject private var enviroment: WeatherEnviroment
    
    var body: some View {
        Text(title)
            .frame(width: 280, height: 50)
            .foregroundColor(enviroment.theme.primary)
            .background(enviroment.theme.secondary)
            .font(.system(size: 18, weight: .bold, design: .rounded))
            .cornerRadius(10)
    }
}
