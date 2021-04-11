
import SwiftUI

public struct Weather: Identifiable {
    public var id: UUID = .init()
    var day: String
    var image: String
    var temperature: String
    
    public init(id: UUID = .init(), day: String, image: String, temperature: String) {
        self.id = id
        self.day = day
        self.image = image
        self.temperature = temperature
    }
}
