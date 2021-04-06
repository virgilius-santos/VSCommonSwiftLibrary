
import Foundation

extension Cache {
  subscript(key: Key) -> Value? {
    get { value(forKey: key) }
    set {
      guard let value = newValue else {
        // If nil was assigned using our subscript,
        // then we remove any value for that key:
        removeValue(forKey: key)
        return
      }
      
      insert(value, forKey: key)
    }
  }
}
