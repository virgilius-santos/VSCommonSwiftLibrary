import SwiftUI

struct TabButton: View {
    var image: String
    var title: String
    @Binding var selectedTab: String
    
    var body: some View {
        
        let isSelectedTab = selectedTab == title
        
        Button(
            action: {
                withAnimation { selectedTab = title }
            },
            label: {
                VStack(spacing: 7) {
                    Image(systemName: image)
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(isSelectedTab ? .white : .gray)
                    
                    Text(title)
                        .fontWeight(.bold)
                        .font(.system(size: 11))
                        .foregroundColor(isSelectedTab ? .white : .gray)
                }
                .padding(.vertical, 8)
                .frame(width: 70)
                .contentShape(Rectangle())
                .background(Color.primary.opacity(isSelectedTab ? 0.15 : 0))
                .cornerRadius(10)
            }
        )
        .buttonStyle(.plain)
    }
}

//struct TabButton_Previews: PreviewProvider {
//    static var previews: some View {
//        TabButton(
//            image: "message",
//            title: "All Chats",
//            selectedTab: $viewMdoel.selectedTab
//        )
//    }
//}
//
//final class TabButtonViewModel: ObservableObject {
//    @Published var selectedTab = "All Chats"
//}
