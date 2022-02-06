
import Foundation

public struct WordDataSource {
  public var saveWord: (_ string: String) -> Void
  public var deleteWord: (_ row: Int) -> Void
  public var numberOfWords: () -> Int
  public var word: (_ row: Int) -> String
  
  public init(
    saveWord: @escaping (String) -> Void,
    deleteWord: @escaping (Int) -> Void,
    numberOfWords: @escaping () -> Int,
    word: @escaping (Int) -> String
  ) {
    self.saveWord = saveWord
    self.deleteWord = deleteWord
    self.numberOfWords = numberOfWords
    self.word = word
  }
}
