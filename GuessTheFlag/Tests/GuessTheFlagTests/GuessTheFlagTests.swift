import XCTest
@testable import GuessTheFlag

final class GuessTheFlagTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(GuessTheFlag().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
