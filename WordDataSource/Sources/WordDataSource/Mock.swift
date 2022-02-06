
import Foundation

public extension WordDataSource {
  static let mock = WordDataSource(
    saveWord: { _ in },
    deleteWord: { _ in },
    numberOfWords: { 17 },
    word: { _ in "dummy" }
  )
  
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
