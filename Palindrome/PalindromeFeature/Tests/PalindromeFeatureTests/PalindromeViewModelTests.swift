import XCTest
import PalindromeFeatureLive
import PalindromeFeature
import Functions
import BoxFeature
import WordDataSource

final class PalindromeViewModelTests: XCTestCase {
  
  func test_numberOfWords() {
    var dataSource: WordDataSource = .mock
    dataSource.numberOfWords = { 56 }
    let sut = PalindromeViewModel.live(dataSource: dataSource)
    XCTAssertEqual(sut.numberOfWords(), 56)
  }
  
  func test_should_alert_when_wordIsEmpty() {
    let dataSource: WordDataSource = .mock
    let sut = PalindromeViewModel.live(dataSource: dataSource)
    
    let exp = expectation(description: "alert")
    sut.showError.bind(key: "dummy", listener: {
      exp.fulfill()
    })
    
    sut.saveWord({
      fatalError("should not complete")
    })
    
    waitForExpectations(timeout: 1, handler: nil)
  }
  
  func test_should_alert_when_wordIsInvalid() {
    let dataSource: WordDataSource = .mock
    let sut = PalindromeViewModel.live(dataSource: dataSource)
    
    let exp = expectation(description: "alert")
    
    sut.showError.bind(key: "dummy", listener: {
      exp.fulfill()
    })
    
    sut.newWord("dummy")
    
    sut.saveWord({
      fatalError("should not complete")
    })
    
    waitForExpectations(timeout: 1, handler: nil)
  }
  
  func test_should_save_when_wordIsValid() {
    
    var isPalindrome = [Bool]()
    
    var dataSource: WordDataSource = .mock
    
    let exp = expectation(description: "alert")
    exp.expectedFulfillmentCount = 5
    
    dataSource.saveWord = {
      XCTAssertEqual($0, "tenet")
      exp.fulfill()
    }
    
    let sut = PalindromeViewModel.live(dataSource: dataSource)
    
    sut.showError.bind(key: "dummy", listener: {
      fatalError("should not alert")
    })
    
    sut.isPalindrome.bind(key: "dummy", listener: {
      isPalindrome.append($0)
      exp.fulfill()
    })
    
    sut.newWord("tenet")
    
    sut.saveWord({
      exp.fulfill()
    })
    
    waitForExpectations(timeout: 0.1, handler: nil)
    
    XCTAssertEqual(isPalindrome, [false, true, false])
  }
  
  func test_should_delete() {
        
    var dataSource: WordDataSource = .mock
    
    let exp = expectation(description: "alert")
    exp.expectedFulfillmentCount = 2
    
    dataSource.deleteWord = {
      XCTAssertEqual($0, 42)
      exp.fulfill()
    }
    
    let sut = PalindromeViewModel.live(dataSource: dataSource)
    
    sut.deleteWord(42) {
      exp.fulfill()
    }
    
    waitForExpectations(timeout: 0.1, handler: nil)
  }
  
  func test_should_getWord() {
        
    var dataSource: WordDataSource = .mock
    
    dataSource.word = {
      XCTAssertEqual($0, 42)
      return "dummy"
    }
    
    let sut = PalindromeViewModel.live(dataSource: dataSource)
    
    XCTAssertEqual(sut.wordFor(42), "dummy")
  }
}
