
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

public extension WordDataSource {
  static let memory: WordDataSource = {
    class Local {
      var words = [String]()
    }
    
    let local = Local()
    
    return WordDataSource(
      saveWord: { local.words.append($0 ) },
      deleteWord: { local.words.remove(at: $0) },
      numberOfWords: { local.words.count },
      word: { local.words[$0] }
    )
  }()
}
