import SwiftUI

struct AllChatsView: View {
    var recentMsgs: [RecentMessage]
    @Binding var selectedRecentMsgs: UUID?
    @Binding var searchText: String
    
    var body: some View {
        VStack {
            
            Group {
                
                HStack{
                    Spacer()
                    
                    IconButton(
                        action: {},
                        iconName: "plus"
                    )
                }
                
                SearchText(searchText: $searchText)
            }
            
            List(selection: $selectedRecentMsgs) {
                ForEach(recentMsgs) { msg in
                    NavigationLink(
                        destination: { DetailView(recentMsg: msg) },
                        label: { RecentCardView(recentMsg: msg) }
                    )
                }
            }
            .listStyle(.sidebar)
        }
    }
}
