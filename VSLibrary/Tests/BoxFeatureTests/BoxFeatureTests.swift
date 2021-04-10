import XCTest
import BoxFeature

final class BoxTests: XCTestCase {
  func test_startValue() {
    let value = Bool.random()
    let sut = Box(value)
    XCTAssertEqual(sut.value, value)
  }
  
  func test_should_receiveStartValue_when_subscribed() {
    let sut = Box(true)
    
    let exp = expectation(description: "receive on start")
    
    sut.bind(key: "dummy", listener: { value in
      XCTAssertTrue(sut.value)
      exp.fulfill()
    })
    
    waitForExpectations(timeout: 0.1, handler: nil)
  }
  
  func test_should_receiveUpdate_when_valueIsUpdated() {
    let sut = Box(true)
    var values = [Bool]()
    
    let exp = expectation(description: "receive update value")
    exp.expectedFulfillmentCount = 2
    
    sut.bind(key: "dummy", listener: { value in
      values.append(sut.value)
      exp.fulfill()
    })
    
    sut.value = false
    
    waitForExpectations(timeout: 0.1, handler: nil)
    
    XCTAssertEqual(values, [true, false])
  }
  
  func test_removeListener() {
    let sut = Box(true)
    
    var expList = [XCTestExpectation]()
    
    expList.append(expectation(description: "start"))
    
    let completion = { (value: Bool) in
      expList.forEach { $0.fulfill() }
    }
    
    let key = "dummy"
    
    sut.bind(key: key, listener: completion)
    
    waitForExpectations(timeout: 0.1, handler: nil)
    
    expList.removeAll()
    expList.append({
      let exp = expectation(description: "inverted")
      exp.isInverted = true
      return exp
    }())
    
    sut.removeBind(key: key)
    
    sut.value = true
    
    waitForExpectations(timeout: 0.1, handler: nil)
  }
}
