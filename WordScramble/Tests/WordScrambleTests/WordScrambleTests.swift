import XCTest
@testable import WordScramble

final class WordScrambleTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(WordScramble().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
