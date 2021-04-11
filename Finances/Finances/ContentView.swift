
import SwiftUI
import Functions
import Combine
import Weather

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct ContentView: View {
    var body: some View {
        WeatherView.mock
    }
}
