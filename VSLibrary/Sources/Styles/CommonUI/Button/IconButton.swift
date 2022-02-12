import SwiftUI

public struct IconButton: View {
  var action: () -> Void
  var iconName: String
  var foregroundColor: Color?
  
  public var body: some View {
    Button(
      action: action,
      label: {
        Image(systemName: iconName)
          .font(.title2)
          .foregroundColor(foregroundColor)
          .frame(minWidth: 44, minHeight: 44)
          .contentShape(Rectangle())
      }
    )
      .buttonStyle(.plain)
  }
  
  public init(action: @escaping () -> Void, iconName: String, foregroundColor: Color? = nil) {
    self.action = action
    self.iconName = iconName
    self.foregroundColor = foregroundColor
  }
}
