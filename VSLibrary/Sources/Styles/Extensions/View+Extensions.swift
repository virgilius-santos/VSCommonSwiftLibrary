import SwiftUI

public extension View {
  func roundedStyle(foregroundColor: Color, background: Color) -> some View {
    frame(width: 280, height: 50)
      .background(background)
      .cornerRadius(10)
  }
}

public extension View {
  func alert(isPresented: Binding<Bool>, message: AlertMessage) -> some View {
    alert(isPresented: isPresented) {
      Alert(
        title: Text(message.title),
        message: Text(message.message),
        dismissButton: .default(Text("OK"))
      )
    }
  }
}

public struct AlertMessage {
  
  public var title = ""
  public var message = ""
  public var showing = false
  
  public init(title: String = "", message: String = "", showing: Bool = false) {
    self.title = title
    self.message = message
    self.showing = showing
  }
}
