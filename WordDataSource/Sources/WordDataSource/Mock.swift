
import Foundation

public extension WordDataSource {
  static func fixture(
    saveWord: @escaping (String) -> Void = { _ in fatalError("not implemented") },
    deleteWord: @escaping (Int) -> Void = { _ in fatalError("not implemented") },
    numberOfWords: @escaping () -> Int = { fatalError("not implemented") },
    word: @escaping (Int) -> String = { _ in fatalError("not implemented") }
  ) -> WordDataSource {
      .init(
        saveWord: saveWord,
        deleteWord: deleteWord,
        numberOfWords: numberOfWords,
        word: word
      )
  }
}
