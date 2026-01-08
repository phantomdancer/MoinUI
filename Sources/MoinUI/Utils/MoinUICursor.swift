import SwiftUI
import AppKit

/// Cursor modifier using onContinuousHover (macOS 13+)
/// Reference: https://gist.github.com/Amzd/cb8ba40625aeb6a015101d357acaad88
public extension View {
    /// Set cursor style for view
    func moinUICursor(_ cursor: NSCursor) -> some View {
        self.onContinuousHover { phase in
            switch phase {
            case .active:
                guard NSCursor.current != cursor else { return }
                cursor.push()
            case .ended:
                NSCursor.pop()
            }
        }
    }
}
