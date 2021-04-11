import XCTest
@testable import Weather

final class WeatherTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(Weather().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
