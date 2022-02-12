import SwiftUI

struct IconButton: View {
  var action: () -> Void
  var iconName: String
  var foregroundColor: Color?
  
  var body: some View {
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
}

struct LabelIconButton: View {
  var action: () -> Void
  var iconName: String
  var label: String
  
  var body: some View {
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
}
