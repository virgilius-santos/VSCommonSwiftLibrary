import XCTest
@testable import Weather
import SnapshotTesting
import SwiftUI

final class WeatherTests: XCTestCase {
    func test_viewSnapshot() {
        let vc = UIHostingController(rootView: WeatherView.mock)
        vc.view.frame = UIScreen.main.bounds
        assertSnapshot(matching: vc, as: .image)
    }
    
    func test_viewSnapshot_darkMode() {
        let vc = UIHostingController(rootView: WeatherView.darkMock)
        vc.view.frame = UIScreen.main.bounds
        assertSnapshot(matching: vc, as: .image)
    }
}
