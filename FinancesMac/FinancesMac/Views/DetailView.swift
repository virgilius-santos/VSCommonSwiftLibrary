import SwiftUI

struct DetailView: View {
    var recentMsg: RecentMessage
    @State var message: String = ""
    
    var body: some View {
        HStack {
            VStack {
                HStack {
                    Text(recentMsg.userName)
                        .font(.title2)
                    
                    Spacer()
                    
                    IconButton(
                        action: {},
                        iconName: "magnifyingglass"
                    )
                    
                    IconButton(
                        action: {},
                        iconName: "sidebar.right"
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
            
            ExpandView(recentMsg: recentMsg)
                .frame(width: 200)
                .background(BlurView())
        }
        .ignoresSafeArea(.all, edges: .all)
    }
}

struct ExpandView: View {
    
    var recentMsg: RecentMessage
    
    var body: some View {
        HStack {
            
            Divider()
            
            VStack(spacing: 25) {
                
                Image.init(recentMsg.userImage)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 90, height: 90)
                    .clipShape(Circle())
                    .padding(.top, 35)
                
                Text(recentMsg.userName)
                    .font(.title)
                    .fontWeight(.bold)
                
                HStack {
                    
                    LabelIconButton(
                        action: { },
                        iconName: "bell.slash",
                        label: "Mute"
                    )
                    
                    Spacer()
                    
                    LabelIconButton(
                        action: { },
                        iconName: "hand.raised.fill",
                        label: "Block"
                    )
                    
                    Spacer()
                    
                    LabelIconButton(
                        action: { },
                        iconName: "exclamationmark.triangle",
                        label: "Report"
                    )
                }
                .foregroundColor(.gray)
                
                Spacer()
                
            }
            .padding(.horizontal)
            .frame(maxWidth: .infinity)
        }
    }
}
