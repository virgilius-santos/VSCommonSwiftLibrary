
import SwiftUI
import Combine
import Foundation

public struct AsyncImage<Placeholder: View>: View {
    
    private class ImageLoader: ObservableObject {
        @Published var image: KImage?
        private let url: URL
        private var cancellable: AnyCancellable?

        init(url: URL) {
            self.url = url
        }

        deinit {
            cancel()
        }
        
        func load() {
            cancellable = URLSession.shared.dataTaskPublisher(for: url)
                .map { KImage(data: $0.data) }
                .replaceError(with: nil)
                .receive(on: DispatchQueue.main)
                .sink { [weak self] in self?.image = $0 }
        }
        
        func cancel() {
            cancellable?.cancel()
        }
    }
    
    @ViewBuilder
    public var body: some View {
        if let image = loader.image {
            Image(kImage: image)
                .resizable()
                .onAppear(perform: loader.load)
        } else {
            placeholder()
                .onAppear(perform: loader.load)
        }
    }
    
    @StateObject private var loader: ImageLoader
    
    private let placeholder: () -> Placeholder

    public init(url: URL, @ViewBuilder placeholder: @escaping () -> Placeholder) {
        self.placeholder = placeholder
        _loader = StateObject(wrappedValue: ImageLoader(url: url))
    }
}
