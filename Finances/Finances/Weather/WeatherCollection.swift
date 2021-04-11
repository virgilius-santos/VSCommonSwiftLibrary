
import SwiftUI
import Functions

struct Weather: Identifiable {
    var id: UUID = .init()
    var day: String
    var image: String
    var temperature: String
}

struct WeatherDay: View {
    
    var weather: Weather
    
    @EnvironmentObject private var enviroment: EnviromentDefinitions
    
    var body: some View {
        VStack() {
            Text(weather.day)
                |> textStyle(size: 16, color: enviroment.theme.secondary)
                |> simplePadding
            
            Image(systemName: weather.image)
                |> curry(imageStyle)(40)
                |> { $0.colorMultiply(enviroment.theme.secondary) }
            
            Text(weather.temperature)
                |> textStyle(size: 24, color: enviroment.theme.secondary)
                |> simplePadding
        }
    }
}

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

struct WeatharHighlighted: View {
    var temperature: String
    var image: String
    
    @EnvironmentObject private var enviroment: EnviromentDefinitions
    
    var body: some View {
        VStack(spacing: 10) {
            Image(systemName: image)
                |> curry(imageStyle)(180)
                |> { $0.colorMultiply(enviroment.theme.secondary) }
            
            Text(temperature)
                |> textStyle(size: 70, color: enviroment.theme.secondary)
                |> simplePadding
        }
    }
}

func textStyle(
    size: CGFloat,
    weight: Font.Weight = .medium,
    color: Color = .white
) -> (Text) -> Text {
    { text in
        text.font(.system(size: size, weight: weight, design: .rounded))
            .foregroundColor(color)
    }
}

func simplePadding(_ view: Text) -> some View {
    view.padding()
}

func imageStyle(size: CGFloat, _ view: Image) -> some View {
    view.renderingMode(.original)
        .resizable()
        .aspectRatio(contentMode: .fit)
        .frame(width: size, height: size)
}
