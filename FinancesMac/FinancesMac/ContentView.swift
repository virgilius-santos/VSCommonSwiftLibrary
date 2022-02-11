import SwiftUI

private var screen = NSScreen.main?.visibleFrame ?? .zero

struct Content: View {
    @StateObject var viewModel = ContentViewModel()
    
    var body: some View {
        
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

struct Message: Identifiable, Equatable {
    let id = UUID()
    let message: String
    let myMessage: Bool
}

struct RecentMessage: Identifiable, Equatable {
    let id = UUID()
    let lastMsg: String
    let lastMsgTime: String
    let pendingMsgs: String
    let userName: String
    let userImage: String
    let allMsgs: [Message]
}

var kEachmsg = [
    Message(
        message: "New Album Is Going To Be Released!!!!",
        myMessage: false
    ),
    Message(
        message: "Discover the innovative world of Apple and shop everything iPhone, iPad, Apple Watch, Mac, and Apple TV, plus explore accessories, entertainment!!!",
        myMessage: false
    ),
    Message(
        message: "Amazon.in: Online Shopping India - Buy mobiles, laptops, cameras, books, watches, apparel, shoes and e-Gift Cards.",
        myMessage: false
    ),
    Message(
        message: "SwiftUI is an innovative, exceptionally simple way to build user interfaces across all Apple platforms with the power of Swift. Build user interfaces for any Apple device using just one set of tools and APIs.",
        myMessage: true
    ),
    Message(
        message: "At Microsoft our mission and values are to help people and businesses throughout the world realize their full potential.!!!!",
        myMessage: false
    ),
    Message(
        message: "Firebase is Google's mobile platform that helps you quickly develop high-quality apps and grow your business.",
        myMessage: true
    ),
    Message(
        message: "Kavsoft - SwiftUI Tutorials - Easier Way To Learn SwiftUI With Downloadble Source Code.!!!!",
        myMessage: true
    )
]


var kRecentMsgs: [RecentMessage] = [
    RecentMessage(
        lastMsg: "Apple Tech",
        lastMsgTime: "15:00",
        pendingMsgs: "9",
        userName: "Jenna Ezarik",
        userImage: "jenna",
        allMsgs: kEachmsg.shuffled()
    ),
    RecentMessage(
        lastMsg: "New Album Is Going To Be Released!!!!",
        lastMsgTime: "14:32",
        pendingMsgs: "2",
        userName: "Taylor",
        userImage: "p0",
        allMsgs: kEachmsg.shuffled()
    )
    ,RecentMessage(
        lastMsg: "Hi this is Steve Rogers !!!",
        lastMsgTime: "14:35",
        pendingMsgs: "2",
        userName: "Steve",
        userImage: "p1",
        allMsgs: kEachmsg.shuffled()
    )
    ,RecentMessage(
        lastMsg: "New Tutorial From Kavosft !!!",
        lastMsgTime: "14:39",
        pendingMsgs: "1",
        userName: "Kavsoft",
        userImage: "p2",
        allMsgs: kEachmsg.shuffled()
    )
    ,RecentMessage(
        lastMsg: "New SwiftUI API Is Released!!!!",
        lastMsgTime: "14:50",
        pendingMsgs: "",
        userName: "SwiftUI",
        userImage: "p3",
        allMsgs: kEachmsg.shuffled()
    ),
    RecentMessage(
        lastMsg: "Founder Of Microsoft !!!",
        lastMsgTime: "14:50",
        pendingMsgs: "",
        userName: "Bill Gates",
        userImage: "p5",
        allMsgs: kEachmsg.shuffled()
    ),
    RecentMessage(
        lastMsg: "Founder Of Amazon",
        lastMsgTime: "14:39",
        pendingMsgs: "1",
        userName: "Jeff",
        userImage: "p6",
        allMsgs: kEachmsg.shuffled()
    ),
    RecentMessage(
        lastMsg: "Released New iPhone 11!!!",
        lastMsgTime: "14:32",
        pendingMsgs: "2",
        userName: "Tim Cook",
        userImage: "p7",
        allMsgs: kEachmsg.shuffled()
    )
]

