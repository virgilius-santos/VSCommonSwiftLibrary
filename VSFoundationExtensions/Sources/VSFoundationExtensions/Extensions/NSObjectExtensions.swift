
import Foundation

public extension NSObject {
  static var identifier: String { .init(describing: Self.self) }
  var identifier: String { Self.identifier }
}
