
import SwiftUI

public struct NotificationView<Content: View>: View {
    let content: Content

    public init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    public var body: some View {
        content
            .padding()
            .background(.tertiary)
            .cornerRadius(16)
            .transition(.move(edge: .top))
            .animation(.spring(), value: 5)
    }
}
