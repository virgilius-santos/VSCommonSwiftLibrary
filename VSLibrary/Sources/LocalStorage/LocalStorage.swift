
import Foundation
import FoundationExtensions

public class LocalStorage {
  
  public static var shared = LocalStorage(name: "VSLocal")
  
  var userDefaults: UserDefaults
  
  init(name: String) {
    userDefaults = UserDefaults(suiteName: name) ?? .standard
  }
  
  public func set(_ obj: Any?, forKey key: String) {
    userDefaults.setValue(obj, forKey: key)
  }
  
  public func get<Obj>(forKey key: String) -> Obj? {
    userDefaults.value(forKey: key) as? Obj
  }
}
