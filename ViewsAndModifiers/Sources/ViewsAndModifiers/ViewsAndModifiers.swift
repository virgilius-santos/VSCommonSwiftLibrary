
import SwiftUI
import Combine
import Styles
//import Functions

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ViewAndModifiersView()
  }
}

public struct ViewAndModifiersView: View {
  @State private var notificationShown = false
  
  public var body: some View {
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
  
  public init() {}
}
