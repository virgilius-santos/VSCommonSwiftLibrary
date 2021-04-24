import XCTest
@testable import iExpense

final class iExpenseTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(iExpense().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
