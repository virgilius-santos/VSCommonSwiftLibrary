import Foundation
import FoundationExtensions
import Styles

struct WordScrambleModel {
    var allWords = readFileContent()
   
    var usedWords = [String]()
    var rootWord = ""
    var newWord = ""
    
    var points: Int {
        usedWords.reduce(0, { $0 + $1.count * 5 })
    }
    
    var alert = AlertMessage()
    
    var rules: [ValidationFunction] = [
        isDifferent,
        isLong,
        isOriginal,
        isPossible,
        isSpelledWord
    ]
    
    mutating func addNewWord() {
        // lowercase and trim the word, to make sure we don't add duplicate words with case differences
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)

        // exit if the remaining string is empty
        switch rules.validate(answer, usedWords, rootWord) {
        case .success:
            usedWords.insert(answer, at: 0)
            newWord = ""
        case let .error(message):
            alert = message
        }
    }
    
    mutating func startGame() {
        rootWord = randomString(allWords) ?? "silkworm"
        usedWords = []
    }
}

var isDifferent: ValidationFunction = { (word, _, rootWord) -> Validation in
    guard !word.elementsEqual(rootWord) else {
        return .error(message: .init(
            title: "Word used is the original",
            message: "Be more original",
            showing: true
        ))
    }
    return .success
}

var isLong: ValidationFunction = { (word, _, _) -> Validation in
    guard word.count > 2 else {
        return .error(message: .init(
            title: "Word used is too short",
            message: "Be more original",
            showing: true
        ))
    }
    return .success
}

var isOriginal: ValidationFunction = { (word, usedWords, rootWord) -> Validation in
    guard word.count > 0 else {
        return .error(message: .init(
            title: "Word used already",
            message: "Be more original",
            showing: true
        ))
    }
    return .success
}

var isPossible: ValidationFunction = { (word, usedWords, _) -> Validation in
    guard !usedWords.contains(word) else {
        return .error(message: .init(
            title: "Word not recognized",
            message: "You can't just make them up, you know!",
            showing: true
        ))
    }
    return .success
}

var isSpelledWord: ValidationFunction = { (word, _, _) -> Validation in
    guard textChecker(word) else {
        return .error(message: .init(
            title: "Word not possible",
            message: "That isn't a real word.",
            showing: true
        ))
    }
    return .success
}

#if os(OSX)
import Cocoa
typealias KTextChecker = NSSpellChecker

var textChecker: (_ word: String) -> Bool = { word in
  let checker = KTextChecker()
  
  let range = NSRange(location: 0, length: word.utf16.count)
  let misspelledRange = checker
    .checkSpelling(of: word, startingAt: 0, language: "en", wrap: false, inSpellDocumentWithTag: 0, wordCount: nil)
  let allGood = misspelledRange.location == NSNotFound
  return allGood
}

#elseif os(iOS)
import UIKit
typealias KTextChecker = UITextChecker

var textChecker: (_ word: String) -> Bool = { word in
  let checker = KTextChecker()
  
  let range = NSRange(location: 0, length: word.utf16.count)
  let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
  let allGood = misspelledRange.location == NSNotFound
  return allGood
}
#endif

var readFileContent: () -> [String] = {
    guard let fileString = file(from: "start", in: .module) else {
        fatalError("file not found")
    }
    return fileString.lowercased().components(separatedBy: "\n")
}

var randomString: ([String]) -> String? = {
    $0.randomElement()
}
