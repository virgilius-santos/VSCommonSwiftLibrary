
import Foundation
import XCTest
@testable import Service

final class VErrorHandlerTests: XCTestCase {
  let sut: VErrorHandler = .init()
  
  func test_build_should_returnGeneric_forUnknowRule() {
    XCTAssertEqual(sut.build(9).errorType, .generic)
  }
  
  func test_build_should_returnNil_forUnknowRuleIfOptional() {
    XCTAssertNil((sut.build(9) as VSessionError?)?.errorType)
  }
  
  func test_build_should_returnGeneric_withoutParameters() {
    XCTAssertEqual(sut.build().errorType, .generic)
  }
  
  func test_build_should_returnVSessionError_when_errorIsVSessionError() {
    XCTAssertEqual(sut.build(VSessionErrorType.urlInvalid).errorType, .urlInvalid)
  }
  
  func test_build_should_returnResponseFailure_when_codeIsLessThen200() {
    XCTAssertEqual(sut.build(CodeHTTPURLResponseMock(9)).errorType, .responseFailure)
  }
  
  func test_build_should_returnResponseFailure_when_codeIsGreaterThen299() {
    XCTAssertEqual(sut.build(CodeHTTPURLResponseMock(309)).errorType, .responseFailure)
  }
  
  func test_build_should_returnNil_when_codeIsGreaterThen199_and_lessThen300() {
    XCTAssertNil((sut.build(CodeHTTPURLResponseMock(200)) as VSessionError?)?.errorType)
  }
}

private class CodeHTTPURLResponseMock: HTTPURLResponse {
  let _code: Int
  
  init(_ code: Int) {
    _code = code
    super.init(url: URL(string: "www.google.com")!,
               mimeType: nil,
               expectedContentLength: 0,
               textEncodingName: nil)
  }
  
  required init?(coder _: NSCoder) {
    nil
  }
  
  override var statusCode: Int {
    _code
  }
}
