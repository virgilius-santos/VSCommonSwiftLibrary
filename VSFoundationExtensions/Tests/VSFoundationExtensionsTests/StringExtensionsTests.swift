
import XCTest
import VSFoundationExtensions

final class StringTests: XCTestCase {
    func test_subscript() {
      XCTAssertEqual("NSObject"[1], "S")
      XCTAssertEqual("NSObject"[7], "t")
      XCTAssertEqual("NSObject"[0], "N")
    }
}
