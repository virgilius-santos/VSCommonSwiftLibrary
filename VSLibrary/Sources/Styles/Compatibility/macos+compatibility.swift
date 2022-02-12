import SwiftUI

#if os(OSX)

public enum UITextAutocapitalizationType {
  case none
}

public extension View {
  func autocapitalization(_ style: UITextAutocapitalizationType) -> some View {
    self
  }
  
  func navigationBarTitle<S>(_ title: S) -> some View where S : StringProtocol {
    self
  }
  
  func navigationBarItems<L>(leading: L) -> some View where L : View {
    self
  }
}
#endif
