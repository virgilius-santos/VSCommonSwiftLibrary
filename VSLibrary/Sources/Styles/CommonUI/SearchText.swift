import SwiftUI

public struct SearchText: View {
  public let title: String
  @Binding var searchText: String
  
  public var body: some View {
    HStack {
      
      Image(systemName: "magnifyingglass")
        .foregroundColor(Color.gray)
      
      TextField(title, text: $searchText)
        .textFieldStyle(.plain)
    }
    .padding(.vertical, 8)
    .padding(.horizontal)
    .background(Color.primary.opacity(0.15))
    .cornerRadius(.radius_10)
    .padding()
  }
  
  public init(
    title: String = "Search",
    searchText: Binding<String>
  ) {
    self.title = title
    _searchText = searchText
  }
}
