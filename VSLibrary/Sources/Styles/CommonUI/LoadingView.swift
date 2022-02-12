
import SwiftUI

#if os(iOS)

fileprivate let loadingText = "Loading"

public struct LoadingView<Content>: View where Content: View {
    
    @Binding var isShowing: Bool
    
    var content: () -> Content

    public var body: some View {
        GeometryReader { geometry in
            ZStack.init(alignment: .center) {
                self.content()
                    .disabled(self.isShowing)
                    .blur(radius: self.isShowing ? 3 : 0)
                
                if (self.isShowing) {
                    VStack {
                        Text("Loading ...")
                        LoadingIndicator(style: .large)
                    }
                    .frame(width: geometry.size.width / 3.0, height: geometry.size.height / 6.0)
                    .background(Color.secondary.colorInvert())
                    .foregroundColor(Color.primary)
                    .cornerRadius(20)
                    .opacity(self.isShowing ? 1 : 0)
                }
            }
        }
    }
    
    public init(isShowing: Binding<Bool>, content: @escaping () -> Content) {
        self._isShowing = isShowing
        self.content = content
    }
}

struct LoadingIndicator: KViewRepresentable {

    typealias UIViewType = UIActivityIndicatorView

    let style: UIActivityIndicatorView.Style

    func makeUIView(context: UIViewRepresentableContext<LoadingIndicator>) -> LoadingIndicator.UIViewType {
        return UIActivityIndicatorView(style: style)
    }

    func updateUIView(_ view: LoadingIndicator.UIViewType, context: UIViewRepresentableContext<LoadingIndicator>) {
        view.startAnimating()
    }
    
}
#endif
