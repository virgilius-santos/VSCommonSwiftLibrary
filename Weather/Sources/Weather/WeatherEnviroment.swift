

import SwiftUI
import Combine

public final class WeatherEnviroment: ObservableObject {
    @Published public var isNight: Bool = false {
        didSet { updateTheme() }
    }
    
    @Published var theme: WeatherTheme = .light
    
    public init() {}
    
    private func updateTheme() {
        theme = isNight ? .dark : .light
    }
}

extension WeatherEnviroment {
    static var darkMock: WeatherEnviroment {
        let env = WeatherEnviroment()
        env.isNight = true
        return env
    }
}
