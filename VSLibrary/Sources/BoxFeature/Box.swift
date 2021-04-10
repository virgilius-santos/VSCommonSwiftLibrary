
import Foundation

public final class Box<T> {
  
  public typealias Listener = (T) -> ()
  
  public var value: T {
    didSet {
      updateListeners()
    }
  }
  
  private var listeners: [String: Listener]
  
  public init(_ value: T) {
    self.value = value
    self.listeners = [String: Listener]()
  }
  
  public func bind(key: String, listener: @escaping Listener) {
    listeners[key] = (listener)
    updateListeners()
  }
  
  public func removeBind(key: String) {
    listeners[key] = nil
  }
  
  func updateListeners() {
    listeners.values.forEach({$0(value)})
  }
  
  deinit {
    listeners.removeAll()
  }
}
