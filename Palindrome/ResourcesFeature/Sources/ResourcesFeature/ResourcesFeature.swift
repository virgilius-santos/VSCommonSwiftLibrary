
import UIKit

public extension CGFloat {
  static let spacing_4: Self = 4
  static let spacing_8: Self = 8
  static let spacing_12: Self = 12
  static let spacing_16: Self = 16
  static let spacing_20: Self = 20
  
  static let size_24: Self = 24
  static let size_40: Self = 40
  static let size_60: Self = 60
  
  static let radius_8: Self = 8
  
  static let border_1: Self = 1
}

public extension UIEdgeInsets {
  static let buttonMargin: Self = .init(
    top: .spacing_12,
    left: .spacing_16,
    bottom: .spacing_12,
    right: .spacing_16
  )
  
  static let buttonPadding: Self = .init(
    top: .spacing_4,
    left: .spacing_8,
    bottom: .spacing_4,
    right: .spacing_8
  )
}

public extension UIFont {
  static let button: UIFont = .systemFont(ofSize: 16, weight: .medium)
  static let titleLabel: UIFont = .systemFont(ofSize: 14, weight: .medium)
  static let subtitleLabel: UIFont = .systemFont(ofSize: 11, weight: .light)
}

public extension UIColor {
  static let backgroundButton: UIColor = .black
  static let tintButton: UIColor = .white
}

public extension UIImage {
  static let check: UIImage? = UIImage.init(named: "check-icon", in: .module, compatibleWith: nil)
}
