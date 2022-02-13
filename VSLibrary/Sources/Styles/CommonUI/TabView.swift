import SwiftUI

#if os(OSX)
public struct TabView<LeftContent: View, MainContent: View>: View {
  var leftContent: () -> LeftContent
  var mainContent: () -> MainContent
  
  public var body: some View {
    HStack(spacing: 0) {
      VStack(content: leftContent)
        .padding()
        .padding(.top)
        .background(BlurView())
      
      ZStack(content: mainContent)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
  }
  
  public init(
    @ViewBuilder leftContent: @escaping () -> LeftContent,
    @ViewBuilder mainContent: @escaping () -> MainContent
  ) {
    self.leftContent = leftContent
    self.mainContent = mainContent
  }
}
#endif
