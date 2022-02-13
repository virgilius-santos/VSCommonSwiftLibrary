
import SwiftUI
import Styles

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

public var animationsView: some View {
  ContentView()
}

struct ContentView: View {
    
    @State private var animationAmount: CGFloat = 1
    @State private var enable = false
    @State private var dragAmount = CGSize.zero
    @State private var isShowingRed = false
    
    let letters = Array("Hello SwiftUI")
    
    var body: some View {
        VStack {
            Button("Tap Me") {
                withAnimation(.easeInOut(duration: 1.0)) {
                    isShowingRed.toggle()
                }
            }
            
            if isShowingRed {
                Color.red
                    .frame(width: 200, height: 200)
                    .transition(.pivot)
            }
        }
    }
}

struct CornerRotateModifier: ViewModifier {
    let amount: Double
    let anchor: UnitPoint

    func body(content: Content) -> some View {
        content.rotationEffect(.degrees(amount), anchor: anchor).clipped()
    }
}

extension AnyTransition {
    static var pivot: AnyTransition {
        .modifier(
            active: CornerRotateModifier(amount: -90, anchor: .topLeading),
            identity: CornerRotateModifier(amount: 0, anchor: .topLeading)
        )
    }
}

extension ContentView {
    var hidden_03: some View {
        VStack {
            Button("Tap Me") {
                withAnimation(.easeInOut(duration: 1.0)) {
                    isShowingRed.toggle()
                }
            }
            
            if isShowingRed {
                Color.red
                    .frame(width: 200, height: 200)
                    .transition(AnyTransition.asymmetric(insertion: .opacity, removal: .scale).animation(.easeInOut(duration: 1.0)))
            }
        }
    }
    
    var hidden_02: some View {
        VStack {
            Button("Tap Me") {
                withAnimation(.easeInOut(duration: 1.0)) {
                    isShowingRed.toggle()
                }
            }
            
            if isShowingRed {
                Rectangle()
                    .fill(Color.red)
                    .frame(width: 200, height: 200)
                    .transition(AnyTransition.scale.animation(.easeInOut(duration: 1.0)))
            }
        }
    }
    
    var hidden_01: some View {
        VStack {
            Button("Tap Me") {
                isShowingRed.toggle()
            }
            
            if isShowingRed {
                Color.red
                    .frame(width: 200, height: 200)
            }
        }
    }
    
    var move_04: some View {
        HStack(spacing: 0) {
            ForEach(0..<letters.count) { num in
                Text(String(letters[num]))
                    .padding(5)
                    .font(.title)
                    .background(enable ? Color.blue : Color.red)
                    .offset(dragAmount)
                    .animation(Animation.default.delay(Double(num) / 20))
            }
        }
        .gesture(
            DragGesture()
                .onChanged { dragAmount = $0.translation }
                .onEnded { _ in
                    dragAmount = .zero
                    enable.toggle()
                }
        )
    }
    
    var move_03: some View {
        LinearGradient.init(.yellow, .red)
            .frame(width: 300, height: 200)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .offset(dragAmount)
            .gesture(
                DragGesture()
                    .onChanged { dragAmount = $0.translation }
                    .onEnded { _ in
                        withAnimation(.spring()) {
                            dragAmount = .zero
                        }
                    }
            )
    }
    
    var move_02: some View {
        LinearGradient.init(.yellow, .red)
            .frame(width: 300, height: 200)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .offset(dragAmount)
            .gesture(
                DragGesture()
                    .onChanged { dragAmount = $0.translation }
                    .onEnded { _ in dragAmount = .zero }
            )
            .animation(.spring())
    }
    
    var move_01: some View {
        LinearGradient.init(.yellow, .red)
            .frame(width: 300, height: 200)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .offset(dragAmount)
            .gesture(
                DragGesture()
                    .onChanged { dragAmount = $0.translation }
                    .onEnded { _ in dragAmount = .zero }
            )
    }
    
    var simpleButton_14: some View {
        Button("Tap Me") {
            enable.toggle()
        }
        .frame(width: 200, height: 200)
        .background(enable ? Color.blue : .red)
        .foregroundColor(.white)
        .animation(.default)
        .clipShape(RoundedRectangle(cornerRadius: enable ? 60 : 0))
        .animation(.interpolatingSpring(stiffness: 10, damping: 1))
    }
    
    var simpleButton_13: some View {
        Button("Tap Me") {
            enable.toggle()
        }
        .frame(width: 200, height: 200)
        .background(enable ? Color.blue : .red)
        .foregroundColor(.white)
        .animation(.default)
        .clipShape(RoundedRectangle(cornerRadius: enable ? 60 : 0))
    }
    
    var simpleButton_12: some View {
        Button("Tap Me") {
            withAnimation(.interpolatingSpring(stiffness: 5, damping: 1)) {
                animationAmount += 360
            }
        }
        .padding(40)
        .background(Color.red)
        .foregroundColor(.white)
        .clipShape(Circle())
        .rotation3DEffect(.degrees(Double(animationAmount)), axis: (x: 0, y: 1, z: 0))
    }
    
    var simpleButton_11: some View {
        Button("Tap Me") {
            withAnimation {
                animationAmount += 360
            }
        }
        .padding(40)
        .background(Color.red)
        .foregroundColor(.white)
        .clipShape(Circle())
        .rotation3DEffect(.degrees(Double(animationAmount)), axis: (x: 0, y: 1, z: 0))
    }
    
    var simpleButton_10: some View {
        print(animationAmount)
        
        return VStack {
            Stepper("Scale amount", value: $animationAmount.animation(
                Animation.easeInOut(duration: 1)
                    .repeatCount(3, autoreverses: true)
            ), in: 1...10)
            
            Spacer()
            
            Button("Tap Me") {
                self.animationAmount += 1
            }
            .padding(40)
            .background(Color.red)
            .foregroundColor(.white)
            .clipShape(Circle())
            .scaleEffect(animationAmount)
        }
        .padding()
    }
    
    var simpleButton_09: some View {
        print(animationAmount)
        
        return VStack {
            Stepper("Scale amount", value: $animationAmount.animation(), in: 1...10)
            
            Spacer()
            
            Button("Tap Me") {
                self.animationAmount += 1
            }
            .padding(40)
            .background(Color.red)
            .foregroundColor(.white)
            .clipShape(Circle())
            .scaleEffect(animationAmount)
        }
        .padding()
    }
    
    var simpleButton_08: some View {
        Button("Tap me") {
            animationAmount += 1
        }
        .padding(50)
        .background(Color.red)
        .foregroundColor(.white)
        .clipShape(Circle())
        .overlay(
            Circle()
                .stroke(Color.red)
                .scaleEffect(animationAmount)
                .opacity(Double(2 - animationAmount))
                .animation(
                    Animation.easeInOut(duration: 1)
                        .repeatForever(autoreverses: false)
                )
        )
        .onAppear {
            animationAmount = 2
        }
    }
    
    var simpleButton_07: some View {
        Button("Tap me") {
            animationAmount += 1
        }
        .padding(50)
        .background(Color.red)
        .foregroundColor(.white)
        .clipShape(Circle())
        .scaleEffect(animationAmount)
        .animation(
            Animation.easeInOut(duration: 1)
                .repeatCount(3, autoreverses: true)
        )
    }
    
    var simpleButton_06: some View {
        Button("Tap me") {
            animationAmount += 1
        }
        .padding(50)
        .background(Color.red)
        .foregroundColor(.white)
        .clipShape(Circle())
        .scaleEffect(animationAmount)
        .animation(
            Animation.easeInOut(duration: 2)
                .delay(1)
        )
    }
    
    var simpleButton_05: some View {
        Button("Tap me") {
            animationAmount += 1
        }
        .padding(50)
        .background(Color.red)
        .foregroundColor(.white)
        .clipShape(Circle())
        .scaleEffect(animationAmount)
        .animation(.easeInOut(duration: 2))
    }
    
    var simpleButton_04: some View {
        Button("Tap me") {
            animationAmount += 1
        }
        .padding(50)
        .background(Color.red)
        .foregroundColor(.white)
        .clipShape(Circle())
        .scaleEffect(animationAmount)
        .animation(.interpolatingSpring(stiffness: 50, damping: 1))
    }
    
    var simpleButton_03: some View {
        Button("Tap me") {
            animationAmount += 1
        }
        .padding(50)
        .background(Color.red)
        .foregroundColor(.white)
        .clipShape(Circle())
        .scaleEffect(animationAmount)
        .animation(.easeOut)
    }
    
    var simpleButton_02: some View {
        Button("Tap me") {
            animationAmount += 1
        }
        .padding(50)
        .background(Color.red)
        .foregroundColor(.white)
        .clipShape(Circle())
        .scaleEffect(animationAmount)
        .blur(radius: (animationAmount - 1) * 3)
        .animation(.default)
    }
    
    var simpleButton_01: some View {
        Button("Tap me") {
            animationAmount += 1
        }
        .padding(50)
        .background(Color.red)
        .foregroundColor(.white)
        .clipShape(Circle())
        .scaleEffect(animationAmount)
        .animation(.default)
    }
}
