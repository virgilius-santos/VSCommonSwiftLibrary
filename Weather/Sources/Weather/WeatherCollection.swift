
import SwiftUI
import Functions

struct WeatherCollection: View {
    var gridItemLayout = [GridItem(.flexible())]
    
    var weatherList: [Weather]
    
    var body: some View {
        ScrollView(.horizontal) {
            LazyHGrid(rows: gridItemLayout, spacing: 20) {
                ForEach(weatherList, content: WeatherDay.init)
            }
            .padding()
        }
    }
}
