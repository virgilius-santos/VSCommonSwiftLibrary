
import XCTest
import PalindromeFeature

final class PalindromeCheckTests: XCTestCase {
  func test_valid_palindrome_pair() {
    XCTAssert(checkIfIsPalindrome(word: "oovvoo"))
  }
  
  func test_valid_palindrome_odd() {
    XCTAssert(checkIfIsPalindrome(word: "oovvvoo"))
  }
  
  func test_valid_palindrome_caseInsensitive() {
    XCTAssert(checkIfIsPalindrome(word: "OovvvOo"))
  }
  
  func test_valid_palindrome_twoLetters() {
    XCTAssert(checkIfIsPalindrome(word: "aa"))
  }
  
  func test_invalid_palindrome_odd() {
    XCTAssertFalse(checkIfIsPalindrome(word: "oovvnoo"))
  }
  
  func test_invalid_palindrome_empty() {
    XCTAssertFalse(checkIfIsPalindrome(word: ""))
  }
  
  func test_invalid_palindrome_onlyOnceLetter() {
    XCTAssertFalse(checkIfIsPalindrome(word: "a"))
  }
  
  func test_invalid_palindrome_twoDifferentLetters() {
    XCTAssertFalse(checkIfIsPalindrome(word: "ab"))
  }
  
  func test_valid_palindrome_phrase() {
    XCTAssert(checkIfIsPalindrome(word: "Socorram-me, subi no ônibus em Marrocos"))
  }
}
