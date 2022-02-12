import SwiftUI

public struct TabButton: View {
  var image: String
  var title: String
  var selectedTab: Binding<String>?
  
  public var body: some View {
    
    let isSelectedTab = selectedTab?.wrappedValue == title
    
    Button(
      action: {
        withAnimation { selectedTab?.wrappedValue = title }
      },
      label: {
        VStack(spacing: 7) {
          Image(systemName: image)
            .font(.system(size: 16, weight: .bold))
            .foregroundColor(isSelectedTab ? .white : .gray)
          
          Text(title)
            .fontWeight(.bold)
            .font(.system(size: 11))
            .foregroundColor(isSelectedTab ? .white : .gray)
        }
        .padding(.vertical, 8)
        .frame(width: 70)
        .contentShape(Rectangle())
        .background(Color.primary.opacity(isSelectedTab ? 0.15 : 0))
        .cornerRadius(10)
      }
    )
      .buttonStyle(.plain)
  }
  
  public init(image: String, title: String, selectedTab: Binding<String>?) {
    self.image = image
    self.title = title
    self.selectedTab = selectedTab
  }
}
