//
//  FinancesMacApp.swift
//  FinancesMac
//
//  Created by Virgilius Santos on 06/02/22.
//

import SwiftUI

@main
struct FinancesMacApp: App {
    var body: some Scene {
        WindowGroup {
            Content()
        }
        .windowStyle(.hiddenTitleBar)
    }
}

private var screen = NSScreen.main?.visibleFrame ?? .zero

struct Content: View {
    @StateObject var viewModel = ContentViewModel()
    
    var body: some View {
        NavigationView {
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
                        AllChatsView(
                            recentMsgs: viewModel.recentMsgs,
                            selectedRecentMsgs: $viewModel.selectedRecentMsgs
                        )
                    default:
                        Text(viewModel.selectedTab)
                    }
                }
            )
        }
        .ignoresSafeArea(.all, edges: .all)
        .frame(width: screen.width / 1.2, height: screen.height - 60)
    }
}

struct AllChatsView: View {
    var recentMsgs: [RecentMessage]
    @Binding var selectedRecentMsgs: UUID?
    
    var body: some View {
        List(selection: $selectedRecentMsgs) {
            ForEach(recentMsgs) { msg in
                NavigationLink(
                    destination: { Text("Destination") },
                    label: { RecentCardView(recentMsg: msg) }
                )
            }
        }
        .listStyle(.sidebar)
    }
}

struct RecentCardView: View {
    var recentMsg: RecentMessage
    
    var body: some View {
        HStack {
            Image(systemName: recentMsg.userImage)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 40, height: 40)
                .clipShape(Circle())
            
            VStack(spacing: 4) {
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(recentMsg.userName)
                            .fontWeight(.bold)
                        
                        Text(recentMsg.lastMessage)
                            .font(.caption)
                    }
                    
                    Spacer(minLength: 10)
                    
                    VStack {
                        Text(recentMsg.lastMessageTime)
                            .font(.caption)
                        
                        Text(recentMsg.pendingNessages)
                            .font(.caption2)
                            .padding(5)
                            .foregroundColor(.white)
                            .background(Color.blue)
                            .clipShape(Circle())
                    }
                }
            }
        }
    }
}

final class ContentViewModel: ObservableObject {
    @Published var selectedTab = "All Chats"
    @Published var recentMsgs: [RecentMessage]
    @Published var selectedRecentMsgs: UUID?
    
    init() {
        recentMsgs = [RecentMessage(), RecentMessage(), RecentMessage()]
        selectedRecentMsgs = recentMsgs.first?.id
    }
}

struct Message: Identifiable, Equatable {
    let id = UUID()
    let message = "teste \(Int.random(in: 0...1000))"
    let myMessage = Bool.random()
}


struct RecentMessage: Identifiable, Equatable {
    let id = UUID()
    let lastMessage = "teste \(Int.random(in: 0...1000))"
    let lastMessageTime = "\(Int.random(in: 0...23)):\(Int.random(in: 0...59))"
    let pendingNessages = "\(Int.random(in: 0...10))"
    let userName = "Carlos"
    let userImage = "gear"
    let allMessages = [Message(), Message()]
}
