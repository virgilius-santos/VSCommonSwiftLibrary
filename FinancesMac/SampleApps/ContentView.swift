import SwiftUI
import WordScramble
import WeSplit
import Weather
import ViewsAndModifiers
import UnitConversion
import iExpense
import GuessTheFlag
import BetterRest
import Animations

struct ContentView: View {
    var body: some View {
      NavigationView {
        List {
          Cell(title: "Word Scramble", action: { WordScrambleView() })
          
          Cell(title: "We Split", action: { WeSplitView() })
          
          Cell(title: "Weather", action: { WeatherView.mock })
          
          Cell(title: "View And Modifiers", action: { ViewAndModifiersView() })
          
          Cell(title: "Unit Conversion", action: { UnitConversionView() })
          
          Cell(title: "iExpense", action: { app_view })
          
          Cell(title: "GuessTheFlag", action: { GuessTheFlagView() })
          
          Cell(title: "BetterRest", action: { BettterRestView() })
          
          Cell(title: "Animations", action: { animationsView })
        }
      }
    }
}

struct Cell<V: View>: View {
  var title: String
  var action: () -> V
  
  var body: some View {
    NavigationLink(
      destination: action,
      label: {
        HStack {
          Text(title)
          Spacer()
        }
        .contentShape(Rectangle())
      })
  }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
