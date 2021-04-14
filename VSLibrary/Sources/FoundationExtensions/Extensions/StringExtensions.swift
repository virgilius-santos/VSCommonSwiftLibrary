
import Foundation

public extension String {
  subscript (i: Int) -> Character {
    self[index(startIndex, offsetBy: i)]
  }
}

public func onlyAlphanumerics(_ string: String) -> String {
  string.components(separatedBy: CharacterSet.alphanumerics.inverted).joined(separator: "")
}

public func diacriticInsensitive(_ string: String) -> String {
  string.folding(options: .diacriticInsensitive, locale: nil)
}

public func file(from name: String, extension: String = "txt", in bundle: Bundle?) -> String? {
    
    enum ReadFileError: Error {
        case notFound
    }
    
    do {
        if let fileURL = bundle?.url(forResource: name, withExtension: "txt") {
            return try String(contentsOf: fileURL)
        } else {
            throw ReadFileError.notFound
        }
    } catch {
        logError(error)
    }
    return nil
}
