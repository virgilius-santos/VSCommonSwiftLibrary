
import UIKit

public extension UIEdgeInsets {
  init(
    top: CGFloat? = nil,
    left: CGFloat? = nil,
    bottom: CGFloat? = nil,
    right: CGFloat? = nil,
    defaultValue: CGFloat = .zero
  ) {
    self.init(
      top: top ?? defaultValue,
      left: left ?? defaultValue,
      bottom: bottom ?? defaultValue,
      right: right ?? defaultValue
    )
  }
}
