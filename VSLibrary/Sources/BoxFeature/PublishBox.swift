
import Foundation

public class PublishBox<T> {
  
  public typealias Listener = (T) -> ()
  
  public var value: Optional<T> = .none {
    didSet {
      updateListeners()
    }
  }
  
  private var listeners: [String: Listener]
  
  public init() {
    self.listeners = [String:Listener]()
  }
  
  public func bind(key: String, listener: @escaping Listener) {
    listeners[key] = (listener)
  }
  
  public func removeBind(key: String) {
    listeners[key] = nil
  }
  
  func updateListeners() {
    if case .some(let v) = value {
      listeners.values.forEach({$0(v)})
    }
  }
  
  deinit {
    listeners.removeAll()
  }
}
