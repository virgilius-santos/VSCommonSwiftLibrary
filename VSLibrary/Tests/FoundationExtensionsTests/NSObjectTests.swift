import XCTest
import FoundationExtensions

final class NSObjectTests: XCTestCase {
    func test_identifier() {
      XCTAssertEqual(NSObject.identifier, "NSObject")
      XCTAssertEqual(NSObject().identifier, "NSObject")
    }
}
