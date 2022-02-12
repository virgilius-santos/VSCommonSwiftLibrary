

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

public extension View {
    func roundedStyle(foregroundColor: Color, background: Color) -> some View {
        frame(width: 280, height: 50)
            .background(background)
            .cornerRadius(10)
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
            .overlay(Capsule().stroke(Color.black, lineWidth: 1))
            .shadow(color: .black, radius: 2)
    }
}

public extension LinearGradient {
    init(_ colors: Color..., startPoint: UnitPoint = .topLeading, endPoint: UnitPoint = .bottomTrailing) {
        self.init(gradient: Gradient(colors: colors), startPoint: startPoint, endPoint: endPoint)
    }
}

#if os(iOS)
public func image(from name: String, in bundle: Bundle?) -> Image {
    Image(uiImage: UIImage(named: name, in: bundle, compatibleWith: nil)!)
        .renderingMode(.original)
}
#endif

public extension View {
    func alert(isPresented: Binding<Bool>, message: AlertMessage) -> some View {
        alert(isPresented: isPresented) {
            Alert(title: Text(message.title), message: Text(message.message), dismissButton: .default(Text("OK")))
        }
    }
}

public struct AlertMessage {
    
    public var title = ""
    public var message = ""
    public var showing = false
    
    public init(title: String = "", message: String = "", showing: Bool = false) {
        self.title = title
        self.message = message
        self.showing = showing
    }
}
