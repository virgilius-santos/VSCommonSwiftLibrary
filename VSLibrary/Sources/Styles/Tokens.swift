
import SwiftUI

public extension Color {
  static let offWhite = Color(red: 225/255, green: 225/255, blue: 235/255)
  static let darkStart = Color(red: 50 / 255, green: 60 / 255, blue: 65 / 255)
  static let darkEnd = Color(red: 25 / 255, green: 25 / 255, blue: 30 / 255)
  
  static let lightStart = Color(red: 60 / 255, green: 160 / 255, blue: 240 / 255)
  static let lightEnd = Color(red: 30 / 255, green: 80 / 255, blue: 120 / 255)
}

public extension CGFloat {
  static let radius_4: CGFloat = 4
  static let radius_10: CGFloat = 10
  static let radius_16: CGFloat = 16
  static let radius_25: CGFloat = 25
  
  static let lineWidth_1: CGFloat = 1
  static let lineWidth_2: CGFloat = 2
  static let lineWidth_4: CGFloat = 4
  static let lineWidth_8: CGFloat = 8
  
  static let minClickableWidth: CGFloat = 44
  static let minClickableHeight: CGFloat = 44
  
  
  static let spacing_10: CGFloat = 10
}

public extension Double {
  static let opacity_20: Double = 0.2
  static let opacity_70: Double = 0.7
}

public struct ShadowStyle {
  public static let blackLight = ShadowStyle(
    color: Color.black.opacity(.opacity_20),
    radius: .radius_10,
    x: 10,
    y: 10
  )
  
  public static let whiteDark = ShadowStyle(
    color: Color.white.opacity(.opacity_70),
    radius: .radius_10,
    x: -5,
    y: -5
  )
  
  public static let darkStart = ShadowStyle(
    color: Color.darkStart,
    radius: .radius_10,
    x: -10,
    y: -10
  )
  
  public static let darkEnd = ShadowStyle(
    color: Color.darkEnd,
    radius: .radius_10,
    x: 10,
    y: 10
  )
  
  public static let darkStartHighlighted = ShadowStyle(
    color: Color.darkStart,
    radius: .radius_10,
    x: 5,
    y: 5
  )
  
  public static let darkEndHighlighted = ShadowStyle(
    color: Color.darkEnd,
    radius: .radius_10,
    x: -5,
    y: -5
  )
  
  var color: Color
  var radius: CGFloat
  var x: CGFloat
  var y: CGFloat
}

public extension View {
  func shadow(style: ShadowStyle) -> some View {
    shadow(color: style.color, radius: style.radius, x: style.x, y: style.y)
  }
}
