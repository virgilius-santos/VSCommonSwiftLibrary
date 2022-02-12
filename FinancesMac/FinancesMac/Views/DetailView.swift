import SwiftUI

struct DetailView: View {
    var recentMsg: RecentMessage
    @State private var showExpandView: Bool = true
    var body: some View {
        HStack {
            MessageView(
                recentMsg: recentMsg,
                siteBarAction: { withAnimation { showExpandView.toggle() }}
            )
            
            ExpandView(recentMsg: recentMsg)
                .background(BlurView())
                .frame(width: showExpandView ? 300 : .zero)
                .opacity(showExpandView ? 1 : .zero)
        }
        .ignoresSafeArea(.all, edges: .all)
    }
}
