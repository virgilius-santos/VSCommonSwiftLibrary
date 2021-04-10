
import Foundation
import WordDataSource
import RealmSwift
import os.log

public extension WordDataSource {
  static var live: WordDataSource {
    
    let dataSource = WordDS()
    
    return WordDataSource(
      saveWord: dataSource.save,
      deleteWord: dataSource.delete,
      numberOfWords: { dataSource.words.count },
      word: { dataSource.words[$0].string }
    )
  }
}

private class WordDS {
  private var realm: Realm = try! Realm()
  
  init() {
    Realm.Configuration.defaultConfiguration.inMemoryIdentifier = "WordDS"
  }
  
  private(set) lazy var words = realm.objects(Word.self).sorted(byKeyPath: "string")
  
  func delete(row: Int) {
    let word: Word = words[row]
    
    do {
      try realm.write {
          realm.delete(word)
      }
    } catch {
      os_log("%s", error.localizedDescription)
    }
  }
  
  func save(string: String) {
    guard !contains(string) else { return }
    
    let word = Word()
    word.string = string
        
    do {
      try realm.write {
          realm.add(word)
      }
    } catch {
      os_log("%s", error.localizedDescription)
    }
  }
  
  private func contains(_ string: String) -> Bool {
    words.contains(where: {$0.string.elementsEqual(string)})
  }
}

class Word: Object {
  @objc dynamic var string = ""
}
