
import Foundation
import BoxFeature

public extension PalindromeViewModel {
  static let mock = PalindromeViewModel(
    isPalindrome: Box<Bool>(true),
    saveWord: { _ in },
    deleteWord: { _, _ in },
    numberOfWords: { 17 },
    wordFor: { _ in "dummy" },
    newWord: { _ in }
  )
}
