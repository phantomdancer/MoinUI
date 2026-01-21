import SwiftUI

public extension Moin {
    struct Statistic: View {
        @Environment(\.moinTheme) private var theme
        @Environment(\.moinToken) private var token
        @Environment(\.moinComponents) private var components
        
        let title: AnyView?
        let value: AnyView
        let prefix: AnyView?
        let suffix: AnyView?
        let loading: Bool
        let valueStyle: Font?

        public init(
            title: String? = nil,
            value: String,
            prefix: (any View)? = nil,
            suffix: (any View)? = nil,
            loading: Bool = false,
            valueStyle: Font? = nil
        ) {
            self.title = title.map { AnyView(Text($0)) }
            self.value = AnyView(Text(value))
            self.prefix = prefix.map { AnyView($0) }
            self.suffix = suffix.map { AnyView($0) }
            self.loading = loading
            self.valueStyle = valueStyle
        }

        public init<T: View>(
            title: T,
            value: String,
            prefix: (any View)? = nil,
            suffix: (any View)? = nil,
            loading: Bool = false,
            valueStyle: Font? = nil
        ) {
            self.title = AnyView(title)
            self.value = AnyView(Text(value))
            self.prefix = prefix.map { AnyView($0) }
            self.suffix = suffix.map { AnyView($0) }
            self.loading = loading
            self.valueStyle = valueStyle
        }
        
        public init<V: View>(
            title: String? = nil,
            value: V,
            prefix: (any View)? = nil,
            suffix: (any View)? = nil,
            loading: Bool = false,
            valueStyle: Font? = nil
        ) {
            self.title = title.map { AnyView(Text($0)) }
            self.value = AnyView(value)
            self.prefix = prefix.map { AnyView($0) }
            self.suffix = suffix.map { AnyView($0) }
            self.loading = loading
            self.valueStyle = valueStyle
        }

        public var body: some View {
            let statisticToken = components.statistic
            
            VStack(alignment: .leading, spacing: statisticToken.gap) {
                if let title = title {
                    title
                        .font(.system(size: statisticToken.titleFontSize))
                        .foregroundStyle(statisticToken.titleColor)
                }
                
                if loading {
                    RoundedRectangle(cornerRadius: 4)
                        .fill(Color.secondary.opacity(0.1))
                        .frame(width: 100, height: statisticToken.contentFontSize)
                } else {
                    HStack(spacing: statisticToken.contentGap) {
                        if let prefix = prefix {
                            prefix
                                .font(.system(size: statisticToken.contentFontSize))
                                .foregroundStyle(statisticToken.contentColor)
                        }
                        
                        value
                            .font(valueStyle ?? .system(size: statisticToken.contentFontSize))
                            .foregroundStyle(statisticToken.contentColor)
                        
                        if let suffix = suffix {
                            suffix
                                .font(.system(size: statisticToken.contentFontSize))
                                .foregroundStyle(statisticToken.contentColor)
                        }
                    }
                }
            }
        }
    }
}

// MARK: - Convenience Init for Numeric Values
public extension Moin.Statistic {
    init<N: BinaryFloatingPoint>(
        title: String? = nil,
        value: N,
        precision: Int? = 0,
        prefix: (any View)? = nil,
        suffix: (any View)? = nil,
        loading: Bool = false,
        valueStyle: Font? = nil
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
            loading: loading,
            valueStyle: valueStyle
        )
    }
    
    init<N: BinaryInteger>(
        title: String? = nil,
        value: N,
        prefix: (any View)? = nil,
        suffix: (any View)? = nil,
        loading: Bool = false,
        valueStyle: Font? = nil
    ) {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        let formattedValue = formatter.string(from: NSNumber(value: Int64(value))) ?? "\(value)"
        
        self.init(
            title: title,
            value: formattedValue,
            prefix: prefix,
            suffix: suffix,
            loading: loading,
            valueStyle: valueStyle
        )
    }
}
