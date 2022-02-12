import SwiftUI

struct ExpandView: View {
  
  var recentMsg: RecentMessage
  
  @State private var selection: String = "Media"
  
  var body: some View {
    HStack(spacing: 0) {
      
      Divider()
      
      VStack(spacing: 25) {
        
        ProfileView(
          image: recentMsg.userImage,
          size: .init(width: 90, height: 90)
        )
          .padding(.top, 35)
        
        Text(recentMsg.userName)
          .font(.title)
          .fontWeight(.bold)
        
        HStack {
          
          LabelIconButton(
            action: { },
            iconName: "bell.slash",
            label: "Mute"
          )
          
          Spacer()
          
          LabelIconButton(
            action: { },
            iconName: "hand.raised.fill",
            label: "Block"
          )
          
          Spacer()
          
          LabelIconButton(
            action: { },
            iconName: "exclamationmark.triangle",
            label: "Report"
          )
        }
        .foregroundColor(.gray)
        
        Picker(
          selection: $selection,
          label: Text("Picker"),
          content: {
            Text("Media")
              .tag("Media")
            Text("Links")
              .tag("Links")
            Text("Audio")
              .tag("Audio")
            Text("Files")
              .tag("Files")
          })
          .pickerStyle(.segmented)
          .labelsHidden()
          .padding(.vertical)
        
        
        ScrollView {
          
          if selection == "Media" {
            
            LazyVGrid(
              columns: .init(
                repeating: .init(.flexible(), spacing: 10),
                count: 3),
              spacing: 10,
              content: {
                
                ForEach(1...8, id: \.self) { index in
                  Image("media\(index)")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 80, height: 80)
                    .cornerRadius(3)
                }
              })
          } else {
            Text(selection)
          }
        }
        
      }
      .padding(.horizontal)
      .frame(maxWidth: 300)
    }
  }
}
