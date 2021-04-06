
import Foundation

prefix operator ^

public prefix func ^ <Root, Value>(kp: KeyPath<Root, Value>) -> (Root) -> Value {
  { $0[keyPath: kp] }
}

public prefix func ^ <Root, Value>(_ kp: WritableKeyPath<Root, Value>)
-> Setter<Root, Root, Value, Value> {
  prop(kp)
}
