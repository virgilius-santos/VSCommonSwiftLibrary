
import UIKit
import IQKeyboardManager

class KeyboardManager {
    
    static var shared = KeyboardManager()
    init() {}
    
    var enable: Bool = false {
        didSet(newValue) {
          IQKeyboardManager.shared().isEnabled = newValue
        }
    }
    
}
