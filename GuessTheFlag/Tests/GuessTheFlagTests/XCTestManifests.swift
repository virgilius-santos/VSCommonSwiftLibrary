import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(GuessTheFlagTests.allTests),
    ]
}
#endif
