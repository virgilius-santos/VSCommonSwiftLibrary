import XCTest
@testable import BetterRest

final class BetterRestTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(BetterRest().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
