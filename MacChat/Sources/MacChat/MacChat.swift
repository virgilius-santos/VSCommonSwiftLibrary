import SwiftUI
import Styles

private var screen = NSScreen.main?.visibleFrame ?? .zero

public struct MacChat: View {
  @StateObject var viewModel = ContentViewModel()
  
  public var body: some View {
    
    TabView(
      leftContent: {
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
        
        TabButton(
          image: "gear",
          title: "Settings",
          selectedTab: $viewModel.selectedTab
        )
      },
      mainContent: {
        switch viewModel.selectedTab {
        case "All Chats":
          NavigationView {
            AllChatsView(
              recentMsgs: viewModel.recentMsgs,
              selectedRecentMsgs: $viewModel.selectedRecentMsgs,
              searchText: $viewModel.search
            )
          }
        default:
          Text(viewModel.selectedTab)
        }
      }
    )
      .ignoresSafeArea(.all, edges: .all)
      .frame(width: screen.width / 1.2, height: screen.height - 60)
  }
  
  public init() {}
}

final class ContentViewModel: ObservableObject {
  @Published var selectedTab = "All Chats"
  @Published var recentMsgs: [RecentMessage]
  @Published var selectedRecentMsgs: UUID?
  @Published var search: String
  @Published var message: String
  
  init() {
    self.recentMsgs = kRecentMsgs
    selectedRecentMsgs = kRecentMsgs.first?.id
    search = ""
    message = ""
  }
}
