import SwiftUI

public struct ProfileView: View {
  var image: String
  var style: Style = .small
  
  public var body: some View {
    Image.init(image)
      .resizable()
      .aspectRatio(contentMode: .fill)
      .frame(width: style.width, height: style.height)
      .clipShape(Circle())
  }
  
  public init(
    image: String,
    style: ProfileView.Style = .small
  ) {
    self.image = image
    self.style = style
  }
}

public extension ProfileView {
  struct Style {
    let width: CGFloat
    let height: CGFloat
  }
}

public extension ProfileView.Style {
  static let xSmall = Self(width: 35, height: 35)
  static let small = Self(width: 40, height: 40)
  static let xxLarge = Self(width: 90, height: 90)
}
