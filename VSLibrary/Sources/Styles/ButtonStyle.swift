
import SwiftUI

@available(iOS 13.0, *)
public struct DarkBackground<S: Shape>: View {
    public var body: some View {
        ZStack {
            if isHighlighted {
                shape
                    .fill(LinearGradient(Color.darkEnd, Color.darkStart))
                    .overlay(shape.stroke(LinearGradient(Color.darkStart, Color.darkEnd), lineWidth: .lineWidth_4))
                    .shadow(style: .darkStartHighlighted)
                    .shadow(style: .darkEndHighlighted)
            } else {
                shape
                    .fill(LinearGradient(Color.darkStart, Color.darkEnd))
                    .overlay(shape.stroke(Color.darkEnd, lineWidth: .lineWidth_4))
                    .shadow(style: .darkStart)
                    .shadow(style: .darkEnd)
            }
        }
    }
    
    var isHighlighted: Bool
    var shape: S
    
    public init(isHighlighted: Bool, shape: S) {
        self.isHighlighted = isHighlighted
        self.shape = shape
    }
}

@available(iOS 13.0, *)
public struct DarkButtonStyle: ButtonStyle {
    public init() {}
    
    public func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .padding(10)
            .contentShape(Circle())
            .background(
                DarkBackground(isHighlighted: configuration.isPressed, shape: Circle())
            )
            .animation(nil)
    }
}

@available(iOS 13.0, *)
struct ColorfulBackground<S: Shape>: View {
    var isHighlighted: Bool
    var shape: S

    var body: some View {
        ZStack {
            if isHighlighted {
                shape
                    .fill(LinearGradient(Color.lightEnd, Color.lightStart))
                    .overlay(shape.stroke(LinearGradient(Color.lightStart, Color.lightEnd), lineWidth: .lineWidth_2))
                    .shadow(style: .darkStartHighlighted)
                    .shadow(style: .darkEndHighlighted)
            } else {
                shape
                    .fill(LinearGradient(Color.darkStart, Color.darkEnd))
                    .overlay(shape.stroke(LinearGradient(Color.lightStart, Color.lightEnd), lineWidth: .lineWidth_2))
                    .shadow(style: .darkStart)
                    .shadow(style: .darkEnd)
            }
        }
    }
}

@available(iOS 13.0, *)
struct ColorfulButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .padding(10)
            .contentShape(Circle())
            .background(
                ColorfulBackground(isHighlighted: configuration.isPressed, shape: Circle())
            )
            .animation(nil)
    }
}

@available(iOS 13.0, *)
public struct SimpleButtonStyle: ButtonStyle {
    public init() {}
    
    public func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .padding(10)
            .contentShape(Circle())
            .background(
                Group {
                    if configuration.isPressed {
                        Circle()
                            .fill(Color.offWhite)
                            .overlay(
                                Circle()
                                    .stroke(Color.gray, lineWidth: .lineWidth_4)
                                    .blur(radius: .radius_4)
                                    .offset(x: 2, y: 2)
                                    .mask(Circle().fill(LinearGradient(Color.black, Color.clear)))
                            )
                            .overlay(
                                Circle()
                                    .stroke(Color.white, lineWidth: 8)
                                    .blur(radius: 4)
                                    .offset(x: -2, y: -2)
                                    .mask(Circle().fill(LinearGradient(Color.clear, Color.black)))
                            )
                    } else {
                        Circle()
                            .fill(Color.offWhite)
                            .shadow(style: .blackLight)
                            .shadow(style: .whiteDark)
                    }
                }
            )
    }
}
