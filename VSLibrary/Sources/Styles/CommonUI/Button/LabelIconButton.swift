import SwiftUI

public struct LabelIconButton: View {
  var action: () -> Void
  var iconName: String
  var label: String
  
  public var body: some View {
    Button(
      action: action,
      label: {
        VStack {
          Image(systemName: iconName)
            .font(.title2)
            .foregroundColor(Color.white)
          
          Text(label)
        }
        .frame(minWidth: 44, minHeight: 44)
        .contentShape(Rectangle())
      }
    )
      .buttonStyle(.plain)
  }
  
  public init(action: @escaping () -> Void, iconName: String, label: String) {
    self.action = action
    self.iconName = iconName
    self.label = label
  }
}
