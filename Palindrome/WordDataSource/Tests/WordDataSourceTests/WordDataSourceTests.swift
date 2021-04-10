import XCTest
import WordDataSource
@testable import WordDataSourceLive
import RealmSwift
import Realm

final class WordDataSourceTests: XCTestCase {
  
  func test_initial_value() {
    let sut = makeSut()
    
    XCTAssertEqual(sut.numberOfWords(), 0)
  }
  
  func test_add_word() {
    let sut = makeSut()
    
    sut.saveWord("dummy")
    XCTAssertEqual(sut.numberOfWords(), 1)
    XCTAssertEqual(sut.word(0), "dummy")
    
    sut.deleteWord(0)
    XCTAssertEqual(sut.numberOfWords(), 0)
  }
  
  func test_add_word_sharing_data() {
    let sut0 = makeSut()
    
    sut0.saveWord("dummy")
    
    let sut1 = makeSut()
    XCTAssertEqual(sut1.numberOfWords(), 1)
    XCTAssertEqual(sut1.word(0), "dummy")
    
    sut1.deleteWord(0)
    XCTAssertEqual(sut1.numberOfWords(), 0)
    XCTAssertEqual(sut0.numberOfWords(), 0)
  }
  
  func makeSut(_ function: String = #function) -> WordDataSource {
    Realm.Configuration.defaultConfiguration.inMemoryIdentifier = function
    let sut = WordDataSource.live
    
    return sut
  }
}
