import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(ViewsAndModifiersTests.allTests),
    ]
}
#endif
