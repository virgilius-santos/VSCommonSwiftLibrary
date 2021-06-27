
import SwiftUI

public extension NavigationLink where Label == EmptyView {
    static func lazy(destination: Destination, isActive: Binding<Bool>) -> NavigationLink<Label, NavigationLazyView<Destination>> {
        .init(destination: NavigationLazyView(destination), isActive: isActive, label: { EmptyView() })
    }
    
    static func lazy(destination: @autoclosure @escaping () -> Destination, isActive: Binding<Bool>) -> NavigationLink<Label, NavigationLazyView<Destination>> {
        .init(destination: NavigationLazyView(destination()), isActive: isActive, label: { EmptyView() })
    }
    
    static func lazy(destination: Destination) -> NavigationLink<Label, NavigationLazyView<Destination>> {
        .init(destination: NavigationLazyView(destination), label: { EmptyView() })
    }
    
    static func lazy<H: Hashable>(destination: Destination, tag: H, selection: Binding<H?>) -> NavigationLink<Label, NavigationLazyView<Destination>> {
        .init(destination: NavigationLazyView(destination), tag: tag, selection: selection, label: { EmptyView() })
    }
}

public struct NavigationLazyView<Content: View>: View {
    let build: () -> Content
    
    public var body: Content {
        build()
    }
    
    public init(_ build: @autoclosure @escaping () -> Content) {
        self.build = build
    }
}
