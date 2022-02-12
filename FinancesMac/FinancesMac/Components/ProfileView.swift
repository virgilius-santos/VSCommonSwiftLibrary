import SwiftUI

struct ProfileView: View {
  var image: String
  var size: CGSize = .init(width: 40, height: 40)
  
  var body: some View {
    Image.init(image)
      .resizable()
      .aspectRatio(contentMode: .fill)
      .frame(width: size.width, height: size.height)
      .clipShape(Circle())
  }
}
