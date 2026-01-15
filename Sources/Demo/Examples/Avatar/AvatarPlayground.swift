import SwiftUI
import MoinUI

struct AvatarPlayground: View {
    @EnvironmentObject var config: Moin.ConfigProvider
    @State private var size: AvatarSize = .default
    @State private var shape: AvatarShape = .circle
    
    var body: some View {
        VStack(spacing: 20) {
            // Preview
            VStack(spacing: 40) {
                Moin.Avatar(icon: "person", size: size, shape: shape)
                
                Moin.Avatar("User", size: size, shape: shape, backgroundColor: .blue)
                
                Moin.AvatarGroup(maxCount: 3, size: size, shape: shape) {
                    Moin.Avatar(icon: "person")
                    Moin.Avatar("A")
                    Moin.Avatar("B")
                    Moin.Avatar("C")
                    Moin.Avatar("D")
                }
            }
            .padding(40)
            .background(Color.gray.opacity(0.1))
            .cornerRadius(12)
            
            Divider()
            
            // Controls
            Form {
                Section("Settings") {
                    Picker("Shape", selection: $shape) {
                        Text("Circle").tag(AvatarShape.circle)
                        Text("Square").tag(AvatarShape.square)
                    }
                    
                    Picker("Size", selection: $size) {
                        Text("Large").tag(AvatarSize.large)
                        Text("Default").tag(AvatarSize.default)
                        Text("Small").tag(AvatarSize.small)
                    }
                }
            }
        }
        .padding()
        .navigationTitle("Avatar Playground")
    }
}

// Make AvatarSize Hashable for Picker
extension AvatarSize: Hashable {
    public static func == (lhs: AvatarSize, rhs: AvatarSize) -> Bool {
        switch (lhs, rhs) {
        case (.large, .large), (.default, .default), (.small, .small): return true
        case (.custom(let a), .custom(let b)): return a == b
        default: return false
        }
    }
    
    public func hash(into hasher: inout Hasher) {
        switch self {
        case .large: hasher.combine(0)
        case .default: hasher.combine(1)
        case .small: hasher.combine(2)
        case .custom(let v): hasher.combine(v)
        }
    }
}
