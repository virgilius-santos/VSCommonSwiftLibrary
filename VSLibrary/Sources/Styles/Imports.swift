import Foundation
import SwiftUI

#if os(OSX)
import Cocoa
public typealias KImage = NSImage
public typealias KViewRepresentable = NSViewRepresentable

public extension Image {
    init(kImage: KImage) {
        self.init(nsImage: kImage)
    }
}
#elseif os(iOS)
import UIKit
public typealias KImage = UIImage
public typealias KViewRepresentable = UIViewRepresentable

public extension Image {
    init(kImage: KImage) {
        self.init(uiImage: kImage)
    }
}
#endif
