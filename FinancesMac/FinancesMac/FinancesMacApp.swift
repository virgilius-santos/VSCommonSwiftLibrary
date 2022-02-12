import SwiftUI
import MacChat

@main
struct FinancesMacApp: App {
    var body: some Scene {
        WindowGroup {
            MacChat()
        }
        .windowStyle(.hiddenTitleBar)
    }
}
