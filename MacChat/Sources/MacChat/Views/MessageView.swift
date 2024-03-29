import SwiftUI
import Styles

struct MessageView: View {
  var recentMsg: RecentMessage
  var siteBarAction: () -> Void
  
  @State private var siteBarExpanded = false
  @State private var message: String = ""
  
  var body: some View {
    VStack {
      topBar
      
      messages
      
      input
    }
  }
  
  var topBar: some View {
    HStack(spacing: 15) {
      Text(recentMsg.userName)
        .font(.title2)
      
      Spacer()
      
      IconButton(
        action: {},
        iconName: "magnifyingglass"
      )
      
      IconButton(
        action: {
          siteBarExpanded.toggle()
          siteBarAction()
        },
        iconName: "sidebar.right",
        foregroundColor: siteBarExpanded ? .primary : .blue
      )
      
    }
    .padding()
  }
  
  var messages: some View {
    GeometryReader { geometry in
      ScrollView {
        ScrollViewReader { proxy in
          VStack(spacing: 18) {
            ForEach(recentMsg.allMsgs) { msg in
              HStack(spacing: 10) {
                let width = geometry.frame(in: .global).width * 0.6
                if msg.myMessage {
                  myMessageCard(msg: msg, width: width)
                } else {
                  reicevedMessageCard(msg: msg, width: width)
                }
              }
              .tag(msg.id)
            }
            .onAppear {
              if let lastId = recentMsg.allMsgs.last?.id {
                proxy.scrollTo(lastId, anchor: .bottom)
              }
            }
            .onChange(of: recentMsg.allMsgs) { newValue in
              if let lastId = recentMsg.allMsgs.last?.id {
                proxy.scrollTo(lastId, anchor: .bottom)
              }
            }
          }
          .padding(.bottom, 30)
        }
      }
    }
  }
  
  var input: some View {
    HStack(spacing: 15) {
      IconButton(
        action: {},
        iconName: "paperplane"
      )
      
      TextField("Enter Message", text: $message)
        .textFieldStyle(.plain)
        .padding(.vertical, 8)
        .padding(.horizontal)
        .clipShape(Capsule())
        .background(Capsule().strokeBorder(Color.white))
      
      IconButton(
        action: {},
        iconName: "face.smiling.fill"
      )
      
      IconButton(
        action: {},
        iconName: "mic"
      )
    }
    .padding([.horizontal, .bottom])
  }
  
  @ViewBuilder
  func myMessageCard(msg: Message, width: CGFloat) -> some View {
    Spacer()
    
    MessageCard(
      message: msg.message,
      width: width,
      style: .rightCard
    )
  }
  
  @ViewBuilder
  func reicevedMessageCard(msg: Message, width: CGFloat) -> some View {
    ProfileView(
      image: recentMsg.userImage,
      style: .xSmall
    )
      .offset(y: 20)
    
    MessageCard(
      message: msg.message,
      width: width,
      style: .leftCard
    )
    
    Spacer()
  }
}
