import SwiftUI

#if os(iOS)
public func image(from name: String, in bundle: Bundle?) -> Image {
  Image(uiImage: UIImage(named: name, in: bundle, compatibleWith: nil)!)
    .renderingMode(.original)
}
#endif
