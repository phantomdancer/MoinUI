import SwiftUI

// MARK: - _RibbonPlacement (internal name, use Moin.Badge.RibbonPlacement)

/// 缎带位置
public enum _RibbonPlacement: Sendable {
    case start
    case end

    var alignment: Alignment {
        switch self {
        case .start: return .topLeading
        case .end: return .topTrailing
        }
    }
}

// MARK: - _BadgeRibbon (internal name, use Moin.Badge.Ribbon)

/// 缎带徽标 - 用于在元素角落悬挂缎带
public struct _BadgeRibbon<Content: View>: View {
    @Environment(\.moinToken) private var token
    @Environment(\.moinBadgeToken) private var badgeToken

    private let content: Content
    private let text: String?
    private let color: _BadgeColor
    private let placement: _RibbonPlacement

    public init(
        text: String? = nil,
        color: _BadgeColor = .processing,
        placement: _RibbonPlacement = .end,
        @ViewBuilder content: () -> Content
    ) {
        self.content = content()
        self.text = text
        self.color = color
        self.placement = placement
    }

    public var body: some View {
        content
            .overlay(alignment: placement.alignment) {
                if let text = text, !text.isEmpty {
                    ribbonView(text: text)
                        .padding(.top, 8) // marginXS
                        .offset(x: placement == .end ? 8 : -8) // Push out
                }
            }
    }

    private var ribbonViewColor: SwiftUI.Color {
        switch color {
        case .default: return badgeToken.badgeColor
        case .success: return token.colorSuccess
        case .processing: return token.colorPrimary
        case .warning: return token.colorWarning
        case .error: return token.colorDanger
        case .custom(let c): return c
        }
    }

    private func ribbonView(text: String) -> some View {
        ZStack(alignment: placement == .end ? .bottomTrailing : .bottomLeading) {
            // Corner (Fold)
            RibbonCorner(placement: placement)
                .fill(ribbonViewColor)
                .brightness(-0.2) // Darker shade for fold
                .frame(width: 8, height: 8)
                .offset(y: 8) // Place below ribbon

            // Main Ribbon Body
            Text(text)
                .font(.system(size: badgeToken.textFontSize))
                .foregroundStyle(badgeToken.textColor)
                .padding(.horizontal, 8)
                .frame(height: 22)
                .background(ribbonViewColor)
                .clipShape(
                    UnevenRoundedRectangle(
                        topLeadingRadius: token.borderRadiusSM,
                        bottomLeadingRadius: placement == .end ? token.borderRadiusSM : 0,
                        bottomTrailingRadius: placement == .start ? token.borderRadiusSM : 0,
                        topTrailingRadius: token.borderRadiusSM
                    )
                )
        }
        .fixedSize()
    }
}

// MARK: - Helper Shapes

private struct RibbonCorner: Shape {
    let placement: _RibbonPlacement

    func path(in rect: CGRect) -> Path {
        var path = Path()
        if placement == .end {
            // Top-Left Triangle
            path.move(to: CGPoint(x: 0, y: 0))
            path.addLine(to: CGPoint(x: rect.width, y: 0))
            path.addLine(to: CGPoint(x: 0, y: rect.height))
        } else {
            // Top-Right Triangle
            path.move(to: CGPoint(x: 0, y: 0))
            path.addLine(to: CGPoint(x: rect.width, y: 0))
            path.addLine(to: CGPoint(x: rect.width, y: rect.height))
        }
        path.closeSubpath()
        return path
    }
}


