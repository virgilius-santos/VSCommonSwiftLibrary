
import SwiftUI
import Combine
//import GuessTheFlag
//import Styles
//import Functions
import WordScramble

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct ContentView: View {
    var body: some View {
//        GuessTheFlagView.mock
        WordScrambleView()
    }
}
