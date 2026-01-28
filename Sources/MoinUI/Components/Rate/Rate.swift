// MARK: - Moin.Rate

import SwiftUI

// MARK: - Size Enum

public enum _RateSize: Equatable, ExpressibleByIntegerLiteral, ExpressibleByFloatLiteral {
    case small
    case medium
    case large
    case custom(CGFloat)

    public init(integerLiteral value: Int) {
        self = .custom(CGFloat(value))
    }

    public init(floatLiteral value: Double) {
        self = .custom(CGFloat(value))
    }

    func resolve(from token: Moin.RateToken) -> CGFloat {
        switch self {
        case .small: return token.starSizeSM
        case .medium: return token.starSize
        case .large: return token.starSizeLG
        case .custom(let v): return v
        }
    }
}

// MARK: - Rate Component

public struct _Rate<Character: View>: View {
    @Binding var value: Double
    let count: Int
    let allowHalf: Bool
    let allowClear: Bool
    let disabled: Bool
    let size: _RateSize
    let character: Character
    var onChange: ((Double) -> Void)?
    var onHoverChange: ((Double?) -> Void)?

    @Environment(\.moinRateToken) private var rateToken
    @Environment(\.moinToken) private var token
    @Environment(\.isEnabled) private var isEnabled

    @State private var hoverValue: Double? = nil
    @State private var hoveringIndex: Int? = nil

    public init(
        value: Binding<Double>,
        count: Int = 5,
        allowHalf: Bool = false,
        allowClear: Bool = true,
        disabled: Bool = false,
        size: _RateSize = .medium,
        @ViewBuilder character: () -> Character,
        onChange: ((Double) -> Void)? = nil,
        onHoverChange: ((Double?) -> Void)? = nil
    ) {
        self._value = value
        self.count = count
        self.allowHalf = allowHalf
        self.allowClear = allowClear
        self.disabled = disabled
        self.size = size
        self.character = character()
        self.onChange = onChange
        self.onHoverChange = onHoverChange
    }

    private var isEffectiveDisabled: Bool {
        !isEnabled || disabled
    }

    private var displayValue: Double {
        hoverValue ?? value
    }

    private var starSize: CGFloat {
        size.resolve(from: rateToken)
    }

    public var body: some View {
        HStack(spacing: rateToken.starGap) {
            ForEach(0..<count, id: \.self) { index in
                starView(for: index)
            }
        }
        .animation(.easeInOut(duration: token.motionDurationMid), value: value)
        .animation(.easeInOut(duration: token.motionDurationFast), value: hoverValue)
    }

    @ViewBuilder
    private func starView(for index: Int) -> some View {
        let fillRatio = calculateFillRatio(for: index)
        let isHovering = hoveringIndex == index

        ZStack {
            // Background (empty star)
            character
                .foregroundStyle(rateToken.starBg)

            // Filled overlay
            character
                .foregroundStyle(rateToken.starColor)
                .mask(alignment: .leading) {
                    GeometryReader { geo in
                        Rectangle()
                            .frame(width: geo.size.width * fillRatio)
                    }
                }
        }
        .font(.system(size: starSize))
        .frame(width: starSize, height: starSize)
        .scaleEffect(isHovering && !isEffectiveDisabled ? rateToken.starHoverScale : 1.0)
        .contentShape(Rectangle())
        .onContinuousHover { phase in
            guard !isEffectiveDisabled else {
                if case .active = phase {
                    NSCursor.operationNotAllowed.set()
                } else {
                    NSCursor.arrow.set()
                }
                return
            }

            switch phase {
            case .active(let location):
                NSCursor.pointingHand.set()
                hoveringIndex = index
                let newHoverValue = calculateValue(for: index, at: location.x, in: starSize)
                if hoverValue != newHoverValue {
                    hoverValue = newHoverValue
                    onHoverChange?(newHoverValue)
                }
            case .ended:
                NSCursor.arrow.set()
                hoveringIndex = nil
                if hoverValue != nil {
                    hoverValue = nil
                    onHoverChange?(nil)
                }
            }
        }
        .onTapGesture { location in
            guard !isEffectiveDisabled else { return }
            let tappedValue = calculateValue(for: index, at: location.x, in: starSize)
            if allowClear && tappedValue == value {
                value = 0
                onChange?(0)
            } else {
                value = tappedValue
                onChange?(tappedValue)
            }
        }
    }

    private func calculateFillRatio(for index: Int) -> CGFloat {
        let indexValue = Double(index)
        if displayValue >= indexValue + 1 {
            return 1.0
        } else if displayValue > indexValue {
            return displayValue - indexValue
        }
        return 0
    }

    private func calculateValue(for index: Int, at x: CGFloat, in width: CGFloat) -> Double {
        if allowHalf {
            let isFirstHalf = x < width / 2
            return Double(index) + (isFirstHalf ? 0.5 : 1.0)
        }
        return Double(index + 1)
    }
}

// MARK: - Default Character (Star)

public extension _Rate where Character == Image {
    init(
        value: Binding<Double>,
        count: Int = 5,
        allowHalf: Bool = false,
        allowClear: Bool = true,
        disabled: Bool = false,
        size: _RateSize = .medium,
        onChange: ((Double) -> Void)? = nil,
        onHoverChange: ((Double?) -> Void)? = nil
    ) {
        self.init(
            value: value,
            count: count,
            allowHalf: allowHalf,
            allowClear: allowClear,
            disabled: disabled,
            size: size,
            character: { Image(systemName: "star.fill") },
            onChange: onChange,
            onHoverChange: onHoverChange
        )
    }
}

// MARK: - Factory

public struct _MoinRateFactory {
    public typealias Size = _RateSize

    public init() {}

    /// 默认星形评分
    public func callAsFunction(
        value: Binding<Double>,
        count: Int = 5,
        allowHalf: Bool = false,
        allowClear: Bool = true,
        disabled: Bool = false,
        size: Size = .medium,
        onChange: ((Double) -> Void)? = nil,
        onHoverChange: ((Double?) -> Void)? = nil
    ) -> _Rate<Image> {
        _Rate(
            value: value,
            count: count,
            allowHalf: allowHalf,
            allowClear: allowClear,
            disabled: disabled,
            size: size,
            onChange: onChange,
            onHoverChange: onHoverChange
        )
    }

    /// 自定义字符评分
    public func callAsFunction<C: View>(
        value: Binding<Double>,
        count: Int = 5,
        allowHalf: Bool = false,
        allowClear: Bool = true,
        disabled: Bool = false,
        size: Size = .medium,
        @ViewBuilder character: () -> C,
        onChange: ((Double) -> Void)? = nil,
        onHoverChange: ((Double?) -> Void)? = nil
    ) -> _Rate<C> {
        _Rate(
            value: value,
            count: count,
            allowHalf: allowHalf,
            allowClear: allowClear,
            disabled: disabled,
            size: size,
            character: character,
            onChange: onChange,
            onHoverChange: onHoverChange
        )
    }
}

// MARK: - Environment Key

private struct MoinRateTokenKey: EnvironmentKey {
    static let defaultValue = Moin.RateToken.default
}

public extension EnvironmentValues {
    var moinRateToken: Moin.RateToken {
        get { self[MoinRateTokenKey.self] }
        set { self[MoinRateTokenKey.self] = newValue }
    }
}
