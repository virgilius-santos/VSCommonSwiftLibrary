import Foundation
import Styles

enum Validation {
    case success
    case error(message: AlertMessage)
}

typealias ValidationFunction = (_ word: String, _ usedWords: [String], _ rootWord: String) -> Validation

extension Array where Element == ValidationFunction {
    func validate(_ word: String, _ usedWords: [String], _ rootWord: String) -> Validation {
        for rule in self {
            let result = rule(word, usedWords, rootWord)
            switch result {
            case .success:
                continue
            case .error:
                return result
            }
        }
        return .success
    }
}
