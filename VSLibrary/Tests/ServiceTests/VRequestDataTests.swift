
import XCTest
@testable import Service
import SnapshotTesting

class VRequestDataTests: XCTestCase {
  var sut: VRequestData!
  
  func test_dump_onlyURL() {
    sut = VRequestData(urlString: "http://www.google.com")
    
    assertSnapshot(matching: sut.url, as: .dump)
  }
  
  func test_dump_withPaths() {
    sut = VRequestData(urlString: "http://www.google.com", paths: ["image", 123])
    
    assertSnapshot(matching: sut.url, as: .dump)
  }
  
  func test_dump_withQueries() {
    sut = requestWithQueries()
    
    assertSnapshot(matching: sut.url, as: .dump)
  }
  
  func test_dump_withQueries_and_addQuery() {
    sut = requestWithQueries()
    
    sut.addQuery(key: "mais", value: 42)
    
    assertSnapshot(matching: sut.url, as: .dump)
  }
  
  func test_dump_withQueries_and_addHeader() {
    sut = requestWithQueries()
    
    sut.addHeader(key: "mais", value: 42)
    
    assertSnapshot(matching: sut.url, as: .dump)
    assertSnapshot(matching: sut.headers, as: .dump)
  }
  
  func test_dump_withQueries_and_addPath() {
    sut = requestWithQueries()
    
    sut.add(path: "playlist")
    
    assertSnapshot(matching: sut.url, as: .dump)
  }
  
  func test_dump_addEncodableBody() throws {
    sut = try .init(urlString: "http://www.google.com", body: Dummy())
        
    let string = String(data: try XCTUnwrap(sut.body), encoding: .utf8)
    assertSnapshot(matching: string, as: .dump)
  }
  
  func test_dump_addDictBody() throws {
    sut = try .init(urlString: "http://www.google.com", body: ["duumy": "dummy"])
        
    let string = String(data: try XCTUnwrap(sut.body), encoding: .utf8)
    assertSnapshot(matching: string, as: .dump)
  }

  private func requestWithQueries() -> VRequestData {
    VRequestData(
      urlString: "http://www.google.com",
      queryParameters: [("user", "joao"), ("device", 123)]
    )
  }
  
  struct Dummy: Encodable {
    let id = "dummy"
  }
}
