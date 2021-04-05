
import UIKit
import VSFunctionsFeature

public func aspectRatioStyle<V: UIView>(size: CGSize) -> (V) -> Void {
  {
    constraint(item: $0, attribute: .width, toItem: $0, attribute: .height, multiplier: size.width / size.height)
  }
}

public func implicitAspectRatioStyle<V: UIView>(_ view: V) -> Void {
  aspectRatioStyle(size: view.frame.size)(view)
}

public func wrapView<V: UIView>(padding: UIEdgeInsets) -> (UIView) -> (V) -> Void {
  { wrapper in
    { subview in
      subview
        |> autoLayout(in: wrapper)
        <> {
          constraint(item: $0, attribute: .leading, toItem: wrapper, constant: padding.left)
          constraint(item: $0, attribute: .top, toItem: wrapper, constant: padding.top)
          constraint(item: wrapper, attribute: .trailing, toItem: $0, constant: padding.right)
          constraint(item: wrapper, attribute: .bottom, toItem: $0, constant: padding.bottom)
        }
    }
  }
}


public func baseButtonStyle(edge: UIEdgeInsets, font: UIFont) -> (UIButton) -> Void {
  {
    $0.contentEdgeInsets = edge
    $0.titleLabel?.font = font
  }
}

public func baseLabelStyle(
  font: UIFont,
  textAlignment: NSTextAlignment = .center,
  color: UIColor
) -> (UILabel) -> Void {
  {
    $0.textColor = color
    $0.font = font
    $0.numberOfLines = 0
    $0.textAlignment = textAlignment
  }
}

public func fill(backgroundColor: UIColor, tintColor: UIColor) -> (UIView) -> Void {
  {
    $0.backgroundColor = backgroundColor
    $0.tintColor = tintColor
  }
}

public func roundedStyle<View: UIView>(radius: CGFloat) -> (_ view: View) -> Void {
  { view in
    view.clipsToBounds = true
    view.layer.cornerRadius = radius
  }
}

public func borderStyle<View: UIView>(
  borderColor: UIColor,
  borderWidth: CGFloat
) -> (_ view: View) -> Void {
  { view in
    view.layer.borderColor = borderColor.cgColor
    view.layer.borderWidth = borderWidth
  }
}
