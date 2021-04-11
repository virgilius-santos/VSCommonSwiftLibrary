

import SwiftUI
import Combine

final class EnviromentDefinitions: ObservableObject {
    @Published var isNight: Bool = false {
        didSet { updateTheme() }
    }
    
    @Published var theme: Theme = Theme.light
    
    init() {}
    
    private func updateTheme() {
        theme = isNight ? .dark : .light
    }
}
