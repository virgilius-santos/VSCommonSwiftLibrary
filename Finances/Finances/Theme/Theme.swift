
import SwiftUI

struct Theme {
        
    var primary = Color.blue
    var primaryLight = Color(UIColor.blue.withAlphaComponent(0.3))
    var secondary = Color.white
    var white = Color.white
    var blue = Color.blue
    
    init(
        primary: Color = Color.blue,
        light: Color = Color(UIColor.blue.withAlphaComponent(0.3)),
        secondary: Color = Color.white,
        white: Color = Color.white,
        blue: Color = Color.blue
    ) {
        self.primary = primary
        self.primaryLight = light
        self.secondary = secondary
        self.white = white
        self.blue = blue
    }
}

extension Theme {
    static var light = Theme.init()
    
    static var dark = Theme.init(
        primary: .black,
        light: .gray,
        secondary: .green
    )
}
