import SwiftUI

extension View {
    @ViewBuilder
    func hidden(_ hidden: Bool) -> some View {
        if hidden {
            EmptyView()
        } else {
            self
        }
    }
}
