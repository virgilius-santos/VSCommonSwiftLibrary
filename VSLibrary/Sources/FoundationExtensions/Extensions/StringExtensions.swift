
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
