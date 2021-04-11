
import SwiftUI

struct WeatherTheme {
        
    var primary = Color.blue
    var primaryLight = Color(UIColor.blue.withAlphaComponent(0.3))
    var secondary = Color.white
    
    init(
        primary: Color = Color.blue,
        light: Color = Color(UIColor.blue.withAlphaComponent(0.3)),
        secondary: Color = Color.white
    ) {
        self.primary = primary
        self.primaryLight = light
        self.secondary = secondary
    }
}

extension WeatherTheme {
    static var light = WeatherTheme.init()
    
    static var dark = WeatherTheme.init(
        primary: .black,
        light: .gray,
        secondary: .green
    )
}
