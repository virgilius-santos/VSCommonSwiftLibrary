
import SwiftUI

@main
struct FinancesApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(EnviromentDefinitions())
        }
    }
}
