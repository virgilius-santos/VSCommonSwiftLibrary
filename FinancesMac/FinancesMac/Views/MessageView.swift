import SwiftUI

struct MessageView: View {
    var recentMsg: RecentMessage
    var siteBarAction: () -> Void
    
    @State private var siteBarExpanded = false
    @State private var message: String = ""
    
    var body: some View {
        VStack {
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
            
            Spacer()
            
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
    }
}

struct MessageView_Previews: PreviewProvider {
    static var previews: some View {
        Content()
    }
}
