import SwiftUI

#if os(OSX)
public struct BlurView: NSViewRepresentable {
  public func makeNSView(context: Context) -> NSVisualEffectView {
    
    let view = NSVisualEffectView()
    view.blendingMode = .behindWindow
    
    return view
  }
  
  public func updateNSView(_ nsView: NSVisualEffectView, context: Context) {}
  
  public init() {}
}
#endif
