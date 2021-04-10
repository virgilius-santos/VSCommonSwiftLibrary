
import Foundation
import PalindromeFeature
import Functions
import BoxFeature
import WordDataSource

public extension PalindromeViewModel {
  static func live(dataSource: WordDataSource) -> PalindromeViewModel {
        
    var word: String = String()
    
    let isPalindrome: Box<Bool> = .init(false)
    let showError: PublishBox<Void> = .init()
    
    return PalindromeViewModel(
      isPalindrome: isPalindrome,
      showError: showError,
      saveWord: { completion in
        guard isPalindrome.value == true else {
          showError.value = ()
          return
        }
        dataSource.saveWord(word)
        isPalindrome.value = false
        completion()
      },
      deleteWord: { row, completion in
        dataSource.deleteWord(row)
        completion()
      },
      numberOfWords: { dataSource.numberOfWords() },
      wordFor: { dataSource.word($0) },
      newWord: { string in
        word = (string ?? "")
        isPalindrome.value = checkIfIsPalindrome(word: word)
      }
    )
  }
}
