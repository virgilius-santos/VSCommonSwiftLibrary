

import SwiftUI

@available(iOS 13.0.0, *)
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

@available(iOS 13.0.0, *)
extension Image {
    
}

@available(iOS 13.0.0, *)
public func imageStyle(size: CGFloat, _ view: Image) -> some View {
    view.renderingMode(.original)
        .resizable()
        .aspectRatio(contentMode: .fit)
        .frame(width: size, height: size)
}



@available(iOS 13.0, *)
public extension LinearGradient {
    init(_ colors: Color..., startPoint: UnitPoint = .topLeading, endPoint: UnitPoint = .bottomTrailing) {
        self.init(gradient: Gradient(colors: colors), startPoint: startPoint, endPoint: endPoint)
    }
}
