
import UIKit
import Functions

public func autoLayout<P: UIView, V: UIView>(in parent: P) -> (_ view: V) -> Void {
  { view in
    view.translatesAutoresizingMaskIntoConstraints = false
    parent.addSubview(view)
  }
}

@discardableResult public func constraint(
  item view1: Any,
  attribute attr1: NSLayoutConstraint.Attribute,
  relatedBy relation: NSLayoutConstraint.Relation = .equal,
  toItem view2: Any? = nil,
  attribute attr2: NSLayoutConstraint.Attribute? = nil,
  multiplier: CGFloat = 1,
  constant c: CGFloat = .zero,
  priority: UILayoutPriority = .required,
  file: String = #fileID,
  line: Int = #column,
  activate: Bool = true
) -> NSLayoutConstraint {
  let constraint = NSLayoutConstraint.init(
    item: view1,
    attribute: attr1,
    relatedBy: relation,
    toItem: view2,
    attribute: attr2 ?? attr1,
    multiplier: multiplier,
    constant: c
  )
  
  constraint.priority = priority
  constraint.identifier = "\(file):\(line)"
  constraint.isActive = activate
  
  return constraint
}

public func leadingAndTrailingConstraint(
  item view1: Any,
  toItem view2: Any,
  leftEdgeBy leftEdge: NSLayoutConstraint.Relation = .equal,
  rightEdgeBy rightEdge: NSLayoutConstraint.Relation? = nil,
  leftPadding: CGFloat = .zero,
  rightPadding: CGFloat? = nil
) {
  constraint(
    item: view1,
    attribute: .leading,
    relatedBy: leftEdge,
    toItem: view2,
    constant: leftPadding
  )
  constraint(
    item: view2,
    attribute: .trailing,
    relatedBy: rightEdge ?? leftEdge,
    toItem: view1,
    constant: rightPadding ?? leftPadding
  )
}

public func recomendedSize(_ size: CGSize = .init(width: 44, height: 44)) -> (UIView) -> Void {
  {
    constraint(item: $0, attribute: .height, relatedBy: .greaterThanOrEqual, constant: size.height)
    constraint(item: $0, attribute: .width, relatedBy: .greaterThanOrEqual, constant: size.width)
  }
}
