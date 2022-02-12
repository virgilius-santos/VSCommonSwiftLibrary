import SwiftUI

struct MessageCardRounded: View {
    var message: String
    var width: CGFloat?
    var alignment: Alignment = .center
    var backgroundColor: Color
    
    var body: some View {
        Text(message)
            .foregroundColor(.white)
            .padding(10)
            .background(Color.primary.opacity(0.2))
            .cornerRadius(10)
            .frame(minWidth: .zero, maxWidth: width, alignment: alignment)
    }
}

struct MessageCardBubbled: View {
    var message: String
    var width: CGFloat?
    var alignment: Alignment = .center
    var backgroundColor: Color
    
    var body: some View {
        Text(message)
            .foregroundColor(.white)
            .padding(10)
            .background(Color.primary.opacity(0.2))
            .clipShape(MessageBubble())
            .frame(minWidth: .zero, maxWidth: width, alignment: alignment)
    }
}

struct MessageBubble : Shape {
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
