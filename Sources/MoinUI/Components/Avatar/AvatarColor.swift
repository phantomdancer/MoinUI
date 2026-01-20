import SwiftUI

public extension Moin {
    /// Avatar 颜色
    enum AvatarColor: Hashable, PresetColorConvertible {
        case custom(SwiftUI.Color)
        
        // MARK: - Properties
        
        public var color: SwiftUI.Color {
             switch self {
             case .custom(let c): return c
             }
         }
    }
}
