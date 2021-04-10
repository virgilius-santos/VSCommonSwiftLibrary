
import UIKit
import Functions
import ResourcesFeature
import UIKitExtensions
import FoundationExtensions

private extension String {
  static let titleLabel = "\(PalindromeView.identifier)\\titleLabel"
  
  static let tableView = "\(PalindromeView.identifier)\\tableView"
  
  static let subtitleLabel = "\(PalindromeView.identifier)\\subtitleLabel"
  
  static let textField = "\(PalindromeView.identifier)\\textField"
  
  static let imageView = "\(PalindromeView.identifier)\\imageView"
  
  static let wrapperButton = "\(PalindromeView.identifier)\\wrapperButton"
  
  static let saveButton = "\(PalindromeView.identifier)\\saveButton"
}

public final class PalindromeView: UIView {
  
  // MARK: Properties
  
  public let titleLabel = UILabel()
  
  public let tableView = UITableView()
  
  public let subtitleLabel = UILabel()
  
  public let textField = UITextField()
  
  public let imageView = UIImageView()
  
  public let wrapperButton = UIView()
  
  public let saveButton = UIButton()
  
  // MARK: Style
  
  private var titleLabelStyle: (_ view: UILabel) -> Void {
    autoLayout(in: self)
      <> { $0.accessibilityIdentifier = .titleLabel }
      <> baseLabelStyle(font: .titleLabel, color: .black)
      <> titleLabelConstraints
  }
  
  private var subtitleLabelStyle: (_ view: UILabel) -> Void {
    autoLayout(in: self)
      <> { $0.accessibilityIdentifier = .subtitleLabel }
      <> baseLabelStyle(font: .subtitleLabel, textAlignment: .natural, color: .black)
      <> subtitleLabelConstraints
  }
  
  private var tableViewStyle: (_ view: UITableView) -> Void {
    autoLayout(in: self)
      <> { $0.accessibilityIdentifier = .tableView }
      <> tableViewConstraints
  }
  
  private var textFieldStyle: (_ view: UITextField) -> Void {
    autoLayout(in: self)
      <> { (view: UITextField) in
        view.returnKeyType = .done
        view.accessibilityIdentifier = .textField
        view.borderStyle = .roundedRect
        view.clearButtonMode = .always
      }
      <> roundedStyle(radius: .radius_8)
      <> borderStyle(borderColor: .black, borderWidth: .border_1)
      <> textFieldConstraints
  }

  private var imageViewStyle: (_ view: UIImageView) -> Void {
    autoLayout(in: self)
      <> { (view: UIImageView) in
        view.image = .check
        view.accessibilityIdentifier = .imageView
      }
      <> imageViewConstraints
  }
  
  private var wrapperStyle: (_ view: UIView) -> Void {
    autoLayout(in: self)
      <> roundedStyle(radius: .radius_8)
      <> fill(backgroundColor: .backgroundButton, tintColor: .tintButton)
      <> wrapperConstraints
  }
  
  private var buttonStyle: (_ view: UIButton) -> Void {
    autoLayout(in: self)
      <> { $0.accessibilityIdentifier = .wrapperButton }
      <> baseButtonStyle(edge: .buttonMargin, font: .button)
      <> buttonConstraints
  }
  
  // MARK: LifeCycle
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    setupViews()
  }
  
  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setupViews() {
    self.backgroundColor = .white
    titleLabel |> titleLabelStyle
    textField |> textFieldStyle
    imageView |> imageViewStyle
    wrapperButton |> wrapperStyle
    saveButton |> buttonStyle
    
    subtitleLabel |> subtitleLabelStyle
    tableView |> tableViewStyle
  }

  // MARK: Constraints
  
  private func titleLabelConstraints(_ view: UILabel) {
    constraint(
      item: view,
      attribute: .top,
      toItem: safeAreaLayoutGuide,
      constant: .spacing_8
    )
    constraint(item: view, attribute: .centerX, toItem: self)
    leadingAndTrailingConstraint(
      item: view,
      toItem: self,
      leftEdgeBy: .greaterThanOrEqual,
      leftPadding: .spacing_20
    )
  }

  private func subtitleLabelConstraints(_ view: UILabel) {
    constraint(
      item: view,
      attribute: .top,
      toItem: saveButton,
      attribute: .bottom,
      constant: .spacing_20
    )
    constraint(item: view, attribute: .centerX, toItem: self)
    leadingAndTrailingConstraint(
      item: view,
      toItem: self,
      rightEdgeBy: .greaterThanOrEqual,
      leftPadding: .spacing_20
    )
  }

  private func textFieldConstraints(_ view: UITextField) {
    recomendedSize()(view)
    constraint(
      item: view,
      attribute: .top,
      toItem: titleLabel,
      attribute: .bottom,
      constant: .spacing_8
    )
    leadingAndTrailingConstraint(
      item: view,
      toItem: self,
      rightEdgeBy: .greaterThanOrEqual,
      leftPadding: .spacing_20
    )
  }
  
  private func imageViewConstraints(_ view: UIImageView) {
    constraint(
      item: view,
      attribute: .centerY,
      toItem: textField
    )
    constraint(
      item: view,
      attribute: .leading,
      toItem: textField,
      attribute: .trailing,
      constant: .spacing_8
    )
    constraint(
      item: self,
      attribute: .trailing,
      toItem: view,
      constant: .spacing_20
    )
    constraint(
      item: view,
      attribute: .height,
      constant: .size_40
    )
    constraint(
      item: view,
      attribute: .width,
      constant: .size_40
    )
  }
  
  private func wrapperConstraints(_ view: UIView) {
    constraint(
      item: view,
      attribute: .top,
      toItem: textField,
      attribute: .bottom,
      constant: .spacing_8
    )
    constraint(item: view, attribute: .centerX, toItem: self)
    leadingAndTrailingConstraint(
      item: view,
      toItem: self,
      leftEdgeBy: .greaterThanOrEqual,
      leftPadding: .spacing_20
    )
    constraint(
      item: view,
      attribute: .height,
      relatedBy: .greaterThanOrEqual,
      constant: .size_24
    )
  }

  private func buttonConstraints(_ view: UIButton) {
    recomendedSize()(view)
    wrapView(padding: .buttonPadding)(wrapperButton)(view)
  }
  
  private func tableViewConstraints(_ view: UITableView) {
    constraint(
      item: view,
      attribute: .top,
      toItem: subtitleLabel,
      attribute: .bottom,
      constant: .spacing_8
    )
    leadingAndTrailingConstraint(
      item: view,
      toItem: self
    )
    constraint(
      item: self,
      attribute: .bottom,
      toItem: view,
      constant: .spacing_20
    )
  }
}
