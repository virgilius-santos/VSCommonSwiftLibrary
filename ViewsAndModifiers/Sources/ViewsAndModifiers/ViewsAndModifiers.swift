
import SwiftUI
import Combine
import Styles
//import Functions

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct ContentView: View {
    @State private var notificationShown = false

        var body: some View {
            VStack {
                if self.notificationShown {
                    NotificationView {
                        Text("notification")
                    }
                }

                Spacer()

                Button("toggle") {
                    self.notificationShown.toggle()
                }

                Spacer()
            }
        }
}
