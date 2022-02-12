import SwiftUI

struct TabView<LeftContent: View, MainContent: View>: View {
  var leftContent: () -> LeftContent
  var mainContent: () -> MainContent
  
  var body: some View {
    HStack(spacing: 0) {
      VStack(content: leftContent)
        .padding()
        .padding(.top)
        .background(BlurView())
      
      ZStack(content: mainContent)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
  }
  
  init(
    @ViewBuilder leftContent: @escaping () -> LeftContent,
    @ViewBuilder mainContent: @escaping () -> MainContent
  ) {
    self.leftContent = leftContent
    self.mainContent = mainContent
  }
}
