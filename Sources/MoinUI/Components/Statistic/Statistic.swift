import SwiftUI


// MARK: - _Statistic (internal name, use Moin.Statistic.View)

/// 统计数值组件
public struct _Statistic: View {
    @Environment(\.moinTheme) private var theme
    @Environment(\.moinToken) private var token
    @Environment(\.moinComponents) private var components

    let title: AnyView?
    let value: AnyView
    let prefix: AnyView?
    let suffix: AnyView?
    let loading: Bool

    public init(
        title: String? = nil,
        value: String,
        prefix: (any View)? = nil,
        suffix: (any View)? = nil,
        loading: Bool = false
    ) {
        self.title = title.map { AnyView(Text($0)) }
        self.value = AnyView(Text(value))
        self.prefix = prefix.map { AnyView($0) }
        self.suffix = suffix.map { AnyView($0) }
        self.loading = loading
    }

    public init<T: View>(
        title: T,
        value: String,
        prefix: (any View)? = nil,
        suffix: (any View)? = nil,
        loading: Bool = false
    ) {
        self.title = AnyView(title)
        self.value = AnyView(Text(value))
        self.prefix = prefix.map { AnyView($0) }
        self.suffix = suffix.map { AnyView($0) }
        self.loading = loading
    }

    public init<V: View>(
        title: String? = nil,
        value: V,
        prefix: (any View)? = nil,
        suffix: (any View)? = nil,
        loading: Bool = false
    ) {
        self.title = title.map { AnyView(Text($0)) }
        self.value = AnyView(value)
        self.prefix = prefix.map { AnyView($0) }
        self.suffix = suffix.map { AnyView($0) }
        self.loading = loading
    }

    public var body: some View {
        let statisticToken = components.statistic

        VStack(alignment: .leading, spacing: token.marginXXS) { // Uses Global Token
            if let title = title {
                title
                    .font(.system(size: statisticToken.titleFontSize))
                    .foregroundStyle(token.colorTextSecondary)
            }

            if loading {
                RoundedRectangle(cornerRadius: 4)
                    .fill(Color.secondary.opacity(0.1))
                    .frame(width: 100, height: statisticToken.contentFontSize)
            } else {
                HStack(spacing: token.marginXXS) {
                    if let prefix = prefix {
                        prefix
                            .font(.system(size: statisticToken.contentFontSize))
                            .foregroundStyle(token.colorText)
                    }

                    value
                        .font(.system(size: statisticToken.contentFontSize))
                        .foregroundStyle(token.colorText)

                    if let suffix = suffix {
                        suffix
                            .font(.system(size: statisticToken.contentFontSize))
                            .foregroundStyle(token.colorText)
                    }
                }
            }
        }
    }
}

// MARK: - Convenience Init for Numeric Values
public extension _Statistic {
    init<N: BinaryFloatingPoint>(
        title: String? = nil,
        value: N,
        precision: Int? = 0,
        prefix: (any View)? = nil,
        suffix: (any View)? = nil,
        loading: Bool = false
    ) {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        if let precision = precision {
             formatter.minimumFractionDigits = precision
             formatter.maximumFractionDigits = precision
        }

        let formattedValue = formatter.string(from: NSNumber(value: Double(value))) ?? "\(value)"

        self.init(
            title: title,
            value: formattedValue,
            prefix: prefix,
            suffix: suffix,
            loading: loading
        )
    }

    init<N: BinaryInteger>(
        title: String? = nil,
        value: N,
        prefix: (any View)? = nil,
        suffix: (any View)? = nil,
        loading: Bool = false
    ) {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        let formattedValue = formatter.string(from: NSNumber(value: Int64(value))) ?? "\(value)"

        self.init(
            title: title,
            value: formattedValue,
            prefix: prefix,
            suffix: suffix,
            loading: loading
        )
    }
}


