import SwiftUI

private let screen = NSScreen.main?.visibleFrame ?? .zero

struct TabView: View {
    @StateObject var viewModel: ContentViewModel = .init()
    var buttons: [TabButton] = []
    
    var body: some View {
        HStack {
            VStack {
                TabButton(
                    image: "message",
                    title: "All Chats",
                    selectedTab: $viewModel.selectedTab
                )
                
                TabButton(
                    image: "person",
                    title: "Personal",
                    selectedTab: $viewModel.selectedTab
                )
                
                TabButton(
                    image: "bubble.middle.bottom",
                    title: "Bots",
                    selectedTab: $viewModel.selectedTab
                )
                
                TabButton(
                    image: "slider.horizontal.3",
                    title: "Edit",
                    selectedTab: $viewModel.selectedTab
                )
                
                Spacer()
            }
            .padding()
            .padding(.top)
            .background(BlurView())
            
            Spacer()
        }
        .frame(width: screen.width / 1.2, height: screen.height - 60)
    }
}

struct TabView_Previews: PreviewProvider {
    static var previews: some View {
        TabView()
    }
}

final class ContentViewModel: ObservableObject {
    @Published var selectedTab = "All Chats"
}
