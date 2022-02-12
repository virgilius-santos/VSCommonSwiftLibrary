

import SwiftUI

public extension Text {
  func baseStyle(
    size: CGFloat,
    weight: Font.Weight = .medium,
    color: Color = .white
  ) -> some View {
    font(.system(size: size, weight: weight, design: .rounded))
      .foregroundColor(color)
      .padding()
  }
}

public extension Image {
  func imageStyle(size: CGFloat) -> some View {
    renderingMode(.original)
      .resizable()
      .aspectRatio(contentMode: .fit)
      .frame(width: size, height: size)
  }
  
  func capsuleStyle() -> some View {
    modifier(CapsuleImageStyle())
  }
}

struct CapsuleImageStyle: ViewModifier {
  func body(content: Content) -> some View {
    content
      .clipShape(Capsule())
      .overlay(Capsule().stroke(Color.black, lineWidth: .lineWidth_1))
      .shadow(color: .black, radius: .radius_4)
  }
}

public extension LinearGradient {
  init(_ colors: Color..., startPoint: UnitPoint = .topLeading, endPoint: UnitPoint = .bottomTrailing) {
    self.init(gradient: Gradient(colors: colors), startPoint: startPoint, endPoint: endPoint)
  }
}

