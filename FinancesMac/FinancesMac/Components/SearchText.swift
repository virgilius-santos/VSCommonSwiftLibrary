import SwiftUI

struct SearchText: View {
    @Binding var searchText: String
    
    var body: some View {
        HStack {
            
            Image(systemName: "magnifyingglass")
                .foregroundColor(Color.gray)
            
            TextField("Search", text: $searchText)
                .textFieldStyle(.plain)
        }
        .padding(.vertical, 8)
        .padding(.horizontal)
        .background(Color.primary.opacity(0.15))
        .cornerRadius(10)
        .padding()
    }
    
    init(searchText: Binding<String>) {
        _searchText = searchText
    }
}
