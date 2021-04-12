
import SwiftUI

@available(iOS 13.0, *)
public struct NotificationView<Content: View>: View {
    let content: Content

    public init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    public var body: some View {
        content
            .padding()
            .background(Color(.tertiarySystemBackground))
            .cornerRadius(16)
            .transition(.move(edge: .top))
            .animation(.spring())
    }
}
