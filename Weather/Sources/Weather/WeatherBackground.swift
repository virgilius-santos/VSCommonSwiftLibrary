
import SwiftUI
import Functions
import Styles

struct WeatherBackground: View {
    
    @EnvironmentObject private var enviroment: WeatherEnviroment
    
    var body: some View {
        [enviroment.theme.primary, enviroment.theme.primaryLight]
            |> Gradient.init(colors:)
            |> {
                LinearGradient(
                    gradient: $0,
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            }
            |> { $0.edgesIgnoringSafeArea(.all) }
    }
}
