import XCTest
@testable import GuessTheFlag
import SnapshotTesting
import SwiftUI

final class GuessTheFlagTests: XCTestCase {
    
    func test_viewSnapshot() {
        random = { 1 }
        shuffle = { _ in }
        
        let vc = UIHostingController(rootView: GuessTheFlagView.mock)
        vc.view.frame = UIScreen.main.bounds
        assertSnapshot(matching: vc, as: .image)
    }
}
