import SwiftUI

public struct MessageCard: View {
  let message: String
  let width: CGFloat?
  let style: MessageCard.Style
  
  public var body: some View {
    Text(message)
      .foregroundColor(.white)
      .padding(10)
      .background(style.backgroundColor)
      .setRadius(style: style)
      .setBubble(style: style)
      .frame(minWidth: .zero, maxWidth: width, alignment: style.alignment)
  }
  
  public init(
    message: String,
    width: CGFloat?,
    style: MessageCard.Style
  ) {
    self.message = message
    self.width = width
    self.style = style
  }
}

private extension View {
  @ViewBuilder
  func setRadius(style: MessageCard.Style) -> some View {
    if let radius = style.radius {
      self.cornerRadius(radius)
    } else {
      self
    }
  }
  
  @ViewBuilder
  func setBubble(style: MessageCard.Style) -> some View {
    if let leftShape = style.leftShape {
      self.clipShape(leftShape)
    } else {
      self
    }
  }
}

public extension MessageCard {
  struct Style {
    let alignment: Alignment
    let backgroundColor: Color
    let leftShape: LeftBubbleShape?
    let radius: CGFloat?
  }
}

public extension MessageCard.Style {
  static let leftCard = MessageCard.Style(
    alignment: .leading,
    backgroundColor: .primary.opacity(0.2),
    leftShape: LeftBubbleShape(),
    radius: nil
  )
  
  static let rightCard = MessageCard.Style(
    alignment: .trailing,
    backgroundColor: .blue,
    leftShape: nil,
    radius: .radius_10
  )
}

struct LeftBubbleShape: Shape {
  func path(in rect: CGRect) -> Path {
    .init { path in
      
      let pt1 = CGPoint(x: 0, y: 0)
      let pt2 = CGPoint(x: rect.width, y: 0)
      let pt3 = CGPoint(x: rect.width, y: rect.height)
      let pt4 = CGPoint(x: 0, y: rect.height)
      
      path.move(to: pt4)
      path.addArc(tangent1End: pt4, tangent2End: pt1, radius: 15)
      path.addArc(tangent1End: pt1, tangent2End: pt2, radius: 15)
      path.addArc(tangent1End: pt2, tangent2End: pt3, radius: 15)
      path.addArc(tangent1End: pt3, tangent2End: pt4, radius: 15)
    }
  }
}
